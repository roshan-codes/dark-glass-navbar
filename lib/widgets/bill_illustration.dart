import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

class BillIllustration extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback? onNext;
  final int activePage;

  const BillIllustration({
    super.key,
    this.onPrevious,
    this.onNext,
    this.activePage = 0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // Radial Glowing Green Aura
          Container(
            width: 260,
            height: 210,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  AppColors.primaryGreen.withOpacity(0.28),
                  const Color(0xFF163815).withOpacity(0.4),
                  Colors.transparent,
                ],
                stops: const [0.0, 0.55, 1.0],
              ),
            ),
          ),

          // Sparkle 1 (Top Left)
          Positioned(
            top: 28,
            left: 56,
            child: _buildSparkle(16, const Color(0xFFC8F664)),
          ),

          // Sparkle 2 (Top Right)
          Positioned(
            top: 42,
            right: 52,
            child: _buildSparkle(20, const Color(0xFFB4F246)),
          ),

          // Sparkle 3 (Small Bottom Left)
          Positioned(
            bottom: 58,
            left: 72,
            child: _buildSparkle(10, const Color(0xFFD6FAA0)),
          ),

          // Left Arrow Button
          Positioned(
            left: 12,
            top: 86,
            child: _buildNavArrow(
              icon: Icons.arrow_back_rounded,
              onTap: onPrevious,
            ),
          ),

          // Right Arrow Button
          Positioned(
            right: 12,
            top: 86,
            child: _buildNavArrow(
              icon: Icons.arrow_forward_rounded,
              onTap: onNext,
            ),
          ),

          // Center 3D Folded Bill & Total Expenses Card
          Positioned(
            top: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // 3D Bill Graphic
                Transform.rotate(
                  angle: -0.05,
                  child: const BillCardGraphic(),
                ),

                const SizedBox(height: 6),

                // Floating Total Expenses Card
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total Expenses',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '₹18,460',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // Dots indicator
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (index) {
                    final isActive = index == activePage;
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 2.5),
                      width: isActive ? 12 : 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color: isActive ? Colors.white : Colors.white38,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSparkle(double size, Color color) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _SparklePainter(color: color),
      ),
    );
  }

  Widget _buildNavArrow({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 38,
        height: 38,
        decoration: BoxDecoration(
          color: const Color(0xFF141C15),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF263327), width: 1.2),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 18,
        ),
      ),
    );
  }
}

class _SparklePainter extends CustomPainter {
  final Color color;

  _SparklePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final cx = size.width / 2;
    final cy = size.height / 2;
    final path = Path();

    // 4-pointed sparkle
    path.moveTo(cx, 0);
    path.quadraticBezierTo(cx, cy, size.width, cy);
    path.quadraticBezierTo(cx, cy, cx, size.height);
    path.quadraticBezierTo(cx, cy, 0, cy);
    path.quadraticBezierTo(cx, cy, cx, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class BillCardGraphic extends StatelessWidget {
  const BillCardGraphic({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      height: 110,
      child: CustomPaint(
        painter: _BillPainter(),
      ),
    );
  }
}

class _BillPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Drop shadow
    final shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 12);

    final shadowPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(18, 14, size.width - 36, size.height - 20),
        const Radius.circular(16),
      ));
    canvas.drawPath(shadowPath, shadowPaint);

    // Bill Body (Vibrant Green Ribbon / Folded Cash Receipt)
    final billPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFB2F86D),
          Color(0xFF86E829),
          Color(0xFF67C919),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final billPath = Path();
    // Top wave
    billPath.moveTo(22, 12);
    billPath.cubicTo(50, 4, 90, 20, 118, 12);
    // Right curved edge
    billPath.cubicTo(126, 45, 120, 75, 114, 98);
    // Bottom serrated receipt teeth
    const teethCount = 7;
    const startX = 114.0;
    const endX = 26.0;
    const stepX = (startX - endX) / teethCount;
    for (int i = 0; i < teethCount; i++) {
      final currentX = startX - (i * stepX);
      final nextX = currentX - stepX;
      final toothY = (i % 2 == 0) ? 94.0 : 100.0;
      billPath.lineTo((currentX + nextX) / 2, toothY);
      billPath.lineTo(nextX, (i % 2 == 0) ? 100.0 : 94.0);
    }
    // Left edge
    billPath.cubicTo(20, 70, 16, 40, 22, 12);
    billPath.close();

    canvas.drawPath(billPath, billPaint);

    // Subtle 3D Fold overlay (darker green curl on the left side)
    final foldPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFF4C9911).withOpacity(0.45),
          Colors.transparent,
        ],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(const Rect.fromLTWH(16, 12, 35, 90));

    final foldPath = Path()
      ..moveTo(22, 12)
      ..cubicTo(32, 12, 36, 50, 32, 95)
      ..lineTo(22, 95)
      ..cubicTo(16, 50, 16, 30, 22, 12)
      ..close();
    canvas.drawPath(foldPath, foldPaint);

    // Rupee Symbol in Center
    final textPainter = TextPainter(
      text: const TextSpan(
        text: '₹',
        style: TextStyle(
          color: Color(0xFF23580D),
          fontSize: 52,
          fontWeight: FontWeight.w900,
          fontFamily: 'sans-serif',
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width) / 2 + 6, (size.height - textPainter.height) / 2 - 2),
    );

    // Subtle decorative dashed lines on top & bottom like receipt
    final dashPaint = Paint()
      ..color = const Color(0xFF4B9414).withOpacity(0.35)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(const Offset(38, 26), const Offset(102, 28), dashPaint);
    canvas.drawLine(const Offset(40, 84), const Offset(98, 82), dashPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

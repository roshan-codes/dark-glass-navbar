import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

class SplitMethodsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onConfirm;

  const SplitMethodsScreen({
    super.key,
    this.onBack,
    this.onConfirm,
  });

  @override
  State<SplitMethodsScreen> createState() => _SplitMethodsScreenState();
}

class _SplitMethodsScreenState extends State<SplitMethodsScreen> {
  int _selectedMethod = 0;

  final List<_SplitMethodItem> _methods = [
    _SplitMethodItem(
      title: 'Equal Split',
      description: 'Split the amount equally among all selected people',
      iconText: '=',
      iconBg: const Color(0xFFEAF8E2),
      iconColor: const Color(0xFF3DA310),
    ),
    _SplitMethodItem(
      title: 'Exact Amount',
      description: 'Specify exact amount for each person',
      iconText: '₹',
      iconBg: const Color(0xFFFDF0DE),
      iconColor: const Color(0xFFE5881E),
    ),
    _SplitMethodItem(
      title: 'Percentage',
      description: 'Split by a percentage (e.g. 50%, 30%, 20%)',
      iconText: '%',
      iconBg: const Color(0xFFF3EBFE),
      iconColor: const Color(0xFF8643E2),
    ),
    _SplitMethodItem(
      title: 'Shares',
      description: 'Split by shares (e.g. 2, 1, 1)',
      iconText: '👥',
      iconBg: const Color(0xFFE7F7DE),
      iconColor: const Color(0xFF389B10),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    // Top Bar
                    Row(
                      children: [
                        GestureDetector(
                          onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE8EFE6),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.02),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.arrow_back_rounded,
                              color: AppColors.textDark,
                              size: 20,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Text(
                          'Split Method',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Methods List
                    for (int i = 0; i < _methods.length; i++) ...[
                      _buildMethodCard(i, _methods[i]),
                      const SizedBox(height: 14),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom Confirm Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: widget.onConfirm ?? () => Navigator.of(context).maybePop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryGreen,
                    foregroundColor: const Color(0xFF0F2606),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    shadowColor: AppColors.primaryGreen.withOpacity(0.5),
                  ),
                  child: Text(
                    'Confirm',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodCard(int index, _SplitMethodItem item) {
    final isSelected = _selectedMethod == index;

    return GestureDetector(
      onTap: () => setState(() => _selectedMethod = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.primaryGreen : const Color(0xFFEAF0E7),
            width: isSelected ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(14),
              ),
              alignment: Alignment.center,
              child: Text(
                item.iconText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: item.iconColor,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    item.description,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textMuted,
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primaryGreen : Colors.transparent,
                border: Border.all(
                  color: isSelected ? AppColors.primaryGreen : const Color(0xFFCBD6C9),
                  width: 1.5,
                ),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      color: Color(0xFF102607),
                      size: 14,
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

class _SplitMethodItem {
  final String title;
  final String description;
  final String iconText;
  final Color iconBg;
  final Color iconColor;

  _SplitMethodItem({
    required this.title,
    required this.description,
    required this.iconText,
    required this.iconBg,
    required this.iconColor,
  });
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/avatar_widget.dart';

class SettleUpScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onRecordPayment;

  const SettleUpScreen({
    super.key,
    this.onBack,
    this.onRecordPayment,
  });

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
                  children: [
                    const SizedBox(height: 12),
                    // Top Bar
                    Row(
                      children: [
                        GestureDetector(
                          onTap: onBack ?? () => Navigator.of(context).maybePop(),
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
                          'Settle Up',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textDark,
                            letterSpacing: -0.3,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Paper Plane Graphic with Soft Green Glow
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryGreen.withOpacity(0.2),
                          ),
                        ),
                        Container(
                          width: 76,
                          height: 76,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primaryGreen.withOpacity(0.35),
                          ),
                        ),
                        Transform.rotate(
                          angle: -0.2,
                          child: const Icon(
                            Icons.send_rounded,
                            size: 42,
                            color: Color(0xFF43A311),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Title & Description
                    Text(
                      'Suggested Payments',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Clear all group dues with minimum transactions.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),

                    // Suggested Transactions
                    _buildPaymentSuggestionItem(
                      fromUser: AppUser.priya,
                      fromName: 'Priya',
                      toUser: AppUser.roshan,
                      toName: 'Roshan',
                      amount: '₹800',
                      onTap: onRecordPayment,
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentSuggestionItem(
                      fromUser: AppUser.aarav,
                      fromName: 'Aarav',
                      toUser: AppUser.roshan,
                      toName: 'Roshan',
                      amount: '₹250',
                      onTap: onRecordPayment,
                    ),
                    const SizedBox(height: 12),
                    _buildPaymentSuggestionItem(
                      fromUser: AppUser.neha,
                      fromName: 'Neha',
                      toUser: AppUser.roshan,
                      toName: 'Roshan',
                      amount: '₹150',
                      onTap: onRecordPayment,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // Bottom Button: Record a Payment
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: onRecordPayment,
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
                    'Record a Payment',
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

  Widget _buildPaymentSuggestionItem({
    required AppUser fromUser,
    required String fromName,
    required AppUser toUser,
    required String toName,
    required String amount,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFE9F0E6), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.02),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            AppAvatar(user: fromUser, size: 36),
            const SizedBox(width: 10),
            Text(
              fromName,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.arrow_forward_rounded,
              size: 16,
              color: Color(0xFF86A082),
            ),
            const SizedBox(width: 8),
            Text(
              toName,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const Spacer(),
            Text(
              amount,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1EB449),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


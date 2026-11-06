import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/avatar_widget.dart';

class AddExpenseScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onOpenSplitMethods;

  const AddExpenseScreen({
    super.key,
    this.onBack,
    this.onOpenSplitMethods,
  });

  @override
  State<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final Map<AppUser, bool> _selectedMembers = {
    AppUser.roshan: true,
    AppUser.priya: true,
    AppUser.aarav: true,
    AppUser.neha: false,
  };

  @override
  Widget build(BuildContext context) {
    final selectedCount = _selectedMembers.values.where((v) => v).length;

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
                    _buildTopBar(context),
                    const SizedBox(height: 24),

                    // Title
                    Text(
                      'Add Expense',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Field 1: Expense Title
                    _buildFieldLabel('Expense Title'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      leading: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF8E2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.restaurant_rounded,
                          color: Color(0xFF4FA81B),
                          size: 20,
                        ),
                      ),
                      child: Text(
                        'Dinner at Barbeque',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Field 2: Amount
                    _buildFieldLabel('Amount'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 6),
                        child: Text(
                          '₹',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                      child: Text(
                        '2,400',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Field 3: Category
                    _buildFieldLabel('Category'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      leading: const Icon(
                        Icons.restaurant_rounded,
                        color: Color(0xFF4FA81B),
                        size: 22,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textDark,
                        size: 24,
                      ),
                      child: Text(
                        'Food',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Field 4: Paid By
                    _buildFieldLabel('Paid By'),
                    const SizedBox(height: 8),
                    _buildInputField(
                      leading: const AppAvatar(
                        user: AppUser.priya,
                        size: 34,
                      ),
                      trailing: const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: AppColors.textDark,
                        size: 24,
                      ),
                      child: Text(
                        'Priya',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Field 5: Split Method
                    _buildFieldLabel('Split Method'),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: widget.onOpenSplitMethods,
                      child: _buildInputField(
                        trailing: const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textDark,
                          size: 24,
                        ),
                        child: Text(
                          'Equal Split',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textDark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 22),

                    // Field 6: Split Between (count selected)
                    Text(
                      'Split Between ($selectedCount selected)',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Avatar Chips Row (Matches poster design)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (final user in [
                          AppUser.roshan,
                          AppUser.priya,
                          AppUser.aarav,
                          AppUser.neha,
                        ]) ...[
                          _buildAvatarChip(user),
                          const SizedBox(width: 14),
                        ],
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Split Expense Button
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {},
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
                    'Split Expense',
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

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: widget.onBack ?? () => Navigator.of(context).maybePop(),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFFE8EFE6), width: 1.2),
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
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8EFE6), width: 1.2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.textDark, width: 1.4),
                ),
              ),
              Text(
                '₹',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildInputField({
    Widget? leading,
    required Widget child,
    Widget? trailing,
  }) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE3EDE1), width: 1.2),
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
          if (leading != null) ...[
            leading,
            const SizedBox(width: 12),
          ],
          Expanded(child: child),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Widget _buildAvatarChip(AppUser user) {
    final isChecked = _selectedMembers[user] ?? false;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMembers[user] = !isChecked;
        });
      },
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isChecked ? AppColors.primaryGreen : Colors.transparent,
                    width: 2.2,
                  ),
                ),
                child: AppAvatar(user: user, size: 48),
              ),
              if (isChecked)
                Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    width: 18,
                    height: 18,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryGreen,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Color(0xFF102607),
                      size: 13,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            user.name,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isChecked ? AppColors.textDark : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

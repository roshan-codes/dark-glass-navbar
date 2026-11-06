import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/avatar_widget.dart';

class ProfileScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateBottomNav;
  final VoidCallback? onOpenAddExpense;

  const ProfileScreen({
    super.key,
    this.onNavigateBottomNav,
    this.onOpenAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Profile',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 18),

                  // User Profile Card
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
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
                        const AppAvatar(
                          user: AppUser.roshan,
                          size: 52,
                          showBorder: true,
                          borderColor: AppColors.primaryGreen,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Roshan',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textDark,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Manage your account',
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.chevron_right_rounded,
                          color: Color(0xFFBDC8BB),
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),

                  // Settings Group Card
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(color: const Color(0xFFE9F0E6), width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildSettingRow(
                          icon: Icons.language_rounded,
                          title: 'Currency',
                          trailingText: 'INR (₹)',
                          showDivider: true,
                        ),
                        _buildSettingRow(
                          icon: Icons.brightness_medium_outlined,
                          title: 'Theme',
                          trailingText: 'Light',
                          showDivider: true,
                        ),
                        _buildSettingRow(
                          icon: Icons.splitscreen_rounded,
                          title: 'Default Split Method',
                          trailingText: 'Equal Split',
                          showDivider: true,
                        ),
                        _buildSettingRow(
                          icon: Icons.file_download_outlined,
                          title: 'Export Data',
                          trailingText: 'CSV, PDF',
                          showDivider: true,
                        ),
                        _buildSettingRow(
                          icon: Icons.cloud_upload_outlined,
                          title: 'Backup & Restore',
                          showDivider: true,
                        ),
                        _buildSettingRow(
                          icon: Icons.delete_outline_rounded,
                          title: 'Clear App Data',
                          isDanger: true,
                          showDivider: true,
                        ),
                        _buildSettingRow(
                          icon: Icons.info_outline_rounded,
                          title: 'About BillSplit',
                          trailingText: 'v1.0.0',
                          showChevron: false,
                          showDivider: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Nav Bar
            Positioned(
              left: 20,
              right: 20,
              bottom: 22,
              child: _buildBottomNavBar(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingRow({
    required IconData icon,
    required String title,
    String? trailingText,
    bool showChevron = true,
    bool showDivider = true,
    bool isDanger = false,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: isDanger ? const Color(0xFFE24343) : const Color(0xFF4A554A),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDanger ? const Color(0xFFE24343) : AppColors.textDark,
                  ),
                ),
              ),
              if (trailingText != null) ...[
                Text(
                  trailingText,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMuted,
                  ),
                ),
                const SizedBox(width: 4),
              ],
              if (showChevron)
                const Icon(
                  Icons.chevron_right_rounded,
                  color: Color(0xFFBDC8BB),
                  size: 20,
                ),
            ],
          ),
        ),
        if (showDivider)
          const Divider(
            height: 1,
            thickness: 1,
            color: Color(0xFFF1F6F0),
            indent: 16,
            endIndent: 16,
          ),
      ],
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      height: 68,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF111713),
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => onNavigateBottomNav?.call(0),
          ),
          IconButton(
            icon: const Icon(
              Icons.people_outline_rounded,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => onNavigateBottomNav?.call(1),
          ),
          GestureDetector(
            onTap: onOpenAddExpense,
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryGreen.withOpacity(0.4),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(
                Icons.add,
                color: Color(0xFF10210A),
                size: 28,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.access_time_rounded,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => onNavigateBottomNav?.call(3),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF284821), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.person_outline_rounded,
              color: AppColors.primaryGreen,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}


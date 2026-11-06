import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/avatar_widget.dart';
import '../widgets/bill_illustration.dart';

class DashboardScreen extends StatefulWidget {
  final VoidCallback? onOpenAddExpense;
  final VoidCallback? onOpenGoaTrip;

  const DashboardScreen({
    super.key,
    this.onOpenAddExpense,
    this.onOpenGoaTrip,
  });

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _isBalanceVisible = true;
  int _activeNavIndex = 0;
  int _activeCarouselPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      body: Stack(
        children: [
          // Scrollable Content
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(
              bottom: 110, // padding for floating bottom nav
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Dark Section
                SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        // User Header Row
                        _buildUserHeader(),
                        const SizedBox(height: 24),
                        // Overall Balance Block
                        _buildOverallBalance(),
                        const SizedBox(height: 14),
                        // 3D Bill Center Carousel
                        BillIllustration(
                          activePage: _activeCarouselPage,
                          onPrevious: () {
                            setState(() {
                              _activeCarouselPage = (_activeCarouselPage - 1 + 3) % 3;
                            });
                          },
                          onNext: () {
                            setState(() {
                              _activeCarouselPage = (_activeCarouselPage + 1) % 3;
                            });
                          },
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),

                // Balance Summary Section (Lime Gradient Container)
                _buildBalanceSummarySection(),

                // Your Groups Section (Clean White Container)
                _buildYourGroupsSection(),
              ],
            ),
          ),

          // Floating Bottom Navigation Bar
          Positioned(
            left: 20,
            right: 20,
            bottom: 22,
            child: _buildBottomNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildUserHeader() {
    return Row(
      children: [
        // Avatar with online status ring
        Stack(
          children: [
            const AppAvatar(
              user: AppUser.roshan,
              size: 46,
              showBorder: true,
              borderColor: Color(0xFF263327),
            ),
            Positioned(
              right: 2,
              bottom: 2,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.darkBackground, width: 2),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(width: 12),
        // Greeting & Tagline
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Roshan',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Split bills, track and settle',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF8B9B8E),
                ),
              ),
            ],
          ),
        ),
        // Add Contact / User Icon Button
        _buildCircleButton(
          icon: Icons.person_add_alt_outlined,
          onTap: () {},
        ),
        const SizedBox(width: 10),
        // Bell Icon Button with notification dot
        Stack(
          clipBehavior: Clip.none,
          children: [
            _buildCircleButton(
              icon: Icons.notifications_none_rounded,
              onTap: () {},
            ),
            Positioned(
              top: 6,
              right: 8,
              child: Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  color: AppColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCircleButton({required IconData icon, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF18221A),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF28362B), width: 1.2),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 19,
        ),
      ),
    );
  }

  Widget _buildOverallBalance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overall Balance',
          style: GoogleFonts.plusJakartaSans(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xFF8B9B8E),
          ),
        ),
        const SizedBox(height: 6),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              _isBalanceVisible ? '₹1,240' : '••••••',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 34,
                fontWeight: FontWeight.w800,
                color: Colors.white,
                letterSpacing: -1,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'You get',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF112608),
                ),
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                setState(() => _isBalanceVisible = !_isBalanceVisible);
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF18221A),
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF28362B), width: 1.2),
                ),
                child: Icon(
                  _isBalanceVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: Colors.white70,
                  size: 19,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildBalanceSummarySection() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF86E829),
            Color(0xFF9CF03B),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(18, 20, 18, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Balance Summary',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 15,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              // Signal/Equalizer Bars Icon
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildSignalBar(6, const Color(0xFF326310)),
                  const SizedBox(width: 2.5),
                  _buildSignalBar(10, const Color(0xFF326310)),
                  const SizedBox(width: 2.5),
                  _buildSignalBar(14, const Color(0xFF326310)),
                  const SizedBox(width: 2.5),
                  _buildSignalBar(18, const Color(0xFF326310)),
                  const SizedBox(width: 2.5),
                  _buildSignalBar(13, const Color(0xFF326310)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // 3 Balance Cards
          Row(
            children: [
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.arrow_outward_rounded,
                  iconColor: const Color(0xFF289928),
                  iconBg: const Color(0xFFE2F7DB),
                  label: 'You get',
                  value: '₹2,850',
                  valueColor: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.arrow_downward_rounded,
                  iconColor: const Color(0xFFE65D28),
                  iconBg: const Color(0xFFFDECE5),
                  label: 'You owe',
                  value: '₹1,610',
                  valueColor: AppColors.textDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildMetricCard(
                  icon: Icons.drag_handle_rounded,
                  iconColor: const Color(0xFF2EA24A),
                  iconBg: const Color(0xFFE2F7DB),
                  label: 'Net',
                  value: '₹1,240',
                  valueColor: const Color(0xFF229E41),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSignalBar(double height, Color color) {
    return Container(
      width: 3.5,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String label,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.textMuted,
            ),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w800,
                color: valueColor,
                letterSpacing: -0.3,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildYourGroupsSection() {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFFF9FBF8),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      padding: const EdgeInsets.fromLTRB(20, 22, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Your Groups',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'See All',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF48A613),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // 3 Group Cards
          Row(
            children: [
              Expanded(
                child: _buildGroupItemCard(
                  emoji: '🌴',
                  iconBg: const Color(0xFFFDF0DC),
                  title: 'Goa Trip',
                  members: '4 members',
                  onTap: widget.onOpenGoaTrip,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGroupItemCard(
                  emoji: '💻',
                  iconBg: const Color(0xFFE5F7DF),
                  title: 'Office',
                  members: '6 members',
                  onTap: () {},
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildGroupItemCard(
                  emoji: '🏠',
                  iconBg: const Color(0xFFF2EAFE),
                  title: 'Flat',
                  members: '3 members',
                  onTap: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGroupItemCard({
    required String emoji,
    required Color iconBg,
    required String title,
    required String members,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFFEFF5ED), width: 1.2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                emoji,
                style: const TextStyle(fontSize: 22),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2),
            Text(
              members,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
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
          // Home Tab (Index 0)
          GestureDetector(
            onTap: () => setState(() => _activeNavIndex = 0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                border: _activeNavIndex == 0
                    ? Border.all(color: const Color(0xFF284821), width: 1.5)
                    : null,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.home_outlined,
                color: _activeNavIndex == 0 ? AppColors.primaryGreen : Colors.white70,
                size: 24,
              ),
            ),
          ),

          // Groups Tab (Index 1)
          IconButton(
            icon: Icon(
              Icons.people_outline_rounded,
              color: _activeNavIndex == 1 ? AppColors.primaryGreen : Colors.white70,
              size: 24,
            ),
            onPressed: () => setState(() => _activeNavIndex = 1),
          ),

          // Central Glowing + Button
          GestureDetector(
            onTap: widget.onOpenAddExpense,
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

          // Clock / History Tab (Index 2)
          IconButton(
            icon: Icon(
              Icons.access_time_rounded,
              color: _activeNavIndex == 2 ? AppColors.primaryGreen : Colors.white70,
              size: 24,
            ),
            onPressed: () => setState(() => _activeNavIndex = 2),
          ),

          // Profile Tab (Index 3)
          IconButton(
            icon: Icon(
              Icons.person_outline_rounded,
              color: _activeNavIndex == 3 ? AppColors.primaryGreen : Colors.white70,
              size: 24,
            ),
            onPressed: () => setState(() => _activeNavIndex = 3),
          ),
        ],
      ),
    );
  }
}

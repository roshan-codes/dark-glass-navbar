import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

class ActivityScreen extends StatefulWidget {
  final ValueChanged<int>? onNavigateBottomNav;
  final VoidCallback? onOpenAddExpense;

  const ActivityScreen({
    super.key,
    this.onNavigateBottomNav,
    this.onOpenAddExpense,
  });

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Expenses', 'Settlements', 'Groups'];

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
                    'Activity',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textDark,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Filter Pills
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        for (int i = 0; i < _filters.length; i++) ...[
                          GestureDetector(
                            onTap: () => setState(() => _selectedFilter = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: _selectedFilter == i
                                    ? const Color(0xFF111713)
                                    : const Color(0xFFEDF3EB),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                _filters[i],
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12.5,
                                  fontWeight: _selectedFilter == i
                                      ? FontWeight.w700
                                      : FontWeight.w600,
                                  color: _selectedFilter == i
                                      ? Colors.white
                                      : AppColors.textMuted,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Section "Today"
                  _buildDateSectionHeader('Today'),
                  const SizedBox(height: 12),
                  _buildActivityItem(
                    icon: Icons.send_rounded,
                    iconBg: const Color(0xFFE5F7DE),
                    iconColor: const Color(0xFF389B10),
                    title: 'Settlement',
                    subtitle: 'Priya paid ₹800 to Roshan',
                    time: '10:24 AM',
                  ),
                  const SizedBox(height: 10),
                  _buildActivityItem(
                    icon: Icons.restaurant_rounded,
                    iconBg: const Color(0xFFEAF8E2),
                    iconColor: const Color(0xFF48A613),
                    title: 'Expense Added',
                    subtitle: 'Dinner at Barbeque • ₹2,400',
                    time: '9:12 AM',
                  ),
                  const SizedBox(height: 24),

                  // Section "Yesterday"
                  _buildDateSectionHeader('Yesterday'),
                  const SizedBox(height: 12),
                  _buildActivityItem(
                    icon: Icons.hotel_rounded,
                    iconBg: const Color(0xFFEAF8E2),
                    iconColor: const Color(0xFF48A613),
                    title: 'Expense Added',
                    subtitle: 'Hotel Stay • ₹8,000',
                    time: '6:40 PM',
                  ),
                  const SizedBox(height: 10),
                  _buildActivityItem(
                    icon: Icons.group_add_outlined,
                    iconBg: const Color(0xFFFDF0DE),
                    iconColor: const Color(0xFFE5881E),
                    title: 'Group Created',
                    subtitle: 'Goa Trip group created',
                    time: '11:20 AM',
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

  Widget _buildDateSectionHeader(String title) {
    return Text(
      title,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
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
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Text(
            time,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF96A597),
            ),
          ),
        ],
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
          IconButton(
            icon: const Icon(
              Icons.home_outlined,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => widget.onNavigateBottomNav?.call(0),
          ),
          IconButton(
            icon: const Icon(
              Icons.people_outline_rounded,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => widget.onNavigateBottomNav?.call(1),
          ),
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF284821), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.access_time_rounded,
              color: AppColors.primaryGreen,
              size: 24,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => widget.onNavigateBottomNav?.call(4),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';

class GroupsListScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateBottomNav;
  final VoidCallback? onOpenGroupDetails;
  final VoidCallback? onOpenAddExpense;

  const GroupsListScreen({
    super.key,
    this.onNavigateBottomNav,
    this.onOpenGroupDetails,
    this.onOpenAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    final groups = [
      _GroupItemData(
        emoji: '🌴',
        iconBg: const Color(0xFFFDF0DE),
        name: 'Goa Trip',
        members: '4 members',
        balanceText: 'You get ₹1,200',
        balanceColor: const Color(0xFF1EB449),
      ),
      _GroupItemData(
        emoji: '💻',
        iconBg: const Color(0xFFE5F7DF),
        name: 'Office Lunch',
        members: '6 members',
        balanceText: 'You owe ₹410',
        balanceColor: const Color(0xFFE86022),
      ),
      _GroupItemData(
        emoji: '🏠',
        iconBg: const Color(0xFFF2EAFE),
        name: 'Flat Expenses',
        members: '3 members',
        balanceText: 'You get ₹450',
        balanceColor: const Color(0xFF1EB449),
      ),
      _GroupItemData(
        emoji: '🚗',
        iconBg: const Color(0xFFE1F0FE),
        name: 'Leh Trip',
        members: '5 members',
        balanceText: 'Settled',
        balanceColor: AppColors.textMuted,
      ),
      _GroupItemData(
        emoji: '🍴',
        iconBg: const Color(0xFFFDECE5),
        name: 'Friends Dinner',
        members: '4 members',
        balanceText: 'You owe ₹230',
        balanceColor: const Color(0xFFE86022),
      ),
    ];

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
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Groups',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: const Color(0xFFE4EDE1),
                                width: 1.2,
                              ),
                            ),
                            child: const Icon(
                              Icons.search_rounded,
                              color: AppColors.textDark,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 10),
                          GestureDetector(
                            onTap: onOpenAddExpense,
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: const BoxDecoration(
                                color: AppColors.primaryGreen,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Color(0xFF122807),
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // Group Cards List
                  for (final item in groups) ...[
                    _buildGroupCard(item, onTap: onOpenGroupDetails),
                    const SizedBox(height: 12),
                  ],
                ],
              ),
            ),

            // Floating Bottom Nav Bar
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

  Widget _buildGroupCard(_GroupItemData item, {VoidCallback? onTap}) {
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
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: item.iconBg,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                item.emoji,
                style: const TextStyle(fontSize: 24),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  RichText(
                    text: TextSpan(
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textMuted,
                      ),
                      children: [
                        TextSpan(text: '${item.members} • '),
                        TextSpan(
                          text: item.balanceText,
                          style: TextStyle(
                            color: item.balanceColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
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
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFF284821), width: 1.5),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.people_outline_rounded,
              color: AppColors.primaryGreen,
              size: 24,
            ),
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
          IconButton(
            icon: const Icon(
              Icons.person_outline_rounded,
              color: Colors.white70,
              size: 24,
            ),
            onPressed: () => onNavigateBottomNav?.call(4),
          ),
        ],
      ),
    );
  }
}

class _GroupItemData {
  final String emoji;
  final Color iconBg;
  final String name;
  final String members;
  final String balanceText;
  final Color balanceColor;

  _GroupItemData({
    required this.emoji,
    required this.iconBg,
    required this.name,
    required this.members,
    required this.balanceText,
    required this.balanceColor,
  });
}


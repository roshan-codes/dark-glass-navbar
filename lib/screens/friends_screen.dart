import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/avatar_widget.dart';

class FriendsScreen extends StatelessWidget {
  final ValueChanged<int>? onNavigateBottomNav;
  final VoidCallback? onOpenAddExpense;

  const FriendsScreen({
    super.key,
    this.onNavigateBottomNav,
    this.onOpenAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    final friends = [
      _FriendData(
        user: AppUser.priya,
        name: 'Priya',
        status: 'You get ₹800',
        amount: '+ ₹800',
        isPositive: true,
      ),
      _FriendData(
        user: AppUser.aarav,
        name: 'Aarav',
        status: 'You get ₹250',
        amount: '+ ₹250',
        isPositive: true,
      ),
      _FriendData(
        user: AppUser.neha,
        name: 'Neha',
        status: 'You get ₹150',
        amount: '+ ₹150',
        isPositive: true,
      ),
      _FriendData(
        user: AppUser.james,
        name: 'James',
        status: 'You owe ₹410',
        amount: '- ₹410',
        isPositive: false,
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
                        'Friends',
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

                  // Friends List
                  for (final friend in friends) ...[
                    _buildFriendCard(friend),
                    const SizedBox(height: 12),
                  ],
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

  Widget _buildFriendCard(_FriendData friend) {
    return Container(
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
          AppAvatar(user: friend.user, size: 44),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  friend.status,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                friend.amount,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w800,
                  color: friend.isPositive
                      ? const Color(0xFF1EB449)
                      : const Color(0xFFE86022),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right_rounded,
                color: Color(0xFFBDC8BB),
                size: 20,
              ),
            ],
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

class _FriendData {
  final AppUser user;
  final String name;
  final String status;
  final String amount;
  final bool isPositive;

  _FriendData({
    required this.user,
    required this.name,
    required this.status,
    required this.amount,
    required this.isPositive,
  });
}


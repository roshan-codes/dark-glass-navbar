import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/colors.dart';
import '../widgets/avatar_widget.dart';

class GroupDetailsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final VoidCallback? onOpenSettleUp;
  final VoidCallback? onOpenExpenseDetails;
  final int initialTab;

  const GroupDetailsScreen({
    super.key,
    this.onBack,
    this.onOpenSettleUp,
    this.onOpenExpenseDetails,
    this.initialTab = 0,
  });

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  late int _activeTab;

  @override
  void initState() {
    super.initState();
    _activeTab = widget.initialTab;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7FAF7),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Bar
                  _buildTopBar(context),
                  const SizedBox(height: 20),

                  // Group Hero Header
                  _buildGroupHeader(),
                  const SizedBox(height: 24),

                  // Segmented Tabs (Expenses, Balances, Members)
                  _buildSegmentedTabs(),
                  const SizedBox(height: 18),

                  // Tab 0: Expenses
                  if (_activeTab == 0) ...[
                    _buildSummaryCard(),
                    const SizedBox(height: 26),
                    Text(
                      'Expenses',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    const SizedBox(height: 14),
                    _buildExpenseItem(
                      icon: Icons.restaurant_rounded,
                      iconBg: const Color(0xFFEAF8E2),
                      iconColor: const Color(0xFF48A613),
                      title: 'Dinner at Barbeque',
                      subtitle: 'Paid by Priya',
                      amount: '₹2,400',
                      date: 'May 15',
                      onTap: widget.onOpenExpenseDetails,
                    ),
                    _buildExpenseItem(
                      icon: Icons.hotel_rounded,
                      iconBg: const Color(0xFFEAF8E2),
                      iconColor: const Color(0xFF48A613),
                      title: 'Hotel Stay',
                      subtitle: 'Paid by You',
                      amount: '₹8,000',
                      date: 'May 14',
                      onTap: widget.onOpenExpenseDetails,
                    ),
                    _buildExpenseItem(
                      icon: Icons.directions_car_rounded,
                      iconBg: const Color(0xFFFDF0DE),
                      iconColor: const Color(0xFFE5881E),
                      title: 'Cab to Beach',
                      subtitle: 'Paid by Aarav',
                      amount: '₹1,260',
                      date: 'May 13',
                      onTap: widget.onOpenExpenseDetails,
                    ),
                    _buildExpenseItem(
                      icon: Icons.shopping_cart_outlined,
                      iconBg: const Color(0xFFEAF8E2),
                      iconColor: const Color(0xFF48A613),
                      title: 'Groceries',
                      subtitle: 'Paid by Neha',
                      amount: '₹740',
                      date: 'May 12',
                      onTap: widget.onOpenExpenseDetails,
                    ),
                  ],

                  // Tab 1: Balances
                  if (_activeTab == 1) ...[
                    const SizedBox(height: 8),
                    _buildBalanceMemberItem(
                      user: AppUser.roshan,
                      name: 'Roshan (You)',
                      details: 'Paid ₹8,000 • Share ₹6,800',
                      balance: '+ ₹1,200',
                      isPositive: true,
                    ),
                    _buildBalanceMemberItem(
                      user: AppUser.priya,
                      name: 'Priya',
                      details: 'Paid ₹2,400 • Share ₹3,200',
                      balance: '- ₹800',
                      isPositive: false,
                    ),
                    _buildBalanceMemberItem(
                      user: AppUser.aarav,
                      name: 'Aarav',
                      details: 'Paid ₹1,260 • Share ₹1,510',
                      balance: '- ₹250',
                      isPositive: false,
                    ),
                    _buildBalanceMemberItem(
                      user: AppUser.neha,
                      name: 'Neha',
                      details: 'Paid ₹740 • Share ₹890',
                      balance: '- ₹150',
                      isPositive: false,
                    ),
                  ],

                  // Tab 2: Members
                  if (_activeTab == 2) ...[
                    const SizedBox(height: 8),
                    _buildMemberRow(user: AppUser.roshan, name: 'Roshan (You)'),
                    _buildMemberRow(user: AppUser.priya, name: 'Priya'),
                    _buildMemberRow(user: AppUser.aarav, name: 'Aarav'),
                    _buildMemberRow(user: AppUser.neha, name: 'Neha'),
                  ],
                ],
              ),
            ),

            // Bottom Floating Action Button
            Positioned(
              left: 20,
              right: 20,
              bottom: 22,
              child: _activeTab == 2 ? _buildAddMemberButton() : _buildSettleUpButton(),
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
            Icons.more_vert_rounded,
            color: AppColors.textDark,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildGroupHeader() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
            width: 82,
            height: 82,
            child: Image.network(
              'https://images.unsplash.com/photo-1512343879784-a960bf40e7f2?auto=format&fit=crop&w=300&q=80',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE6A045),
                  alignment: Alignment.center,
                  child: const Text('🌴', style: TextStyle(fontSize: 34)),
                );
              },
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Goa Trip',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                  letterSpacing: -0.4,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                '4 members',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 32,
                child: Row(
                  children: [
                    _buildAvatarStack(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAvatarStack() {
    const double avatarSize = 28;
    const double overlap = 18;

    return SizedBox(
      width: (avatarSize * 4) - (overlap * 2) + 12,
      height: avatarSize,
      child: Stack(
        children: [
          const Positioned(
            left: 0,
            child: AppAvatar(
              user: AppUser.roshan,
              size: avatarSize,
              showBorder: true,
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          ),
          const Positioned(
            left: overlap,
            child: AppAvatar(
              user: AppUser.priya,
              size: avatarSize,
              showBorder: true,
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          ),
          const Positioned(
            left: overlap * 2,
            child: AppAvatar(
              user: AppUser.aarav,
              size: avatarSize,
              showBorder: true,
              borderColor: Colors.white,
              borderWidth: 1.5,
            ),
          ),
          Positioned(
            left: overlap * 3,
            child: Container(
              width: avatarSize,
              height: avatarSize,
              decoration: BoxDecoration(
                color: const Color(0xFFF1F5F0),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 1.5),
              ),
              child: const Icon(
                Icons.add,
                size: 16,
                color: AppColors.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSegmentedTabs() {
    final tabs = ['Expenses', 'Balances', 'Members'];

    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFEDF2EC),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          for (int i = 0; i < tabs.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _activeTab = i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: const EdgeInsets.symmetric(vertical: 9),
                  decoration: BoxDecoration(
                    color: _activeTab == i ? const Color(0xFF111713) : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: _activeTab == i
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.15),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    tabs[i],
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      fontWeight: _activeTab == i ? FontWeight.w700 : FontWeight.w600,
                      color: _activeTab == i ? Colors.white : AppColors.textMuted,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9F8E1),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Group Total',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF556E52),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹18,460',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 38,
            color: const Color(0xFFD3EAC8),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Your Balance',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF556E52),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '+ ₹1,200',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF1CB044),
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpenseItem({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
    required String amount,
    required String date,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 21),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14.5,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  amount,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  date,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceMemberItem({
    required AppUser user,
    required String name,
    required String details,
    required String balance,
    required bool isPositive,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AppAvatar(user: user, size: 40),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  details,
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
            balance,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 15,
              fontWeight: FontWeight.w800,
              color: isPositive ? const Color(0xFF1EB449) : const Color(0xFFE86022),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberRow({
    required AppUser user,
    required String name,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          AppAvatar(user: user, size: 40),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert_rounded,
              color: AppColors.textMuted,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSettleUpButton() {
    return GestureDetector(
      onTap: widget.onOpenSettleUp,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF111713),
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.28),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Transform.rotate(
              angle: -0.3,
              child: const Icon(
                Icons.send_rounded,
                color: AppColors.primaryGreen,
                size: 19,
              ),
            ),
            const SizedBox(width: 10),
            Text(
              'Settle Up',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddMemberButton() {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: AppColors.primaryGreen,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryGreen.withOpacity(0.35),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            color: Color(0xFF102607),
            size: 22,
          ),
          const SizedBox(width: 8),
          Text(
            'Add Member',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF102607),
            ),
          ),
        ],
      ),
    );
  }
}

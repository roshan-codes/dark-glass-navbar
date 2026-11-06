import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/colors.dart';
import 'screens/dashboard_screen.dart';
import 'screens/groups_list_screen.dart';
import 'screens/group_details_screen.dart';
import 'screens/add_expense_screen.dart';
import 'screens/split_methods_screen.dart';
import 'screens/expense_details_screen.dart';
import 'screens/settle_up_screen.dart';
import 'screens/record_settlement_screen.dart';
import 'screens/friends_screen.dart';
import 'screens/activity_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const BillSplitterApp());
}

class BillSplitterApp extends StatelessWidget {
  const BillSplitterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BillSplit',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.darkBackground,
        textTheme: GoogleFonts.plusJakartaSansTextTheme(),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryGreen,
          brightness: Brightness.light,
        ),
      ),
      home: const MainShowcase(),
    );
  }
}

class MainShowcase extends StatefulWidget {
  const MainShowcase({super.key});

  @override
  State<MainShowcase> createState() => _MainShowcaseState();
}

class _MainShowcaseState extends State<MainShowcase> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;
  bool _showSwitcher = true;

  final List<String> _screenTitles = [
    '1. Home (Dashboard)',
    '2. Groups List',
    '3. Group Details (Expenses)',
    '4. Group Balances',
    '5. Group Members',
    '6. Add Expense',
    '7. Split Methods',
    '8. Expense Details',
    '9. Settle Up (Suggestions)',
    '10. Record Settlement',
    '11. Friends',
    '12. Activity',
    '13. Profile & Settings',
  ];

  void _navigateToPage(int index) {
    if (index < 0 || index >= _screenTitles.length) return;
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeInOutCubic,
    );
  }

  void _handleBottomNav(int navIndex) {
    switch (navIndex) {
      case 0: // Home
        _navigateToPage(0);
        break;
      case 1: // Groups
        _navigateToPage(1);
        break;
      case 2: // Add Expense (+)
        _navigateToPage(5);
        break;
      case 3: // Activity
        _navigateToPage(11);
        break;
      case 4: // Profile
        _navigateToPage(12);
        break;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkScreen = _currentIndex == 0;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDarkScreen ? Brightness.light : Brightness.dark,
      ),
    );

    return Scaffold(
      backgroundColor: isDarkScreen ? AppColors.darkBackground : const Color(0xFFF7FAF7),
      body: Stack(
        children: [
          // All 13 Screens in PageView
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: [
              // 1. Home (Dashboard)
              DashboardScreen(
                onOpenAddExpense: () => _navigateToPage(5),
                onOpenGoaTrip: () => _navigateToPage(2),
              ),

              // 2. Groups List
              GroupsListScreen(
                onNavigateBottomNav: _handleBottomNav,
                onOpenGroupDetails: () => _navigateToPage(2),
                onOpenAddExpense: () => _navigateToPage(5),
              ),

              // 3. Group Details (Expenses)
              GroupDetailsScreen(
                key: const ValueKey('tab-0'),
                initialTab: 0,
                onBack: () => _navigateToPage(1),
                onOpenSettleUp: () => _navigateToPage(8),
                onOpenExpenseDetails: () => _navigateToPage(7),
              ),

              // 4. Group Balances
              GroupDetailsScreen(
                key: const ValueKey('tab-1'),
                initialTab: 1,
                onBack: () => _navigateToPage(1),
                onOpenSettleUp: () => _navigateToPage(8),
                onOpenExpenseDetails: () => _navigateToPage(7),
              ),

              // 5. Group Members
              GroupDetailsScreen(
                key: const ValueKey('tab-2'),
                initialTab: 2,
                onBack: () => _navigateToPage(1),
                onOpenSettleUp: () => _navigateToPage(8),
                onOpenExpenseDetails: () => _navigateToPage(7),
              ),

              // 6. Add Expense
              AddExpenseScreen(
                onBack: () => _navigateToPage(0),
                onOpenSplitMethods: () => _navigateToPage(6),
              ),

              // 7. Split Methods
              SplitMethodsScreen(
                onBack: () => _navigateToPage(5),
                onConfirm: () => _navigateToPage(5),
              ),

              // 8. Expense Details
              ExpenseDetailsScreen(
                onBack: () => _navigateToPage(2),
                onEdit: () => _navigateToPage(5),
                onDelete: () => _navigateToPage(2),
              ),

              // 9. Settle Up (Suggestions)
              SettleUpScreen(
                onBack: () => _navigateToPage(2),
                onRecordPayment: () => _navigateToPage(9),
              ),

              // 10. Record Settlement
              RecordSettlementScreen(
                onBack: () => _navigateToPage(8),
                onMarkSettled: () => _navigateToPage(2),
              ),

              // 11. Friends
              FriendsScreen(
                onNavigateBottomNav: _handleBottomNav,
                onOpenAddExpense: () => _navigateToPage(5),
              ),

              // 12. Activity
              ActivityScreen(
                onNavigateBottomNav: _handleBottomNav,
                onOpenAddExpense: () => _navigateToPage(5),
              ),

              // 13. Profile & Settings
              ProfileScreen(
                onNavigateBottomNav: _handleBottomNav,
                onOpenAddExpense: () => _navigateToPage(5),
              ),
            ],
          ),

          // Top Floating Screen Switcher Drawer / Pill
          if (_showSwitcher)
            Positioned(
              top: 4,
              left: 12,
              right: 12,
              child: SafeArea(
                bottom: false,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isDarkScreen
                          ? Colors.black.withOpacity(0.75)
                          : Colors.white.withOpacity(0.92),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isDarkScreen
                            ? Colors.white.withOpacity(0.18)
                            : Colors.black.withOpacity(0.08),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.18),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Left Arrow
                        GestureDetector(
                          onTap: () => _navigateToPage(_currentIndex - 1),
                          child: Icon(
                            Icons.chevron_left_rounded,
                            size: 20,
                            color: isDarkScreen ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 4),

                        // Dropdown Selector with all 13 screens
                        DropdownButtonHideUnderline(
                          child: DropdownButton<int>(
                            value: _currentIndex,
                            isDense: true,
                            dropdownColor: const Color(0xFF161E17),
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 16,
                              color: isDarkScreen ? Colors.white70 : Colors.black87,
                            ),
                            items: [
                              for (int i = 0; i < _screenTitles.length; i++)
                                DropdownMenuItem(
                                  value: i,
                                  child: Text(
                                    _screenTitles[i],
                                    style: GoogleFonts.plusJakartaSans(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      color: _currentIndex == i
                                          ? AppColors.primaryGreen
                                          : Colors.white,
                                    ),
                                  ),
                                ),
                            ],
                            onChanged: (newIdx) {
                              if (newIdx != null) _navigateToPage(newIdx);
                            },
                            selectedItemBuilder: (context) {
                              return [
                                for (int i = 0; i < _screenTitles.length; i++)
                                  Center(
                                    child: Text(
                                      _screenTitles[i],
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: isDarkScreen
                                            ? AppColors.primaryGreen
                                            : const Color(0xFF1B6E09),
                                      ),
                                    ),
                                  ),
                              ];
                            },
                          ),
                        ),
                        const SizedBox(width: 4),

                        // Right Arrow
                        GestureDetector(
                          onTap: () => _navigateToPage(_currentIndex + 1),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            size: 20,
                            color: isDarkScreen ? Colors.white70 : Colors.black87,
                          ),
                        ),
                        const SizedBox(width: 6),

                        // Close Switcher Toggle
                        GestureDetector(
                          onTap: () => setState(() => _showSwitcher = false),
                          child: Icon(
                            Icons.close_rounded,
                            size: 14,
                            color: isDarkScreen ? Colors.white38 : Colors.black38,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dark_glassmorphic_bottom_bar/dark_glassmorphic_bottom_bar.dart';

void main() {
  testWidgets('DarkGlassmorphicBottomBar renders and switches tabs correctly', (WidgetTester tester) async {
    int selectedIndex = 0;
    bool actionTapped = false;

    await tester.pumpWidget(
      MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Scaffold(
              bottomNavigationBar: DarkGlassmorphicBottomBar(
                selectedIndex: selectedIndex,
                onTabSelected: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                centerAction: DarkGlassActionItem(
                  icon: Icons.add,
                  onTap: () {
                    actionTapped = true;
                  },
                ),
                items: const [
                  DarkGlassNavItem(
                    icon: Icons.home_outlined,
                    activeIcon: Icons.home_rounded,
                    label: 'Home',
                  ),
                  DarkGlassNavItem(
                    icon: Icons.people_outline_rounded,
                    activeIcon: Icons.people_rounded,
                    label: 'Friends',
                  ),
                  DarkGlassNavItem(
                    icon: Icons.access_time_rounded,
                    activeIcon: Icons.access_time_filled_rounded,
                    label: 'Activity',
                  ),
                  DarkGlassNavItem(
                    icon: Icons.person_outline_rounded,
                    activeIcon: Icons.person_rounded,
                    label: 'Profile',
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    // Initial state: index 0 is active (home_rounded is rendered)
    expect(find.byIcon(Icons.home_rounded), findsOneWidget);

    // Tap on friends tab (tab index 1)
    final friendsTab = find.byIcon(Icons.people_outline_rounded);
    expect(friendsTab, findsOneWidget);
    await tester.tap(friendsTab);
    await tester.pumpAndSettle();

    expect(selectedIndex, 1);
    expect(find.byIcon(Icons.people_rounded), findsOneWidget);

    // Tap on center action button (+)
    final addAction = find.byIcon(Icons.add);
    expect(addAction, findsOneWidget);
    await tester.tap(addAction);
    await tester.pumpAndSettle();

    expect(actionTapped, isTrue);
  });
}

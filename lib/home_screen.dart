import 'package:flutter/material.dart';
import 'browse_events_screen.dart';
import 'my_bookings_screen.dart';
import 'profile_screen.dart';
import 'organizer_events_screen.dart';
import 'auth_store.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isOrganizer = AuthStore.currentUser?.isOrganizer ?? false;

    final List<Widget> screens = [
      const BrowseEventsScreen(),
      const MyBookingsScreen(),
      if (isOrganizer) const OrganizerEventsScreen(),
      const ProfileScreen(),
    ];

    final List<BottomNavigationBarItem> navItems = [
      const BottomNavigationBarItem(
        icon: Icon(Icons.event),
        label: 'Events',
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.confirmation_number),
        label: 'My Bookings',
      ),
      if (isOrganizer)
        const BottomNavigationBarItem(
          icon: Icon(Icons.manage_accounts),
          label: 'My Events',
        ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.person),
        label: 'Profile',
      ),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: navItems,
      ),
    );
  }
}
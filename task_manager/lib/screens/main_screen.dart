import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:io' show Platform;
import '../theme/app_colors.dart';
import 'tasks/tasks_screen.dart';
import 'settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  
  final List<Widget> _screens = [
    const TasksScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final isIOS = !kIsWeb && Platform.isIOS;
    if (isIOS) {
      return _buildIOSLayout();
    } else {
      return _buildAndroidLayout();
    }
  }
  
  Widget _buildIOSLayout() {
    final colors = context.colors;
    
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        backgroundColor: colors.tabBarBackground,
        activeColor: colors.tabBarIconActive,
        inactiveColor: colors.tabBarIcon,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.calendar_today),
            label: 'Today',
          ),
          BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.settings),
            label: 'Settings',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) => _screens[index],
        );
      },
    );
  }
  
  Widget _buildAndroidLayout() {
    final colors = context.colors;
    
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        backgroundColor: colors.tabBarBackground,
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon: Icon(Icons.calendar_today),
            label: 'Today',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
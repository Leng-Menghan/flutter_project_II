import 'package:flutter/material.dart';

import '../l10n/app_localization.dart';
import '../models/user.dart';
import 'screens/budget_goal_screen.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/statistic.dart';

class AppRoot extends StatefulWidget {
  final User user;
  final ValueChanged<Language> onChangeLanguage;
  const AppRoot({super.key, required this.user, required this.onChangeLanguage});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final language = AppLocalizations.of(context)!;
    return Scaffold(
      body: IndexedStack(
        index: _currentTabIndex,
        children: [
          HomeScreen(key: ValueKey(_currentTabIndex) ,user: widget.user),
          StatisticScreen(key: ValueKey(_currentTabIndex), user: widget.user),
          BudgetGoalScreen(user: widget.user),
          ProfileScreen(
            user: widget.user, 
            onSelectLanguage: widget.onChangeLanguage
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20), 
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, 
            borderRadius: BorderRadius.circular(20), 
            border: Border.all(color: const Color.fromARGB(255, 239, 238, 238), width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4), 
              ),
            ]
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20), 
            child: BottomNavigationBar(
              elevation: 10,
              type: BottomNavigationBarType.fixed, 
              selectedItemColor: Color(0xFF438883),
              unselectedItemColor: Colors.grey,
              currentIndex: _currentTabIndex,
              onTap: (index) {
                setState(() => _currentTabIndex = index);
              },
              items: [
                BottomNavigationBarItem(icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.house_rounded),
                ), label: language.home),
                BottomNavigationBarItem(icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.bar_chart_rounded),
                ), label: language.statistic),
                BottomNavigationBarItem(icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.track_changes),
                ), label: language.budgetGoal),
                BottomNavigationBarItem(icon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  child: Icon(Icons.person),
                ), label: language.profile),
              ],
            ),
          )
        )
      )
    );
  }
}
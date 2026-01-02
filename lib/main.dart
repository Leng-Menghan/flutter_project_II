import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'data/mock_data.dart';
import 'l10n/app_localization.dart';
import 'models/user.dart';
import 'ui/screens/statistic.dart';
import 'ui/screens/budget_goal_screen.dart';
import 'ui/screens/profile.dart';
import 'ui/screens/home.dart';

void main() async {
  runApp(MyApp(user: user));
}

class MyApp extends StatefulWidget {
  final User user;
  const MyApp({super.key, required this.user});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentTabIndex = 0;
  late Language selectedLanguage;
  @override
  void initState() {
    selectedLanguage = widget.user.preferredLanguage;
    super.initState();
  }

  Locale whichLocale(Language language) {
    switch (language) {
      case Language.english:
        return const Locale('en');
      case Language.khmer:
        return const Locale('km');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
        ).copyWith(primary: Color(0xFF438883), secondary: Color(0xFF63B5AF)),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 16),
          titleMedium: TextStyle(fontSize: 14),
          titleSmall: TextStyle(fontSize: 12),
        ),
      ),
      debugShowCheckedModeBanner: false,
      locale: whichLocale(selectedLanguage),
      supportedLocales: const [Locale('en'), Locale('km')],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: Scaffold(
        body: IndexedStack(
          index: _currentTabIndex,
          children: [
            HomeScreen(user: widget.user),
            StatisticScreen(user: widget.user),
            BudgetGoalScreen(user: widget.user),
            ProfileScreen(
              user: widget.user,
              onSelectLanguage: (value) => setState(() {
                selectedLanguage = value;
              }),
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
              border: Border.all(
                color: const Color.fromARGB(255, 239, 238, 238),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
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
                items: const [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.house_rounded),
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.bar_chart_rounded),
                    ),
                    label: 'Statistic',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.track_changes),
                    ),
                    label: 'Budget Goal',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Icon(Icons.person),
                    ),
                    label: 'Profile',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

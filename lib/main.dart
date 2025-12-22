import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './l10n/app_localization.dart'; 
import 'ui/screens/splash.dart';
import 'ui/screens/home.dart';
import 'ui/screens/add_Transaction.dart';
import 'ui/screens/onboarding.dart';
import 'ui/screens/onboarding.dart';
import 'ui/screens/profile.dart';
import 'ui/screens/inspect_category.dart';
import 'ui/screens/inspect_statistic.dart';
import 'ui/screens/inspect_transaction.dart';
import 'ui/screens/create_budget.dart';
import './data/mock_data.dart';
void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.cyan,
        )
        .copyWith(
          primary: Color(0xFF438883),
          secondary: Color(0xFF63B5AF),
        ),
        textTheme: TextTheme(
          displayLarge: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontSize: 16),
          titleMedium: TextStyle(fontSize: 14),
          titleSmall: TextStyle(fontSize: 12)
        )
      ),
      debugShowCheckedModeBanner: false,
      locale: Locale('en'),
      supportedLocales: const [
        Locale('en'), // English
        Locale('km'), // Khmer
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home:null
    ),
  );
}


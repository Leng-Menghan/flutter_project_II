import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/share_reference.dart';
import 'data/sqlite.dart';
import 'l10n/app_localization.dart';
import 'models/user.dart';
import 'ui/app_root.dart';
import 'ui/screens/select_language.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Sqlite.dropDatabase();
  // await ShareReference.remove();
  // runApp(
  //   MaterialApp(
  //     home: Scaffold(
  //       body: Center(
  //         child: Text("Hello"),
  //       ),
  //     ),
  //   )
  // );
  bool isCreated = await ShareReference.isCreated();
  User? user;

  if(isCreated) {
    Map<String, dynamic> userInfo = await ShareReference.readUserInfo();
    user = User(
      name:userInfo['name'],
      profileImage: "",
      preferredLanguage: userInfo['language'],
      preferredAmountType: userInfo['amountType'],
      transactions: await Sqlite.getTransactions(),
      budgetGoals: await Sqlite.getBudgetGoals(),
    );
  }
  runApp(MyApp(user: user));
}

class MyApp extends StatefulWidget {
  final User? user;
  const MyApp({super.key, required this.user});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;

  Locale _mapLanguageToLocale(Language language) {
    switch (language) {
      case Language.khmer:
        return const Locale('km');
      case Language.english:
        return const Locale('en');
    }
  }
  
  @override
  void initState() {
    super.initState();
      if(widget.user != null){
        _locale = _mapLanguageToLocale(widget.user!.preferredLanguage);
      }
  }

  void changeLanguage(Language language) {
    setState(() {
      _locale = _mapLanguageToLocale(language);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan).copyWith(
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
      locale: _locale,
      supportedLocales: const [
        Locale('en'), 
        Locale('km'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: widget.user == null ? LanguageScreen(onSelectLanguage: changeLanguage,) : AppRoot(user: widget.user!, onChangeLanguage: changeLanguage,),
    );
  }
}





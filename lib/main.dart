import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoappp/firebase_options.dart';
import 'package:todoappp/home/auth/login/login_screen.dart';
import 'package:todoappp/home/auth/register/register_screen.dart';
import 'package:todoappp/providers/app_config_provider.dart';
import 'package:todoappp/providers/list_provider.dart';
import 'package:todoappp/providers/user_provider.dart';
import 'home/home_screen.dart';
import 'apptheme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  /*options:const FirebaseOptions(
          apiKey: "AIzaSyASClUGg1MWFSVdVlDltEp9pF6pCBQOJ3E",
          appId: "com.example.app",
          messagingSenderId: "530814202175",
          projectId: "todoappp-affe3"));*/
  await FirebaseFirestore.instance.enableNetwork();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ListProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AppConfigProvider(),
        ),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: LoginScreen.routeName,
      routes: {
        HomeScreen.routeName: (context) => const HomeScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        LoginScreen.routeName: (context) => LoginScreen()
      },
      title: 'To-Do App',
      theme: MyThemeData.lightTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: provider.appMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale(provider.appLanguage),
    );
  }
}

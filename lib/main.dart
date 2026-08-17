import 'dart:async';

import 'package:flutter/material.dart' hide Banner;
import 'package:flutter_tapsell_mediation_example/navigation/routes.dart';
import 'package:flutter_tapsell_mediation_example/screens/banner.dart';
import 'package:flutter_tapsell_mediation_example/screens/home.dart';
import 'package:flutter_tapsell_mediation_example/screens/interstitial.dart';
import 'package:flutter_tapsell_mediation_example/screens/native.dart';
import 'package:flutter_tapsell_mediation_example/screens/rewarded.dart';
import 'package:tapsell_mediation/tapsell.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _log = '';

  @override
  void initState() {
    super.initState();
    setUserConsent(true);
  }

  void addLog(String message) {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() {
      _log = '$message\n$_log';
    });
  }

  Future<void> setUserConsent(bool consent) async {
    Tapsell.setUserConsent(consent);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: NavRoutes.home,
      theme: ThemeData(
        primaryColor: Colors.deepOrange,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.deepOrange),
      ),
      routes: {
        NavRoutes.home: (context) => const Home(),
        NavRoutes.rewarded: (context) => const Rewarded(),
        NavRoutes.interstitial: (context) => const Interstitial(),
        NavRoutes.banner: (context) => const Banner(),
        NavRoutes.native: (context) => const Native(),
      },
    );
  }
}

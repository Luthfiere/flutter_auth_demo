import 'package:demo/UI/homescreen.dart';
import 'package:demo/services/shared_service.dart';
import 'package:flutter/material.dart';
import 'UI/loginscreen.dart';

Widget _defaultHome = const Loginscreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool result = await SharedService.isLoggedIn();
  if (result) {
    _defaultHome = const Homescreen();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => _defaultHome,
        '/login': (context) => const Loginscreen(),
        '/home': (context) => const Homescreen(),
      },
    );
  }
}

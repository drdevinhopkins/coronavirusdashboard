// import 'DatabaseService.dart';
import 'HomeScreen.dart';

import 'UserRepository.dart';
import 'package:provider/provider.dart';

import 'DashboardScreen.dart';
import 'package:flutter/material.dart';

import 'DatabaseService.dart';
import 'Feed.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => DatabaseService(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => UserRepository(),
        ),
      ],
      child: MaterialApp(
        title: 'JGH Coronavirus Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        initialRoute: '/home',
        routes: {
          '/feed': (context) => Feed(),
          '/dashboard': (context) => DashboardScreen(),
          '/home': (context) => HomeScreen()
        },
      ),
    );
  }
}

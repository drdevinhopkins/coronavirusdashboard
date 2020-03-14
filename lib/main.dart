// import 'DatabaseService.dart';
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
      ],
      child: MaterialApp(
        title: 'JGH Coronavirus Dashboard',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: DashboardScreen(),
        routes: {
          '/feed': (context) => Feed(),
        },
      ),
    );
  }
}

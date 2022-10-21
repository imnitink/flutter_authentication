import 'package:flutter/material.dart';
import 'package:flutter_authentication/screens/home.dart';
import 'package:flutter_authentication/screens/login_page.dart';
import 'package:flutter_authentication/theme/theme_state.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeState>(
      create: (_) => ThemeState(),
      child: MaterialApp(
        title: 'Movies App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,backgroundColor: const Color(0xff59BEE6)),
        home: LoginPage(),
      ),
    );
  }
}



// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:invoice_generator/screen/home_screen.dart';
import 'package:invoice_generator/screen/invoice.dart';

import 'screen/pro_cart.dart';
import 'screen/pro_detail.dart';

void main() {
  runApp(
    HomePage(),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => FirstPage(),
        'cart': (context) => CartPage(),
        'detail': (context) => DetailPage(),
        'invoice': (context) => Invoice(),
      },
    );
  }
}

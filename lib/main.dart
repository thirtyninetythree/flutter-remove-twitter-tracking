import 'package:flutter/material.dart';
import 'package:remove_tracking/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Remove Tracking',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: const HomePage(),
  ));
}

// Suggested code may be subject to a license. Learn more: ~LicenseLog:1905962937.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:956337401.
// Suggested code may be subject to a license. Learn more: ~LicenseLog:1037339882.
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: const Center(
        child: Text('Hello World!'),
      ),
    );
  }
}

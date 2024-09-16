import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './data/expense_data.dart';
import './pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // init hive
  await Hive.initFlutter();
  await Hive.openBox('expenses_database');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        title: 'My Grocery Today',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme:
              ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 72, 71, 75)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'My Grocery Today'),
      ),
    );
  }
}

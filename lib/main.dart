import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import './data/expense_data.dart';
import './pages/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  // Inisialisasi Hive
  await Hive.initFlutter();
  await Hive.openBox('expenses_database');

  runApp(const MyApp());
}

/// Widget utama aplikasi dengan tema premium.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        title: 'My Grocery Today',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme(
            brightness: Brightness.light,
            primary: const Color(0xFF6C63FF),
            onPrimary: Colors.white,
            secondary: const Color(0xFFFF6584),
            onSecondary: Colors.white,
            surface: const Color(0xFFF8F9FA),
            onSurface: const Color(0xFF2D3436),
            background: const Color(0xFFF0F2F5),
            onBackground: const Color(0xFF2D3436),
            error: const Color(0xFFE74C3C),
            onError: Colors.white,
            outline: const Color(0xFFE0E0E0),
            shadow: const Color(0xFF000000).withOpacity(0.1),
          ),
          fontFamily: 'Poppins',
          cardTheme: CardTheme(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            titleTextStyle: TextStyle(
              color: Color(0xFF2D3436),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            iconTheme: IconThemeData(color: Color(0xFF2D3436)),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFF6C63FF),
            foregroundColor: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: const Color(0xFFF8F9FA),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF6C63FF), width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
        home: const MyHomePage(title: 'Pengeluaran Saya'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/theme/app_theme.dart';
import 'presentation/injection/injection_container.dart' as di;
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Hive
  await Hive.initFlutter();

  // Inisialisasi Dependency Injection
  await di.initDependencies();

  runApp(const MyApp());
}

/// Aplikasi utama My Grocery Today
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Grocery Today',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: BlocProvider(
        create: (_) => di.sl<di.ExpenseBloc>()..add(const di.LoadExpenses()),
        child: const HomePage(),
      ),
    );
  }
}

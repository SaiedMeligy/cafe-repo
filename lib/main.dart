import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

// Models
import 'models/device.dart';
import 'models/product.dart';
import 'models/session.dart';
import 'models/daily_report.dart';
import 'screens/dashboard_screen.dart';

import 'services/database_service.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [DeviceSchema, ProductSchema, PlaySessionSchema, DailyReportSchema],
    directory: dir.path,
  );
  
  // Auto-seed data on first launch
  final dbService = DatabaseService(isar);
  await dbService.checkAndSeedData();

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(isar),
      ],
      child: const GameCafeApp(),
    ),
  );
}

final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError();
});

class GameCafeApp extends StatelessWidget {
  const GameCafeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'مدير المقهى',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', 'EG'),
      ],
      locale: const Locale('ar', 'EG'),
      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child!,
        );
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFD700), // Gold
          brightness: Brightness.dark,
          surface: const Color(0xFF111111),
        ),
        scaffoldBackgroundColor: Colors.black,
        textTheme: GoogleFonts.cairoTextTheme(ThemeData.dark().textTheme),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: const Color(0xFF111111),
          elevation: 4,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Color(0xFF333333), width: 1),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),
      home: const DashboardScreen(),
    );
  }
}

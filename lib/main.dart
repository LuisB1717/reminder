import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reminder/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  runApp(const Reminder());
}

class Reminder extends StatelessWidget {
  const Reminder({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recordatorios',
      theme: ThemeData(
        shadowColor: Colors.transparent,
        colorScheme: ColorScheme.light(
          surface: Colors.grey.shade500,
          secondary: Colors.grey.shade900,
          onSecondary: Colors.white,
          primary: const Color(0XFFe2ff41),
          onPrimary: Colors.black,
        ),
        hintColor: Colors.grey.shade700,
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          surfaceTintColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        cardColor: Colors.white,
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
    );
  }
}

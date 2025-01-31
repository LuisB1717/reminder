import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:reminder/pages/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');

  await Supabase.initialize(
    url: dotenv.get('SUPABASE_URL'),
    anonKey: dotenv.get('SUPABASE_ANON_KEY'),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FirebaseMessaging.instance.requestPermission();

  await FirebaseMessaging.instance.getAPNSToken();

  final apnsToken = await FirebaseMessaging.instance.getToken();

  if (apnsToken != null) {
    await Supabase.instance.client
        .from('notification_tokens')
        .insert({'token': apnsToken});
  }

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
    Supabase.instance.client
        .from('notification_tokens')
        .insert({'token': fcmToken});
  }).onError((err) {
    print(err);
  });

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
        colorScheme: ColorScheme.dark(
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
        textTheme: GoogleFonts.poppinsTextTheme(),
      ),
      home: const HomePage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('es', 'PE'),
      ],
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:memecloud/core/getit.dart';
import 'package:memecloud/blocs/song_player/justaudio_init.dart';
import 'package:memecloud/core/theme.dart';
import 'package:memecloud/routes/main.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await setupLocator();
  await justAudioInit();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: MaterialTheme(
        GoogleFonts.bricolageGrotesqueTextTheme(),
      ).theme(MaterialTheme.lightScheme()),
      dark: MaterialTheme(
        GoogleFonts.bricolageGrotesqueTextTheme(),
      ).theme(MaterialTheme.darkScheme()),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          routerConfig: getRouter(),
        );
      },
    );
  }
}

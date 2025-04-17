import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:meme_cloud/common/supabase.dart';
import 'package:meme_cloud/core/audio/audio_manager.dart';

import 'package:meme_cloud/presentation/view/dashboard.dart';
import 'package:meme_cloud/presentation/view/start_view.dart';
import 'package:meme_cloud/core/service_locator.dart';
import 'package:provider/provider.dart' as provider_package;

import 'package:meme_cloud/core/configs/theme/theme_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: 'assets/.env');
    print('Đã load thành công file .env');
  } catch (e) {
    print('Lỗi khi load .env: $e'); // In ra lỗi nếu có
    throw Exception('Không thể load file .env');
  }
  //await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'].toString(),
    anonKey: dotenv.env['SUPABASE_ANON_KEY'].toString(),
    authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
  );

  await initServiceLocator();

  runApp(
    provider_package.ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meme Cloud',
      theme: provider_package.Provider.of<ThemeProvider>(context).themeData,
      home: const MyApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  User? _user;
  late final StreamSubscription<AuthState> _authSubscription;

  @override
  void initState() {
    serviceLocator<AudioManager>().init();
    _authSubscription = supabase.auth.onAuthStateChange.listen(
      _handleAuthChange,
    );
    super.initState();
  }

  void _handleAuthChange(AuthState data) {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;
    if (mounted) {
      setState(() {
        _user = session?.user;
      });
    }

    if (event == AuthChangeEvent.signedIn) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const DashBoard()),
        (route) => false,
      );
    }
    if (event == AuthChangeEvent.signedOut) {
      print('signout');
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const StartView()),
        (route) => false,
      );
    }
  }

  @override
  void dispose() {
    _authSubscription.cancel(); // Quan trọng: hủy subscription
    serviceLocator<AudioManager>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user != null ? const DashBoard() : const StartView(),
    );
  }
}

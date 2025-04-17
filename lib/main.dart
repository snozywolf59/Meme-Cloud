import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:memecloud/presentation/ui/gradient_background.dart';
import 'package:memecloud/presentation/view/misc/404.dart';
import 'package:memecloud/presentation/view/auth/log_in_view.dart';
import 'package:memecloud/presentation/view/auth/sign_up_view.dart';
import 'package:memecloud/presentation/view/home/home_view.dart';
// import 'package:memecloud/presentation/view/play_music_view.dart';
import 'package:memecloud/presentation/view/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:memecloud/presentation/view/song_player/song_player_view.dart';
import 'package:memecloud/presentation/view/auth/start_view.dart';
import 'package:memecloud/core/service_locator.dart' show initDependencies;
import 'package:memecloud/core/theme.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Widget pageWithGradientBackground(
  BuildContext context,
  GoRouterState state,
  Widget body,
) {
  return Stack(children: [GradientBackground(state.fullPath), body]);
}

final GoRouter _router = GoRouter(
  initialLocation:
      Supabase.instance.client.auth.currentSession != null
          ? '/home'
          : '/startview',
  errorBuilder: (context, state) {
    return pageWithGradientBackground(
      context,
      state,
      PageNotFound(routePath: state.uri.toString()),
    );
  },
  routes: [
    ShellRoute(
      builder: pageWithGradientBackground,
      routes: [
        GoRoute(
          path: '/404',
          builder: (context, state) => PageNotFound(routePath: '/404'),
        ),
        GoRoute(path: '/home', builder: (context, state) => HomeView()),
        GoRoute(path: '/search', builder: (context, state) => const SearchView()),
        GoRoute(path: '/play_music', builder: (context, state) => SongPlayerView())
      ],
    ),
    GoRoute(path: '/startview', builder: (context, state) => StartView()),
    GoRoute(path: '/signup', builder: (context, state) => SignUpView()),
    GoRoute(path: '/login', builder: (context, state) => LogInView()),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL'].toString(),
    anonKey: dotenv.env['SUPABASE_ANON_KEY'].toString(),
    authOptions: FlutterAuthClientOptions(authFlowType: AuthFlowType.pkce),
  );

  await initDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: MaterialTheme.lightScheme(),
      ),
      dark: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        colorScheme: MaterialTheme.darkScheme(),
      ),
      initial: AdaptiveThemeMode.system,
      builder: (theme, darkTheme) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: theme,
          darkTheme: darkTheme,
          routerConfig: _router,
        );
      },
    );
  }
}

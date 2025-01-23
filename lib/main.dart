import 'package:catfish_mobile/features/callHub/screens/call_hub.dart';
import 'package:catfish_mobile/features/onboarding/screens/index.dart';
import 'package:catfish_mobile/routes/constants/app_screens.dart';
import 'package:catfish_mobile/stores/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  MyApp({super.key});

  final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  @override
  Widget build(BuildContext context, ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Colors.transparent,
        useMaterial3: true,
        textTheme: GoogleFonts.aBeeZeeTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: GoRouter(
        initialLocation: ref.read(userProvider).firstTimeOpen ? AppScreens.onBoarding : AppScreens.callHub,
        routes: [
          ShellRoute(
            navigatorKey: _shellNavigatorKey,
            builder: (BuildContext context, GoRouterState state, Widget child) => Stack(
              children: [
                Image.asset(
                  "assets/images/mobile-background.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
                SafeArea(
                  child: Scaffold(
                    body: ref.read(userProvider).firstTimeOpen ? OnBoardingScreen() : CallHub(),
                  ),
                ),
              ],
            ),
            routes: [
              GoRoute(
                path: AppScreens.onBoarding,
                builder: (context, state) {
                  return OnBoardingScreen();
                },
              ),
              GoRoute(
                path: AppScreens.callHub,
                builder: (context, state) {
                  return CallHub();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

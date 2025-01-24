import 'package:catfish_mobile/features/callHub/screens/call_hub.dart';
import 'package:catfish_mobile/features/onboarding/screens/index.dart';
import 'package:catfish_mobile/routes/constants/app_screens.dart';
import 'package:catfish_mobile/routes/layouts/app_layout.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
        initialLocation: AppScreens.callHub,
        routes: [
          ShellRoute(
            builder: (BuildContext context, GoRouterState state, Widget child) => AppLayout(
              child: child,
            ),
            routes: [
              GoRoute(
                path: AppScreens.onBoarding,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: OnBoardingScreen(),
                  );
                },
              ),
              GoRoute(
                path: AppScreens.callHub,
                pageBuilder: (context, state) {
                  return NoTransitionPage(
                    child: CallHub(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

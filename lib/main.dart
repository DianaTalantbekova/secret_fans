import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_fans/screens/create_pass.dart';
import 'package:secret_fans/screens/onboarding1.dart';
import 'package:secret_fans/screens/onboarding2.dart';

void main() => runZonedGuarded(() {
      runApp(
        ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (
            BuildContext context,
            Widget? child,
          ) =>
              const MyApp(),
        ),
      );
    }, (error, stack) {
      if (kDebugMode) {
        print(error);
        print(stack);
      }
    });

CustomTransitionPage buildPageWithDefaultTransition({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  bool opaque = true,
}) {
  return CustomTransitionPage(
    key: state.pageKey,
    child: child,
    transitionDuration: Duration.zero,
    opaque: opaque,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;

  @override
  void initState() {
    _router = GoRouter(
      initialLocation: '/onboarding1',
      routes: [
        GoRoute(
          path: '/onboarding1',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const OnBoarding1(),
          ),
        ),
        GoRoute(
          path: '/onboarding2',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const OnBoarding2(),
          ),
        ),
        GoRoute(
          path: '/create_pass',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const CreatePass(),
          ),
        ),
        // ShellRoute(
        //   pageBuilder: (context, state, child) {
        //     final hasBottomBar = !state.fullPath!.contains('game');
        //     return buildPageWithDefaultTransition(
        //       context: context,
        //       state: state,
        //       child: hasBottomBar ? NavigationScreen(child: child) : child,
        //     );
        //   },
        //   routes: [
        //     GoRoute(
        //       path: '/level',
        //       pageBuilder: (context, state) => buildPageWithDefaultTransition(
        //         context: context,
        //         state: state,
        //         child: const LevelScreen(),
        //       ),
        //       routes: [
        //         GoRoute(
        //           path: 'game',
        //           pageBuilder: (context, state) =>
        //               buildPageWithDefaultTransition(
        //             context: context,
        //             state: state,
        //             child: const GameScreen(),
        //           ),
        //         )
        //       ],
        //     ),
        //     GoRoute(
        //       path: '/store',
        //       pageBuilder: (context, state) => buildPageWithDefaultTransition(
        //         context: context,
        //         state: state,
        //         child: const StoreScreen(),
        //       ),
        //     ),
        //     GoRoute(
        //       path: '/settings',
        //       pageBuilder: (context, state) => buildPageWithDefaultTransition(
        //         context: context,
        //         state: state,
        //         child: const SettingsScreen(),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

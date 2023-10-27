import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:secret_fans/screens/add_to_favourites_screen.dart';
import 'package:secret_fans/screens/bin_screen.dart';
import 'package:secret_fans/screens/contacts_screen.dart';
import 'package:secret_fans/screens/create_pass.dart';
import 'package:secret_fans/screens/edit_contact_in_folder.dart';
import 'package:secret_fans/screens/contact_info.dart';
import 'package:secret_fans/screens/favourites_screen.dart';
import 'package:secret_fans/screens/folders_screen.dart';
import 'package:secret_fans/screens/home_screen.dart';
import 'package:secret_fans/screens/move_folders_screen.dart';
import 'package:secret_fans/screens/navigation_screen.dart';
import 'package:secret_fans/screens/onboarding1.dart';
import 'package:secret_fans/screens/onboarding2.dart';
import 'package:secret_fans/screens/opened_folder_screen.dart';
import 'package:secret_fans/screens/password_change.dart';
import 'package:secret_fans/screens/password_screen.dart';
import 'package:secret_fans/screens/premium_screen.dart';
import 'package:secret_fans/screens/create_new_contact.dart';
import 'package:secret_fans/screens/settings_screen.dart';
import 'package:secret_fans/screens/tags_screen.dart';

void main() => runZonedGuarded(() {
      runApp(
        ScreenUtilInit(
          designSize: const Size(390, 840),
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
      initialLocation: '/home_screen',
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
        GoRoute(
          path: '/premium_screen',
          pageBuilder: (context, state) => buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const PremiumScreen(),
          ),
        ),
        ShellRoute(
          pageBuilder: (context, state, child) =>
              buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: NavigationScreen(child: child),
          ),
          routes: [
            GoRoute(
              path: '/home_screen',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const HomeScreen(),
              ),
            ),
            GoRoute(
              path: '/favourites_screen',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const FavouritesScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'add_to_favourites_screen',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const AddToFavouritesScreen(),
                      ),
                ),
              ]
            ),
            GoRoute(
              path: '/contacts_screen',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const ContactsScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'create_new_contact',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const CreateNewContact(),
                  ),
                ),
                GoRoute(
                  path: 'contact_info',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const ContactInfo(),
                  ),
                ),
              ],
            ),
            GoRoute(
              path: '/folders_screen',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const FoldersScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'opened_folder_screen',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const OpenedFolderScreen(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'edit_contact_in_folder',
                      pageBuilder: (context, state) =>
                          buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const EditContactInFolder(),
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'move_folder_screen',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const MoveFoldersScreen(),
                      ),
                ),
              ],
            ),
            GoRoute(
              path: '/settings_screen',
              pageBuilder: (context, state) => buildPageWithDefaultTransition(
                context: context,
                state: state,
                child: const SettingsScreen(),
              ),
              routes: [
                // GoRoute(
                //   path: 'password_screen',
                //   pageBuilder: (context, state) =>
                //       buildPageWithDefaultTransition(
                //         context: context,
                //         state: state,
                //         child: const PasswordScreen(),
                //       ),
                // ),
                GoRoute(
                  path: 'password_change',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const PasswordChange(),
                  ),
                ),
                GoRoute(
                  path: 'tags_screen',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const TagsScreen(),
                  ),
                ),
                GoRoute(
                  path: 'bin_screen',
                  pageBuilder: (context, state) => buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const BinScreen(),
                  ),
                ),
              ]
            ),
          ],
        ),
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

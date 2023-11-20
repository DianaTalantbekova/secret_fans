import 'dart:async';

import 'package:apphud/apphud.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:koshumcha/koshumcha.dart';
import 'package:provider/provider.dart';
import 'package:secret_fans/managers/contacts_manager.dart';
import 'package:secret_fans/managers/favorite_manager.dart';
import 'package:secret_fans/managers/folders_manager.dart';
import 'package:secret_fans/managers/password_manager.dart';
import 'package:secret_fans/managers/premium_manager.dart';
import 'package:secret_fans/managers/recent_manager.dart';
import 'package:secret_fans/managers/tag_manager.dart';
import 'package:secret_fans/screens/add_to_favourites_screen.dart';
import 'package:secret_fans/screens/bin_screen.dart';
import 'package:secret_fans/screens/contacts_screen.dart';
import 'package:secret_fans/screens/create_pass.dart';
import 'package:secret_fans/screens/contact_info.dart';
import 'package:secret_fans/screens/events_screen.dart';
import 'package:secret_fans/screens/favourites_screen.dart';
import 'package:secret_fans/screens/folders2_screen.dart';
import 'package:secret_fans/screens/folders_screen.dart';
import 'package:secret_fans/screens/home_screen.dart';
import 'package:secret_fans/screens/move_folders_screen.dart';
import 'package:secret_fans/screens/navigation_screen.dart';
import 'package:secret_fans/screens/onboarding1.dart';
import 'package:secret_fans/screens/onboarding2.dart';
import 'package:secret_fans/screens/opened_folder_screen.dart';
import 'package:secret_fans/screens/password_change.dart';
import 'package:secret_fans/screens/premium_screen.dart';
import 'package:secret_fans/screens/create_new_contact.dart';
import 'package:secret_fans/screens/settings_screen.dart';
import 'package:secret_fans/screens/tags_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import 'screens/recents_screen.dart';
import 'utils/links.dart';

late final SharedPreferences preferences;
late final PasswordManager passwordManager;
late final ContactsManager contactsManager;

Future<void> launchUri(String url) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw Exception('Could not launch $url');
  }
}

void main() => runZonedGuarded(() async {
      WidgetsFlutterBinding.ensureInitialized();
      await Apphud.start(apiKey: Links.apphud);
      preferences = await SharedPreferences.getInstance();
      await FlutterContacts.requestPermission();
      passwordManager = PasswordManager();
      await passwordManager.init();
      contactsManager = ContactsManager();
      await contactsManager.getAll();
      runApp(
        ScreenUtilInit(
          designSize: const Size(390, 844),
          builder: (
            BuildContext context,
            Widget? child,
          ) =>
              const MyApp(),
        ),
      );
      await Future.delayed(const Duration(seconds: 12));
      try {
        final InAppReview inAppReview = InAppReview.instance;

        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      } catch (e) {
        throw Exception(e);
      }
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
    final isFirst = preferences.getBool('firstStart') ?? true;
    preferences.setBool('firstStart', false);

    final hasPassword = passwordManager.hasPassword;

    final String initLocation;
    if (isFirst) {
      initLocation = '/onboarding1';
    } else if (hasPassword) {
      initLocation = '/create_pass';
    } else {
      initLocation = '/home_screen';
    }

    _router = GoRouter(
      initialLocation: initLocation,
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
            child: const CreatePass(hasSkip: true),
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
              routes: [
                GoRoute(
                  path: 'recents',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const RecentsScreen(),
                  ),
                ),
                GoRoute(
                  path: 'events',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const EventsScreen(),
                  ),
                ),
              ],
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
              ],
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
                    routes: [
                      GoRoute(
                        path: 'edit',
                        pageBuilder: (context, state) =>
                            buildPageWithDefaultTransition(
                          context: context,
                          state: state,
                          child: const CreateNewContact(isEdit: true),
                        ),
                      ),
                    ]),
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
                  path: 'add_contacts',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const Folders2Screen(isEdit: false),
                  ),
                ),
                GoRoute(
                  path: 'edit_contacts',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const Folders2Screen(isEdit: true),
                  ),
                ),
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
                      path: 'edit_contacts',
                      pageBuilder: (context, state) =>
                          buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const Folders2Screen(isEdit: true),
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
                GoRoute(
                  path: 'password_screen',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const CreatePass(hasSkip: false),
                  ),
                ),
                GoRoute(
                  path: 'password_change',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const PasswordChange(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'change',
                      pageBuilder: (context, state) =>
                          buildPageWithDefaultTransition(
                        context: context,
                        state: state,
                        child: const CreatePass(hasSkip: false),
                      ),
                    ),
                  ],
                ),
                GoRoute(
                  path: 'tags_screen',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const TagsScreen(),
                  ),
                ),
                GoRoute(
                  path: 'bin_screen',
                  pageBuilder: (context, state) =>
                      buildPageWithDefaultTransition(
                    context: context,
                    state: state,
                    child: const BinScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
    passwordManager.router = _router;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: passwordManager,
        ),
        ChangeNotifierProvider.value(
          value: contactsManager,
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => RecentManager(
            contactsManager: contactsManager,
          )..init(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FavoriteManager(
            contactsManager: contactsManager,
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FoldersManager(
            contactsManager: contactsManager,
          ),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => TagManager(contactsManager),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => PremiumManager(),
        ),
        Provider.value(value: _router),
      ],
      child: MaterialApp(
        home: KoshumchaScreen(
          preferences: preferences,
          baseUrlWithoutHttp: Links.url,
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: _router,
          ),
        ),
      ),
    );
  }
}

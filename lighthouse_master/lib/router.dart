import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'features/home/home_screen.dart';
import 'features/chats/chats_screen.dart';
import 'features/contacts/contacts_screen.dart';

import 'features/discover/discover_screen.dart';
import 'features/profile/profile_screen.dart';
import 'features/search/search_results_screen.dart'; // Added
import 'main_screen.dart'; // We will refactor this to be the Shell

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionHomeNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionChatsNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionContactsNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionDiscoverNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _sectionProfileNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      builder: (BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) {
        return MainScreen(navigationShell: navigationShell);
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          navigatorKey: _sectionHomeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/home',
              builder: (BuildContext context, GoRouterState state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionChatsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/chats',
              builder: (BuildContext context, GoRouterState state) => const ChatsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionContactsNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/contacts',
              builder: (BuildContext context, GoRouterState state) => const ContactsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionDiscoverNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/discover',
              builder: (BuildContext context, GoRouterState state) => const DiscoverScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _sectionProfileNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: '/me',
              builder: (BuildContext context, GoRouterState state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/search',
      builder: (BuildContext context, GoRouterState state) {
        final query = state.uri.queryParameters['q'] ?? '';
        return SearchResultsScreen(query: query);
      },
    ),
  ],
);

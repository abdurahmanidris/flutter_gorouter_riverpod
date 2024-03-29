import 'package:flutter/material.dart';
import 'package:flutter_gorouter_riverpod/features/drawer_pages/presentation/ui/change_pin_screen.dart';
import 'package:flutter_gorouter_riverpod/features/drawer_pages/presentation/ui/profile_screen.dart';
import 'package:flutter_gorouter_riverpod/features/product/presentation/ui/widget/product_detail_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gorouter_riverpod/features/cart/presentation/ui/cart_screen.dart';
import 'package:flutter_gorouter_riverpod/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:flutter_gorouter_riverpod/features/home/presentation/ui/home_screen.dart';
import 'package:flutter_gorouter_riverpod/features/setting/presentation/ui/setting_screen.dart';
import 'package:flutter_gorouter_riverpod/route/named_route.dart';
import 'package:flutter_gorouter_riverpod/screen/error/route_error_screen.dart';

final GlobalKey<NavigatorState> _rootNavigator = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigator,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/home',
        name: 'root',
        builder: (context, state) => HomeScreen(key: state.pageKey),
      ),
      ShellRoute(
        navigatorKey: _shellNavigator,
        builder: (context, state, child) => DashboardScreen(
          key: state.pageKey,
          child: child,
        ),
        routes: [
          GoRoute(
              path: '/',
              name: home,
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: HomeScreen(
                  key: state.pageKey,
                ));
              },
              routes: [
                GoRoute(
                  path: 'profile',
                  name: profile,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: ProfileScreen(
                      key: state.pageKey,
                    ));
                  },
                ),
                GoRoute(
                  path: 'changePIN',
                  name: changePIN,
                  pageBuilder: (context, state) {
                    /*return NoTransitionPage(
                        child: ChangePINScreen(
                      key: state.pageKey,
                    ));*/
                    return const MaterialPage(child: ChangePINScreen());
                  },
                ),
                GoRoute(
                  path: 'cart',
                  name: cart,
                  pageBuilder: (context, state) {
                    return NoTransitionPage(
                        child: CartScreen(
                      key: state.pageKey,
                    ));
                  },
                ),
                GoRoute(
                  path: 'setting',
                  name: setting,
                  pageBuilder: (context, state) {
                    /*return NoTransitionPage(
                        child: SettingScreen(
                      key: state.pageKey,
                    ));*/
                    return const MaterialPage(child: SettingScreen());
                  },
                ),
                GoRoute(
                  parentNavigatorKey: _shellNavigator,
                  path: 'productDetail/:id',
                  name: productDetail,
                  pageBuilder: (context, state) {
                    final id = state.pathParameters['id'].toString();
                    return NoTransitionPage(
                        child: ProductDetailScreen(
                      id: int.parse(id),
                      key: state.pageKey,
                    ));
                  },
                )
              ]),
        ],
      )
    ],
    errorBuilder: (context, state) => RouteErrorScreen(
      errorMsg: state.error.toString(),
      key: state.pageKey,
    ),
  );
});

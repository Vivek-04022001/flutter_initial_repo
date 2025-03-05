import 'package:f5_billion/features/authentication/ui/login_screen.dart';
import 'package:f5_billion/features/cart/ui/cart_screen.dart';
import 'package:f5_billion/features/home/ui/bottom_nav_shell.dart';
import 'package:f5_billion/features/home/ui/home_screen.dart';
import 'package:f5_billion/features/no_internet/ui/no_internet_screen.dart';
import 'package:f5_billion/features/order_history/ui/order_history_sceen.dart';
import 'package:f5_billion/features/profile/ui/profile_screen.dart';
import 'package:f5_billion/features/splash/ui/splash_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:f5_billion/features/no_internet/state/connectivity_notifier.dart';

class AppRouter {
  static final connectivityNotifier = ConnectivityNotifier();

  static final GoRouter router = GoRouter(
    initialLocation:
        connectivityNotifier.hasInternet ? '/login' : '/no-internet',
    refreshListenable: connectivityNotifier,
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/home-screen',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/order-history',
            builder: (context, state) => const OrderHistoryScreen(),
          ),
          GoRoute(
            path: '/cart-screen',
            builder: (context, state) => const CartScreen(),
          ),

          GoRoute(
            path: '/profile-screen',
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/no-internet',
        builder: (context, state) => const NoInternetScreen(),
      ),
    ],
    redirect: (context, state) {
      final hasNet = connectivityNotifier.hasInternet;
      final currentPath = state.uri.toString();
      final onNoInternet = (currentPath == '/no-internet');

      // Ensure we track last valid route before losing internet
      if (hasNet && !onNoInternet) {
        connectivityNotifier.setLastOnlineRoute(currentPath);
      }

      // If offline and not already on /no-internet, redirect
      if (!hasNet && !onNoInternet) {
        return '/no-internet';
      }

      // If online and currently on /no-internet, return to last valid page
      if (hasNet && onNoInternet) {
        return connectivityNotifier.lastOnlineRoute ?? '/home-screen';
      }

      return null; // No change
    },
  );
}

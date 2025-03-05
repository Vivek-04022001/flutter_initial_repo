import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityNotifier extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;

  bool _hasInternet = true;
  bool get hasInternet => _hasInternet;

  String? lastOnlineRoute = '/home-screen'; // Default to a valid page

  ConnectivityNotifier() {
    _subscription = _connectivity.onConnectivityChanged.listen((results) {
      // `results` is now a List<ConnectivityResult>
      final connected =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);

      if (connected != _hasInternet) {
        _hasInternet = connected;
        notifyListeners(); // Notify GoRouter to update navigation
      }
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  void setLastOnlineRoute(String route) {
    if (hasInternet) {
      lastOnlineRoute = route;
    }
  }
}

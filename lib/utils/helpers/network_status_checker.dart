import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';

class NetworkStatusChecker {
  final String _binanceApiUrl = 'https://api.binance.com/api/v3/time';

  final Duration _timeout = const Duration(seconds: 5);

  late final Dio _dio;

  static final NetworkStatusChecker _instance =
      NetworkStatusChecker._internal();

  factory NetworkStatusChecker() {
    return _instance;
  }

  NetworkStatusChecker._internal() {
    _dio = Dio(
      BaseOptions(
        connectTimeout: _timeout,
        receiveTimeout: _timeout,
        sendTimeout: _timeout,
      ),
    );
  }

  // Stream controller to broadcast network status changes
  final _statusController = StreamController<NetworkStatus>.broadcast();
  Stream<NetworkStatus> get statusStream => _statusController.stream;

  // Check if device has internet connectivity
  Future<bool> hasInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult.contains(ConnectivityResult.none)) {
        return false;
      }

      // Try to reach a reliable external service
      final response = await _dio.get('https://google.com');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Check if Binance API is accessible
  Future<bool> canAccessBinanceApi() async {
    try {
      final response = await _dio.get(_binanceApiUrl);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Check complete network status
  Future<NetworkStatus> checkNetworkStatus() async {
    final hasBinanceAccess = await canAccessBinanceApi();

    if (hasBinanceAccess) {
      return NetworkStatus.connected;
    } else {
      final hasInternet = await hasInternetConnection();
      if (!hasInternet) {
        return NetworkStatus.noInternet;
      }
      return NetworkStatus.vpnRequired;
    }
  }

  void startMonitoring() {
    _checkAndBroadcastStatus();

    Connectivity().onConnectivityChanged.listen((_) {
      _checkAndBroadcastStatus();
    });

    Timer.periodic(const Duration(minutes: 5), (_) {
      _checkAndBroadcastStatus();
    });
  }

  Future<void> _checkAndBroadcastStatus() async {
    final status = await checkNetworkStatus();
    _statusController.add(status);
  }

  void dispose() {
    _statusController.close();
  }
}

enum NetworkStatus { connected, noInternet, vpnRequired }

extension NetworkStatusExtension on NetworkStatus {
  String get description {
    switch (this) {
      case NetworkStatus.connected:
        return 'Connected';
      case NetworkStatus.noInternet:
        return 'No internet connection';
      case NetworkStatus.vpnRequired:
        return 'VPN required';
    }
  }

  String get instruction {
    switch (this) {
      case NetworkStatus.connected:
        return '';
      case NetworkStatus.noInternet:
        return 'Please check your internet connection.';
      case NetworkStatus.vpnRequired:
        return 'Binance services are not accessible from your current location. Please connect to a VPN and try again.';
    }
  }
}

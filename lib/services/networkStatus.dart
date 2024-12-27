import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final networkStatusProvider = StateNotifierProvider((ref) {
  return CheckNetworkStatus();
});

enum ConnectivityStatus {
  isConnected,
  isDisconnected,
  notDetermined;
}

class CheckNetworkStatus extends StateNotifier<ConnectivityStatus> {
  ConnectivityStatus? newState;
  CheckNetworkStatus() : super(ConnectivityStatus.notDetermined) {
    checkNetworkConnectivity();

    Connectivity().onConnectivityChanged.listen((result) {
      // Use Connectivity() here to gather more info if you need t
      determineNetworkStatus(result);
    });
  }

  checkNetworkConnectivity() async {
    List<ConnectivityResult> status = await Connectivity().checkConnectivity();
    determineNetworkStatus(status);
  }

  determineNetworkStatus(List<ConnectivityResult> status) {
    var initialStatus = status.first;
    switch (initialStatus) {
      case ConnectivityResult.mobile:
        {
          newState = ConnectivityStatus.isConnected;
        }
        break;
      case ConnectivityResult.wifi:
        {
          newState = ConnectivityStatus.isConnected;
        }

        break;
      case ConnectivityResult.none:
        newState = ConnectivityStatus.isDisconnected;
        // TODO: Handle this case.
        break;
      case ConnectivityResult.bluetooth:
      // TODO: Handle this case.
      case ConnectivityResult.ethernet:
      // TODO: Handle this case.
      case ConnectivityResult.vpn:
      // TODO: Handle this case.
      case ConnectivityResult.other:
        {
          newState = ConnectivityStatus.notDetermined;
        }
      // TODO: Handle this case.
    }
    if (state != newState) {
      state = newState!;
    }
  }
}

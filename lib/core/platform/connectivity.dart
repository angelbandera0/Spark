
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rxdart/rxdart.dart';

class ConnectivityService {
  ///Connection status controller....
  BehaviorSubject<ConnectionStatus> connectivityController = BehaviorSubject();
  ConnectionStatus connectionStatus = ConnectionStatus.offline;

  ///Fetch the Connection Status...
  ConnectivityService() {
    InternetConnectionChecker().onStatusChange.listen((event) {
      connectionStatus = _networkStatus(event);

      ///Emit the status via Stream...
      connectivityController.add(connectionStatus);
    });
  }

  //Converts the connectivity result into our enums
  //Currently the output id mobile, wifi,none.....
  ConnectionStatus _networkStatus(InternetConnectionStatus status) {
    switch (status) {
      case InternetConnectionStatus.connected:
        return ConnectionStatus.online;

      case InternetConnectionStatus.disconnected:
        return ConnectionStatus.offline;

      default:
        return ConnectionStatus.offline;
    }
  }
}

enum ConnectionStatus {
  online,
  offline,
}

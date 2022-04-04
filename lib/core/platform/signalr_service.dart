import 'dart:async';
import 'dart:convert';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:rxdart/rxdart.dart';
import 'package:logging/logging.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/shared_prefs.dart';
import 'package:sparkz/feature/search/domain/entity/auction_result_response_entity.dart';
import 'package:sparkz/core/global/notifications.dart' as Notifications;

class SignalRService {
  final _serverUrl = "${Endpoint.apiBaseUrl}/hubs/sendnotification";
  late HubConnection _hubConnection;
  late Logger _logger;
  late StreamSubscription<LogRecord> _logMessagesSub;
  late HttpConnectionOptions _httpConnectionOptions;
  AuctionResultResponseEntity? _messageFromServer;
  final SharedPreferencesManager _sharedPreferencesManager;
  final BehaviorSubject<AuctionResultResponseEntity>
      _signalRMessageAuctionResult = BehaviorSubject();
  final BehaviorSubject<String> _signalRConnectionStatus = BehaviorSubject();

  SignalRService(this._sharedPreferencesManager) {
    _initConfig();
    _openConnection();
  }

  BehaviorSubject<AuctionResultResponseEntity> get subject =>
      _signalRMessageAuctionResult;

  BehaviorSubject<String> get connectionStatus => _signalRConnectionStatus;

  void _initConfig() {
    _logger = Logger("SendNotificationLogger");
    _httpConnectionOptions = new HttpConnectionOptions(
        accessTokenFactory: () => Future.value(_formattedAccessToken()),
        logger: _logger,
        logMessageContent: true);

    _hubConnection = HubConnectionBuilder()
        .withUrl(_serverUrl, options: _httpConnectionOptions)
        .withAutomaticReconnect(
            retryDelays: List<int>.generate(100, (index) => 2000))
        .configureLogging(_logger)
        .build();
    _logMessagesSub = Logger.root.onRecord.listen(_handleLogMessage);
    Logger.root.level = Level.ALL;
  }

  void _openConnection() {
    _hubConnection.onclose(({error}) {
      _signalRConnectionStatus.sink.add("Offline");
      print(error);
    });
    _hubConnection.onreconnecting(({error}) {
      _signalRConnectionStatus.sink.add("Reconnecting");
      print("onreconnecting called");
    });
    _hubConnection.onreconnected(({connectionId}) {
      _signalRConnectionStatus.sink.add("Online");
      print("onreconnected called");
    });
    _hubConnection.on("broadcasttogroup", _handleIncommingChatMessage);
  }

  Future<void> startConnection() async {
    if (_hubConnection.state != HubConnectionState.Connected) {
      await _hubConnection
          .start()
          ?.then((_) => _signalRConnectionStatus.sink.add("Online"));
    }
  }

  void _handleLogMessage(LogRecord msg) {
    print(msg.message);
  }

  void _handleIncommingChatMessage(List<Object>? args) {
    _messageFromServer = AuctionResultResponseEntity.fromJson(
        jsonDecode(args!.first.toString()));
    _getUserId().then((value) {
      if (_messageFromServer!.data.winnerUserId == value) {
        Notifications.createAuctionWinnerNotification(ParkedUser(
                bidWinner: _messageFromServer!.data.bidWinner.toString(),
                parkedUserId: _messageFromServer!.data.parkedUserId.toString(),
                parkedUserFullName: _messageFromServer!.data.parkedUserFullName,
                parkedUserPhone: _messageFromServer!.data.parkedUserPhone,
                parkedUserAvatar: _messageFromServer!.data.parkedUserAvatar,
                parkedUserAvatarMimeType:
                    _messageFromServer!.data.parkedUserAvatarMimeType,
                parkedCountry: _messageFromServer!.data.parkedCountry,
                parkedState: _messageFromServer!.data.parkedState,
                parkedLocality: _messageFromServer!.data.parkedLocality,
                parkedUserHaveAnActiveCar: _messageFromServer!
                    .data.parkedUserHaveAnActiveCar
                    .toString(),
                parkedCarBrand: _messageFromServer!.data.parkedCarBrand!,
                parkedCarColor: _messageFromServer!.data.parkedCarColor!,
                parkedCarModel: _messageFromServer!.data.parkedCarModel!,
                parkedCarPlateNumber:
                    _messageFromServer!.data.parkedCarPlateNumber!)
            .toJson());
      } else if (_messageFromServer!.data.parkedUserId == value) {
        Notifications.createAuctionOwnerNotification(WinnerUser(
                bidWinner: _messageFromServer!.data.bidWinner.toString(),
                winnerUserId: _messageFromServer!.data.winnerUserId.toString(),
                winnerUserFullName: _messageFromServer!.data.winnerUserFullName,
                winnerUserPhone: _messageFromServer!.data.winnerUserPhone,
                winnerUserAvatar: _messageFromServer!.data.winnerUserAvatar,
                winnerUserAvatarMimeType:
                    _messageFromServer!.data.winnerUserAvatarMimeType,
                winnerCarBrand: _messageFromServer!.data.winnerCarBrand,
                winnerCarColor: _messageFromServer!.data.winnerCarColor,
                winnerCarModel: _messageFromServer!.data.winnerCarModel,
                winnerCarPlateNumber:
                    _messageFromServer!.data.winnerCarPlateNumber)
            .toJson());
      } else {
        Notifications.createAuctionLooserNotification();
      }
    });
  }

  Future<String> _formattedAccessToken() async {
    String token = await _sharedPreferencesManager.getAccessToken();
    return token.substring(7);
  }

  Future<int> _getUserId() async {
    int id = await _sharedPreferencesManager.getUserId();
    return id;
  }

  Future<void> addToGroup(String groupName) async {
    _hubConnection.invoke("AddToGroup", args: <Object>["$groupName"]);
  }

  Future<void> removeFromGroup(String groupName) async {
    _hubConnection.invoke("RemoveFromGroup", args: <Object>["$groupName"]);
  }

  void closeConnection() {
    if (_hubConnection.state == HubConnectionState.Connected) {
      _hubConnection.stop();
    }
  }

  void dispose() {
    closeConnection();
    _logMessagesSub.cancel();
    _signalRMessageAuctionResult.close();
    _signalRConnectionStatus.close();
    Notifications.dispose();
  }
}

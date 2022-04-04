import 'dart:convert';

import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class AuctionResultResponseEntity extends Equatable {
  AuctionResultResponseEntity({required this.hubKey, required this.data});
  int hubKey;
  Data data;

  factory AuctionResultResponseEntity.fromJson(Map<dynamic, dynamic> json) {
    return AuctionResultResponseEntity(
      hubKey: json['HubKey'],
      data: Data.fromJson(jsonDecode(json["Data"])),
    );
  }

  @override
  List<Object?> get props => [];
}

class Data {
  Data({
    required this.bidWinner,
    required this.winnerUserId,
    required this.winnerUserFullName,
    required this.winnerUserPhone,
    required this.winnerUserAvatar,
    required this.winnerUserAvatarMimeType,
    required this.winnerCarBrand,
    required this.winnerCarColor,
    required this.winnerCarModel,
    required this.winnerCarPlateNumber,
    required this.parkedUserId,
    required this.parkedUserFullName,
    required this.parkedUserPhone,
    required this.parkedUserAvatar,
    required this.parkedUserAvatarMimeType,
    required this.parkedCountry,
    required this.parkedState,
    required this.parkedLocality,
    required this.parkedUserHaveAnActiveCar,
    this.parkedCarBrand,
    this.parkedCarColor,
    this.parkedCarModel,
    this.parkedCarPlateNumber,
  });

  double bidWinner;
  int winnerUserId;
  String winnerUserFullName;
  String winnerUserPhone;
  String winnerUserAvatar;
  String winnerUserAvatarMimeType;
  String winnerCarBrand;
  String winnerCarColor;
  String winnerCarModel;
  String winnerCarPlateNumber;
  int parkedUserId;
  String parkedUserFullName;
  String parkedUserPhone;
  String parkedUserAvatar;
  String parkedUserAvatarMimeType;
  String parkedCountry;
  String parkedState;
  String parkedLocality;
  bool parkedUserHaveAnActiveCar;
  String? parkedCarBrand;
  String? parkedCarColor;
  String? parkedCarModel;
  String? parkedCarPlateNumber;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        bidWinner: json["BidWinner"],
        winnerUserId: json["WinnerUserId"],
        winnerUserFullName: json["WinnerUserFullName"],
        winnerUserPhone: json["WinnerUserPhone"],
        winnerUserAvatar: json["WinnerUserAvatar"],
        winnerUserAvatarMimeType: json["WinnerUserAvatarMimeType"],
        winnerCarBrand: json["WinnerCarBrand"],
        winnerCarColor: json["WinnerCarColor"],
        winnerCarModel: json["WinnerCarModel"],
        winnerCarPlateNumber: json["WinnerCarPlateNumber"],
        parkedUserId: json["ParkedUserId"],
        parkedUserFullName: json["ParkedUserFullName"],
        parkedUserPhone: json["ParkedUserPhone"],
        parkedUserAvatar: json["ParkedUserAvatar"],
        parkedUserAvatarMimeType: json["ParkedUserAvatarMimeType"],
        parkedCountry: json["ParkedCountry"],
        parkedState: json["ParkedState"],
        parkedLocality: json["ParkedLocality"],
        parkedUserHaveAnActiveCar: json["ParkedUserHaveAnActiveCar"],
        parkedCarBrand: json["ParkedCarBrand"] ?? "",
        parkedCarColor: json["ParkedCarColor"] ?? "",
        parkedCarModel: json["ParkedCarModel"] ?? "",
        parkedCarPlateNumber: json["ParkedCarPlateNumber"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "BidWinner": bidWinner,
        "WinnerUserId": winnerUserId,
        "WinnerUserFullName": winnerUserFullName,
        "WinnerUserPhone": winnerUserPhone,
        "WinnerUserAvatar": winnerUserAvatar,
        "WinnerUserAvatarMimeType": winnerUserAvatarMimeType,
        "WinnerCarBrand": winnerCarBrand,
        "WinnerCarColor": winnerCarColor,
        "WinnerCarModel": winnerCarModel,
        "WinnerCarPlateNumber": winnerCarPlateNumber,
        "ParkedUserId": parkedUserId,
        "ParkedUserFullName": parkedUserFullName,
        "ParkedUserPhone": parkedUserPhone,
        "ParkedUserAvatar": parkedUserAvatar,
        "ParkedUserAvatarMimeType": parkedUserAvatarMimeType,
        "ParkedCountry": parkedCountry,
        "ParkedState": parkedState,
        "ParkedLocality": parkedLocality,
        "ParkedUserHaveAnActiveCar": parkedUserHaveAnActiveCar,
        "ParkedCarBrand": parkedCarBrand,
        "ParkedCarColor": parkedCarColor,
        "ParkedCarModel": parkedCarModel,
        "ParkedCarPlateNumber": parkedCarPlateNumber,
      };
}

class WinnerUser {
  WinnerUser({
    required this.bidWinner,
    required this.winnerUserId,
    required this.winnerUserFullName,
    required this.winnerUserPhone,
    required this.winnerUserAvatar,
    required this.winnerUserAvatarMimeType,
    required this.winnerCarBrand,
    required this.winnerCarColor,
    required this.winnerCarModel,
    required this.winnerCarPlateNumber,
  });

  String bidWinner;
  String winnerUserId;
  String winnerUserFullName;
  String winnerUserPhone;
  String winnerUserAvatar;
  String winnerUserAvatarMimeType;
  String winnerCarBrand;
  String winnerCarColor;
  String winnerCarModel;
  String winnerCarPlateNumber;

  factory WinnerUser.fromJson(Map<String, String> json) => WinnerUser(
        bidWinner: json["BidWinner"] ?? "",
        winnerUserId: json["WinnerUserId"] ?? "",
        winnerUserFullName: json["WinnerUserFullName"] ?? "",
        winnerUserPhone: json["WinnerUserPhone"] ?? "",
        winnerUserAvatar: json["WinnerUserAvatar"] ?? "",
        winnerUserAvatarMimeType: json["WinnerUserAvatarMimeType"] ?? "",
        winnerCarBrand: json["WinnerCarBrand"] ?? "",
        winnerCarColor: json["WinnerCarColor"] ?? "",
        winnerCarModel: json["WinnerCarModel"] ?? "",
        winnerCarPlateNumber: json["WinnerCarPlateNumber"] ?? "",
      );

  Map<String, String> toJson() => {
        "BidWinner": bidWinner,
        "WinnerUserId": winnerUserId,
        "WinnerUserFullName": winnerUserFullName,
        "WinnerUserPhone": winnerUserPhone,
        "WinnerUserAvatar": winnerUserAvatar,
        "WinnerUserAvatarMimeType": winnerUserAvatarMimeType,
        "WinnerCarBrand": winnerCarBrand,
        "WinnerCarColor": winnerCarColor,
        "WinnerCarModel": winnerCarModel,
        "WinnerCarPlateNumber": winnerCarPlateNumber,
      };
}

class ParkedUser {
  ParkedUser({
    required this.bidWinner,
    required this.parkedUserId,
    required this.parkedUserFullName,
    required this.parkedUserPhone,
    required this.parkedUserAvatar,
    required this.parkedUserAvatarMimeType,
    required this.parkedCountry,
    required this.parkedState,
    required this.parkedLocality,
    required this.parkedUserHaveAnActiveCar,
    required this.parkedCarBrand,
    required this.parkedCarColor,
    required this.parkedCarModel,
    required this.parkedCarPlateNumber,
  });

  String bidWinner;

  String parkedUserId;
  String parkedUserFullName;
  String parkedUserPhone;
  String parkedUserAvatar;
  String parkedUserAvatarMimeType;
  String parkedCountry;
  String parkedState;
  String parkedLocality;
  String parkedUserHaveAnActiveCar;
  String parkedCarBrand;
  String parkedCarColor;
  String parkedCarModel;
  String parkedCarPlateNumber;

  factory ParkedUser.fromJson(Map<String, String> json) => ParkedUser(
        bidWinner: json["BidWinner"] ?? "",
        parkedUserId: json["ParkedUserId"] ?? "",
        parkedUserFullName: json["ParkedUserFullName"] ?? "",
        parkedUserPhone: json["ParkedUserPhone"] ?? "",
        parkedUserAvatar: json["ParkedUserAvatar"] ?? "",
        parkedUserAvatarMimeType: json["ParkedUserAvatarMimeType"] ?? "",
        parkedCountry: json["ParkedCountry"] ?? "",
        parkedState: json["ParkedState"] ?? "",
        parkedLocality: json["ParkedLocality"] ?? "",
        parkedUserHaveAnActiveCar: json["ParkedUserHaveAnActiveCar"] ?? "",
        parkedCarBrand: json["ParkedCarBrand"] ?? "",
        parkedCarColor: json["ParkedCarColor"] ?? "",
        parkedCarModel: json["ParkedCarModel"] ?? "",
        parkedCarPlateNumber: json["ParkedCarPlateNumber"] ?? "",
      );

  Map<String, String> toJson() => {
        "BidWinner": bidWinner,
        "ParkedUserId": parkedUserId,
        "ParkedUserFullName": parkedUserFullName,
        "ParkedUserPhone": parkedUserPhone,
        "ParkedUserAvatar": parkedUserAvatar,
        "ParkedUserAvatarMimeType": parkedUserAvatarMimeType,
        "ParkedCountry": parkedCountry,
        "ParkedState": parkedState,
        "ParkedLocality": parkedLocality,
        "ParkedUserHaveAnActiveCar": parkedUserHaveAnActiveCar,
        "ParkedCarBrand": parkedCarBrand,
        "ParkedCarColor": parkedCarColor,
        "ParkedCarModel": parkedCarModel,
        "ParkedCarPlateNumber": parkedCarPlateNumber,
      };
}

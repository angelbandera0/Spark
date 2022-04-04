import 'dart:convert';

import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/network_handler.dart';

import 'package:sparkz/feature/search/domain/entity/add_unparked_entity.dart';
import 'package:sparkz/feature/search/domain/entity/add_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/delete_unparked_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_compatible_spots_response_entity.dart';
import 'package:sparkz/feature/search/domain/entity/list_unparked_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_request_entity.dart';
import 'package:sparkz/feature/search/domain/entity/submit_bid_response_entity.dart';

abstract class SearchRemoteApi {
  Future<AddUnparkedResponseEntity> addUnparked(AddUnparkedEntity request);
  Future<List<AddUnparkedEntity>> listUnparked(
      ListUnparkedRequestEntity request);
  Future<List<ListCompatibleSpotsResponseEntity>> listCompatibleSpots(
      ListCompatibleSpotsEntity request);
  Future<DeleteUnparkedResponseEntity> deleteUnparked(
      DeleteUnparkedRequestEntity request);
  Future<SubmitBidResponseEntity> submitBid(SubmitBidRequestEntity request);
}

class SearchRemoteApiImpl extends SearchRemoteApi {
  SearchRemoteApiImpl(this._networkHandler);

  final NetworkHandler _networkHandler;

  Future<AddUnparkedResponseEntity> addUnparked(
      AddUnparkedEntity unparked) async {
    Map<String, dynamic> body = unparked.toJson();
    try {
      final resp = await _networkHandler.post(
          path: Endpoint.UNPARKED_CRUD, body: jsonEncode(body));
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return AddUnparkedResponseEntity(
            json.decode(resp.body)["result"]["id"]);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<AddUnparkedEntity>> listUnparked(
      ListUnparkedRequestEntity request) async {
    try {
      final params =
          '?orderBy=${request.orderBy}&orderDirection=${request.orderDirection}&pageNumber=${request.pageNumber}&pageSize=${request.pageSize}';
      final response = await _networkHandler.get(
          path: Endpoint.UNPARKED_BY_USER, params: params);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return List<AddUnparkedEntity>.from(json
            .decode(response.body)["result"]
            .map((x) => AddUnparkedEntity.fromJson(x)));
      } else {
        throw ServerException(jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<List<ListCompatibleSpotsResponseEntity>> listCompatibleSpots(
      ListCompatibleSpotsEntity request) async {
    try {
      final params =
          '''?orderBy=${request.orderBy}&orderDirection=${request.orderDirection}
          &pageNumber=${request.pageNumber}&pageSize=${request.pageSize}
          &desiredTimeFrom=${request.desiredTimeFrom}&desiredTimeTo=${request.desiredTimeTo}&desiredSize=${request.desiredSize}
          &location.Latitude=${request.latitude}&Location.Longitude=${request.longitude}
          &Location.Country=${request.country}&Location.State=${request.state}
          &Location.Locality=${request.locality}&Color=${request.color}&Model=${request.model}
          &PlateNumber=${request.plateNumber}''';
      final response = await _networkHandler.get(
          path: Endpoint.COMPATIBLE_SPOTS, params: params);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return List<ListCompatibleSpotsResponseEntity>.from(json
            .decode(response.body)["result"]
            .map((x) => ListCompatibleSpotsResponseEntity.fromJson(x)));
      } else {
        throw ServerException(jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DeleteUnparkedResponseEntity> deleteUnparked(request) async {
    try {
      final resp = await _networkHandler.delete(
          path: Endpoint.UNPARKED_CRUD, params: '/${request.entityId}');
      if (resp.statusCode == 200 || resp.statusCode == 204) {
        return DeleteUnparkedResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<SubmitBidResponseEntity> submitBid(request) async {
    Map<String, dynamic> body = request.toJson();
    try {
      final resp = await _networkHandler.post(
          path: Endpoint.SUBMIT_BID, body: jsonEncode(body));
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return SubmitBidResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }
}

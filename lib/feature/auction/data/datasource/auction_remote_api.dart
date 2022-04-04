import 'dart:convert';

import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/failure/failure.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/network_handler.dart';
import 'package:sparkz/feature/auction/data/model/list_auction_response_model.dart';
import 'package:sparkz/feature/auction/domain/entity/add_auction_response_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/delete_auction_response_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/edit_auction_response_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/list_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/publish_auction_response_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/start_auction_request_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/start_auction_response_entity.dart';

abstract class AuctionRemoteApi {
  Future<List<ListAuctionResponseModel>> listAuction(
      ListAuctionRequesEntity request);
  Future<AddAuctionResponseEntity> addAuction(ParkedEntity parkedEntity);
  Future<EditAuctionResponseEntity> editAuction(ParkedEntity parkedEntity);
  Future<DeleteAuctionResponseEntity> deleteAuction(
      DeleteAuctionRequestEntity entity);
  Future<StartAuctionResponseEntity> startAuction(
      StartAuctionRequestEntity entity);
  Future<ListAuctionResponseModel> publishAuction(ParkedEntity parkedEntity);
}

class AuctionRemoteApiImpl extends AuctionRemoteApi {
  AuctionRemoteApiImpl(this._networkHandler);

  final NetworkHandler _networkHandler;

  Future<List<ListAuctionResponseModel>> listAuction(
      ListAuctionRequesEntity request) async {
    try {
      final params =
          '?pageNumber=${request.pageNumber}&pageSize=${request.pageSize}';
      final resp = await _networkHandler.get(
          path: Endpoint.GET_PARKED_BY_USER, params: params);

      if (resp.statusCode == 200 || resp.statusCode == 204) {
        return List<ListAuctionResponseModel>.from(json
            .decode(resp.body)["result"]
            .map((x) => ListAuctionResponseModel.fromJson(x)));
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<AddAuctionResponseEntity> addAuction(ParkedEntity parkedEntity) async {
    try {
      Map<String, dynamic> body = parkedEntity.toJson();

      final resp = await _networkHandler.post(
          path: Endpoint.AUCTION_CRUD, body: jsonEncode(body));
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return AddAuctionResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<EditAuctionResponseEntity> editAuction(
      ParkedEntity parkedEntity) async {
    try {
      Map<String, dynamic> body = parkedEntity.toJson();
      final resp = await _networkHandler.put(
          path: Endpoint.AUCTION_CRUD,
          body: jsonEncode(body),
          params: '/${parkedEntity.id}');

      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return EditAuctionResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  Future<DeleteAuctionResponseEntity> deleteAuction(
      DeleteAuctionRequestEntity entity) async {
    try {
      final resp = await _networkHandler.delete(
          path: Endpoint.AUCTION_CRUD, params: '/${entity.entityId}');
      if (resp.statusCode == 200 || resp.statusCode == 204) {
        return DeleteAuctionResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<StartAuctionResponseEntity> startAuction(
      StartAuctionRequestEntity entity) async {
    try {
      Map<String, dynamic> body = entity.toJson();
      final resp = await _networkHandler.put(
          path: Endpoint.AUCTION_CRUD,
          body: jsonEncode(body),
          params: '/${entity.entityId}/start');

      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return StartAuctionResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ListAuctionResponseModel> publishAuction(
      ParkedEntity parkedEntity) async {
    try {
      Map<String, dynamic> body = parkedEntity.toJson();

      final resp = await _networkHandler.post(
          path: '${Endpoint.AUCTION_CRUD}/publish', body: jsonEncode(body));
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return (ListAuctionResponseModel.fromJson(
            json.decode(resp.body)["result"]));
      } else if (json.decode(resp.body)["customStatusCode"] == 400021) {
        throw PublishAuctionException(jsonDecode(resp.body)["message"]);
      } else {
        throw ServerFailure(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }
}

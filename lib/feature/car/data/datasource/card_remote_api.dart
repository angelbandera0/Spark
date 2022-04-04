import 'dart:convert';

import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/network_handler.dart';
import 'package:sparkz/feature/car/domain/entity/activate_car_response_entity.dart';
import 'package:sparkz/feature/car/domain/entity/add_card_response_entity.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_activate.dart';
import 'package:sparkz/feature/car/domain/entity/card_entity_add.dart';
import 'package:sparkz/feature/car/domain/entity/car_entity_list.dart';
import 'package:sparkz/feature/car/domain/entity/delete_car_request_entity.dart';
import 'package:sparkz/feature/car/domain/entity/delete_car_response_entity.dart';
import 'package:sparkz/feature/car/domain/entity/edit_car_response_entity.dart';
import 'package:sparkz/feature/car/domain/entity/list_card_request_entity.dart';

abstract class CardRemoteApi {
  Future<List<CarEntityList>> listCards(ListCardRequstEntity request);
  Future<AddCarResponseEntity> addCar(CarEntityAdd car);
  Future<EditCarResponseEntity> editCar(CarEntityList car);
  Future<DeleteCarResponseEntity> deleteCar(DeleteCarRequestEntity entity);
  Future<ActivateCarResponseEntity> activateCar(CarEntityActivate entity);
  Future<CarEntity> getActiveCar();
}

class CardRemoteApiImpl extends CardRemoteApi {
  CardRemoteApiImpl(this._networkHandler);
  final NetworkHandler _networkHandler;
  @override
  Future<List<CarEntityList>> listCards(ListCardRequstEntity request) async {
    try {
      final params =
          '?orderBy=${request.orderBy}&orderDirection=${request.orderDirection}&pageNumber=${request.pageNumber}&pageSize=${request.pageSize}';
      final response = await _networkHandler.get(
          path: Endpoint.GET_CARDS_BY_USER, params: params);
      if (response.statusCode == 200 || response.statusCode == 204) {
        return List<CarEntityList>.from(json
            .decode(response.body)["result"]
            .map((x) => CarEntityList.fromJson(x)));
      } else {
        throw ServerException(jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<AddCarResponseEntity> addCar(CarEntityAdd car) async {
    Map<String, dynamic> body = car.toJson();
    try {
      final resp = await _networkHandler.post(
          path: Endpoint.ADD_CRUD, body: jsonEncode(body));
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return AddCarResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<EditCarResponseEntity> editCar(CarEntityList car) async {
    try {
      CarEntityAdd mappingUpdate = new CarEntityAdd(car.carBrand, car.carColor,
          car.carModel, car.carPlateNumber, car.carSizeType);
      Map<String, dynamic> body = mappingUpdate.toJson();
      final resp = await _networkHandler.put(
          path: Endpoint.ADD_CRUD,
          body: jsonEncode(body),
          params: '/${car.id}');

      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return EditCarResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<DeleteCarResponseEntity> deleteCar(
      DeleteCarRequestEntity entity) async {
    try {
      final resp = await _networkHandler.delete(
          path: Endpoint.ADD_CRUD, params: '/${entity.entityId}');
      if (resp.statusCode == 200 || resp.statusCode == 204) {
        return DeleteCarResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<ActivateCarResponseEntity> activateCar(CarEntityActivate car) async {
    try {
      CarEntityActivate mappingUpdate =
          new CarEntityActivate(car.id, car.isActive);
      Map<String, dynamic> body = mappingUpdate.toJson();
      final resp = await _networkHandler.patch(
          path: '${Endpoint.ADD_CRUD}/${car.id}${Endpoint.ACTIVATE_CAR}',
          body: jsonEncode(body),
          params: '${car.isActive}');
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return ActivateCarResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<CarEntity> getActiveCar() async {
    try {
      final response = await _networkHandler.get(path: Endpoint.GET_ACTIVE_CAR);
      if (response.statusCode == 200 || response.statusCode == 204) {
        final result = jsonDecode(response.body)["result"];

        return CarEntity(
            result["brand"],
            result["model"],
            result["sizeType"].toString(),
            result["plateNumber"],
            result["color"]);
      } else {
        throw ServerException(jsonDecode(response.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }
}

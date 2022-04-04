import 'dart:convert';

import 'package:sparkz/core/failure/exception.dart';
import 'package:sparkz/core/global/endpoints.dart';
import 'package:sparkz/core/platform/network_handler.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_request_entity.dart';
import 'package:sparkz/feature/help/domain/entity/contact_us_response_entity.dart';

abstract class HelpRemoteApi {
  Future<ContactUsResponseEntity> contactUs(ContactUsRequestEntity contactUs);
}

class HelpRemoteApiImpl extends HelpRemoteApi {
  HelpRemoteApiImpl(this._networkHandler);
  final NetworkHandler _networkHandler;

  @override
  Future<ContactUsResponseEntity> contactUs(
      ContactUsRequestEntity contactUs) async {
    try {
      final resp = await _networkHandler.post(
          path: "${Endpoint.CONTACT_US}?Body=${contactUs.body}");
      if (resp.statusCode == 200 ||
          resp.statusCode == 204 ||
          resp.statusCode == 201) {
        return ContactUsResponseEntity(true);
      } else {
        throw ServerException(jsonDecode(resp.body)["message"]);
      }
    } catch (e) {
      throw e;
    }
  }
}

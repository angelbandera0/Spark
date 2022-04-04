import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';
import 'package:sparkz/feature/auction/domain/entity/parked_entity.dart';

class ListAuctionResponseModel extends ParkedEntity {
  ListAuctionResponseModel(
    int id,
    int locationId,
    String size,
    int waitTime,
    double minimunBid,
    bool isActive,
    LocationEntity location,
  ) : super(
          id,
          locationId,
          size,
          waitTime,
          minimunBid,
          isActive,
          location,
        );

  factory ListAuctionResponseModel.fromJson(Map<String, dynamic> json) {
    return ListAuctionResponseModel(
        (json['id'] as num).toInt(),
        (json['locationId'] as num).toInt(),
        json['size'] as String,
        (json['waitTime'] as num).toInt(),
        (json['minimunBid'] as double).toDouble(),
        json['isActive'] as bool,
        json['location'] != null
            ? LocationEntity.fromJson(json['location'] as Map<String, dynamic>)
            : LocationEntity.fromJson({
                "id": 0,
                "latitude": "",
                "longitude": "",
                "country": "",
                "state": "",
                "locality": ""
              }));
  }
}

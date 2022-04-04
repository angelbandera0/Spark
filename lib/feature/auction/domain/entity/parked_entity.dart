import 'package:equatable/equatable.dart';
import 'package:sparkz/feature/auction/domain/entity/location_entity.dart';

class ParkedEntity extends Equatable {
  ParkedEntity(
    this.id,
    this.locationId,
    this.size,
    this.waitTime,
    this.minimunBid,
    this.isActive,
    this.location,
  );

  final int? id;
  final int? locationId;
  final String size;
  final int waitTime;
  final double minimunBid;
  final bool isActive;

  final LocationEntity location;

  Map<String, dynamic> toJson() => {
        'id': id,
        'locationId': locationId,
        'size': size,
        'waitTime': waitTime,
        'minimunBid': minimunBid,
        //'isActive': isActive,
        'location': location.toJson()
      };

  @override
  List<Object?> get props => [];
}

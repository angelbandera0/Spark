import 'package:equatable/equatable.dart';

class StartAuctionRequestEntity extends Equatable {
  StartAuctionRequestEntity(this.entityId);
  final int entityId;

  Map<String, dynamic> toJson() => {
        'id': entityId,
      };

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

class DeleteAuctionRequestEntity extends Equatable {
  DeleteAuctionRequestEntity(this.entityId);
  final int entityId;

  @override
  List<Object?> get props => [];
}

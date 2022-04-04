import 'package:equatable/equatable.dart';

class ListAuctionRequesEntity extends Equatable {
  ListAuctionRequesEntity(this.pageNumber, this.pageSize);
  final int pageNumber;
  final int pageSize;

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

class ListUnparkedRequestEntity extends Equatable {
  final String orderBy;
  final String orderDirection;
  final int pageNumber;
  final int pageSize;
  ListUnparkedRequestEntity(
      this.orderBy, this.orderDirection, this.pageNumber, this.pageSize);

  @override
  List<Object?> get props => [];
}

import 'package:equatable/equatable.dart';

class ListCardRequstEntity extends Equatable {
    final String orderBy;
    final String orderDirection;
    final int pageNumber;
    final int pageSize;
  ListCardRequstEntity(this.orderBy, this.orderDirection, this.pageNumber, this.pageSize);

  @override
  List<Object?> get props => [];

}
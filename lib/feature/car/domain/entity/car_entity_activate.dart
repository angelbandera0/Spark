import 'package:equatable/equatable.dart';

class CarEntityActivate extends Equatable {
  final int id;
  final bool isActive;

  CarEntityActivate(this.id, this.isActive);

  Map<String, dynamic> toJson() => {
        'id': id,
        'active': isActive,
      };

  @override
  List<Object?> get props => [];
}

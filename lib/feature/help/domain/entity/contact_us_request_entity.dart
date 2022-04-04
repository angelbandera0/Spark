import 'package:equatable/equatable.dart';

class ContactUsRequestEntity extends Equatable {
  final String body;

  ContactUsRequestEntity(this.body);

  Map<String, dynamic> toJson() => {'body': body};

  @override
  List<Object?> get props => [];
}

import 'package:my_sql_database/database/models/abstract_identifiable_model.dart';

class UserEntity extends AbstractIdentifiableEntity {
  String? email;
  String? password;

  UserEntity({
    required super.id,
    required this.email,
    required this.password
  });

  UserEntity.create({
    required this.email,
    required this.password
  }) : super.create();

  UserEntity.empty({
    super.id,
    this.email,
    this.password
  });
}
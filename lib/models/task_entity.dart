import 'package:my_sql_database/database/models/abstract_identifiable_model.dart';

class TaskEntity extends AbstractIdentifiableEntity {
  String? title;
  String? content;
  int? startHour;
  int? endHour;
  DateTime? date;
  bool? sendNotification;
  String? fkUserId;

  TaskEntity({
    required super.id,
    required this.title,
    required this.startHour,
    required this.endHour,
    required this.date,
    required this.sendNotification,
    required this.fkUserId,
    this.content = ""
  });

  TaskEntity.create({
    required this.title,
    required this.startHour,
    required this.endHour,
    required this.date,
    required this.sendNotification,
    required this.fkUserId,
    this.content = ""
  }) : super.create();

  TaskEntity.empty({
    super.id,
    this.title,
    this.startHour,
    this.endHour,
    this.date,
    this.sendNotification,
    this.content,
    this.fkUserId
  });
}
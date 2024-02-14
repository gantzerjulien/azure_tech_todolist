import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:my_sql_database/database/definitions/columns/bool_column.dart';
import 'package:my_sql_database/database/definitions/columns/date_time_column.dart';
import 'package:my_sql_database/database/definitions/columns/int_column.dart';
import 'package:my_sql_database/database/definitions/columns/string_column.dart';
import 'package:my_sql_database/database/definitions/tables/abstract_identifiable_table.dart';

class TaskTable extends AbstractIdentifiableTable<TaskEntity> {
  late final StringColumn<TaskEntity> title;
  late final StringColumn<TaskEntity> content;
  late final IntColumn<TaskEntity> startHour;
  late final IntColumn<TaskEntity> endHour;
  late final DateTimeColumn<TaskEntity> date;
  late final BoolColumn<TaskEntity> sendNotification;
  late final StringColumn<TaskEntity> fkUserId;

  TaskTable() : super("TASK", () => TaskEntity.empty()) {
    title = StringColumn(this, "TITLE", (model) => model.title, (model, value) => model.title = value);
    super.columns.add(title);

    content = StringColumn(this, "CONTENT", (model) => model.content, (model, value) => model.content = value);
    super.columns.add(content);

    startHour = IntColumn(this, "START_HOUR", (model) => model.startHour, (model, value) => model.startHour = value);
    super.columns.add(startHour);

    endHour = IntColumn(this, "END_COLUMN", (model) => model.endHour, (model, value) => model.endHour = value);
    super.columns.add(endHour);

    date = DateTimeColumn(this, "DATE", (model) => model.date, (model, value) => model.date = value);
    super.columns.add(date);

    sendNotification = BoolColumn(this, "SEND_NOTIFICATION", (model) => model.sendNotification, (model, value) => model.sendNotification = value);
    super.columns.add(sendNotification);

    fkUserId = StringColumn(this, "FK_USER_ID", (model) => model.fkUserId, (model, value) => model.fkUserId = value);
    super.columns.add(fkUserId);
  }

}
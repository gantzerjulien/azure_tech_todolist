import 'package:azure_tech_todolist/models/user_entity.dart';
import 'package:my_sql_database/database/definitions/columns/string_column.dart';
import 'package:my_sql_database/database/definitions/tables/abstract_identifiable_table.dart';

class UserTable extends AbstractIdentifiableTable<UserEntity> {
  late final StringColumn<UserEntity> email;
  late final StringColumn<UserEntity> password;

  UserTable() : super("USER", () => UserEntity.empty()) {
    email = StringColumn(this, "EMAIL", (model) => model.email, (model, value) => model.email = value);
    super.columns.add(email);

    password = StringColumn(this, "PASSWORD", (model) => model.password, (model, value) => model.password = value);
    super.columns.add(password);
  }
}
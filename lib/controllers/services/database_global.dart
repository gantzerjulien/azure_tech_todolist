import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:azure_tech_todolist/models/task_table.dart';
import 'package:azure_tech_todolist/models/user_entity.dart';
import 'package:my_sql_database/database/database_script_generator.dart';
import 'package:my_sql_database/database/repositories/repository.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:azure_tech_todolist/models/user_table.dart';

UserEntity? globalUserConnected;

final TaskTable globalTaskTable = TaskTable();
final UserTable globalUserTable = UserTable();

late final Repository<TaskEntity> globalTaskRepository;
late final Repository<UserEntity> globalUserRepository;

abstract class DatabaseBuilder {
  static bool isInit = false;

  static Future<void> buildDb() async {
    //Just to avoid error for hot reload
    if (isInit) {
      return;
    }
    globalTaskTable.setForeignKey(globalTaskTable.fkUserId, globalUserTable);

    List<String> scripts = [
      DatabaseScriptGenerator.createTable(globalTaskTable),
      DatabaseScriptGenerator.createTable(globalUserTable)
    ];

    Database database = await openDatabase(
        join(await getDatabasesPath(), 'database.db'), version: 1,
        onCreate: (db, version) {
          db.execute("PRAGMA foreign_keys = ON");
          for (var script in scripts) {
            db.execute(script);
          }
        });

    globalTaskRepository = Repository(database, globalTaskTable);
    globalUserRepository = Repository(database, globalUserTable);

    isInit = true;
  }
}
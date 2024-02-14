import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_pages/utils/abstract_loading_page_state.dart';
import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';

class DayPage extends StatefulWidget {
  static const String route = "calendar/day";
  const DayPage({super.key});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends AbstractLoadingPageState<DayPage> {
  late List<TaskEntity> _tasks = [];

  @override
  void initState() {
    super.initState();
    super.loadData(_loadData);
  }

  Future<void> _loadData() async {
    _tasks = await globalTaskRepository.findByObjectAnd(TaskEntity.empty(
      date: DateTime(2024),
      fkUserId: globalUserConnected!.id
    ));
  }

  Future<void> _createTask() async {
    TaskEntity newTask = TaskEntity.create(
        fkUserId: globalUserConnected!.id,
        title: "title",
        startHour: 5,
        endHour: 6,
        date: DateTime(2024),
        sendNotification: true
    );
    await globalTaskRepository.insertObject(TaskEntity.create(
        fkUserId: globalUserConnected!.id,
        title: "title",
        startHour: 5,
        endHour: 6,
        date: DateTime(2024),
        sendNotification: true
    ));

    setState(() {
      _tasks.add(newTask);
    });
  }


    @override
  Widget getWidget() {
    return AzureTechTodolistScaffold(
        title: _tasks.length.toString(), //TODO: add date here
        canGoBack: true,
        body: MyElevatedButton(
          text: "+",
          onPressed: _createTask,
        )
    );
  }
}

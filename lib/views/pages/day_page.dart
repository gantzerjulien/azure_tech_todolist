import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/controllers/services/date_service.dart';
import 'package:azure_tech_todolist/views/forms/task_form.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:my_pages/utils/abstract_loading_page_state.dart';
import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:my_widgets/enums/color_enum.dart';
import 'package:my_widgets/enums/icon_enum.dart';
import 'package:my_widgets/models/bool_change_notifier.dart';
import 'package:my_widgets/utils/my_pop_up_utils.dart';
import 'package:my_widgets/utils/my_snackbar_utils.dart';
import 'package:my_widgets/widgets/my_icon_button.dart';
import 'package:my_widgets/widgets/my_text.dart';

class DayPage extends StatefulWidget {
  static const String route = "calendar/day";

  final DateTime date;

  const DayPage({super.key, required this.date});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends AbstractLoadingPageState<DayPage> {
  late List<TaskEntity> _tasks = [];
  final GlobalKey<TaskFormState> _taskFormKey = GlobalKey();
  //This field is set in the initState to avoid being rebuild
  late final BoolChangeNotifier _isReadyChangeNotifier;

  @override
  void initState() {
    super.initState();
    _isReadyChangeNotifier = BoolChangeNotifier(true);
    super.loadData(_loadData);
  }

  Future<void> _loadData() async {
    _tasks = await globalTaskRepository.findByObjectAnd(
      TaskEntity.empty(
        date: widget.date,
        fkUserId: globalUserConnected!.id
      )
    );
  }

  Future<bool> _update() async {
    if (await _taskFormKey.currentState!.validate()) {
      TaskEntity task = _taskFormKey.currentState!.getData();
      await globalTaskRepository.updateObject(task);
      if (context.mounted) {
        MySnackBarUtils.showSuccess(context, "Tâche modifiée");
      }

      super.loadData(_loadData);

      return true;
    } else {
      return false;
    }
  }

  Future<bool> _save() async {
    if (await _taskFormKey.currentState!.validate()) {
      TaskEntity task = _taskFormKey.currentState!.getData();
      await globalTaskRepository.insertObject(task);

      if (context.mounted) {
        MySnackBarUtils.showSuccess(context, "Nouvelle tâche créée");
      }

      setState(() {
        _tasks.add(task);
      });

      return true;
    } else {
      if (context.mounted) {
        MySnackBarUtils.showError(context, "Une erreur est survenue dans la création de la tâche. Veuillez contacter le support à l'addresse suivante : todolist@at.fr");
      }

      return true;
    }

  }

  Future<void> _createTask() async {
    MyPopUpUtils.widgetPopUp(
      context: context,
      title: "Créer une nouvelle tâche",
      widget: SingleChildScrollView(
        child: TaskForm(
          key: _taskFormKey,
          isReadyChangeNotifier: _isReadyChangeNotifier,
          date: widget.date
        )
      ),
      saveFunction: _save,
      isReadyToSave: _isReadyChangeNotifier
    );
  }

  Future<void> _updateTask(TaskEntity task) async {
    MyPopUpUtils.widgetPopUp(
        context: context,
        title: "Modifier la tâche",
        widget: SingleChildScrollView(
          child: TaskForm(
            key: _taskFormKey,
            isReadyChangeNotifier: _isReadyChangeNotifier,
            date: widget.date,
            task: task
          )
        ),
        saveFunction: _update,
        isReadyToSave: _isReadyChangeNotifier
    );
  }

  List<Widget> _getTasks() {
    List<Widget> children = [];

    for (TaskEntity task in _tasks) {
      children.add(
        ListTile(
          title: MyText(task.title!),
          leading: MyText("${DateService.formatHour(task.startHour!)} -> ${DateService.formatHour(task.endHour!)}"),
          //onLongPress: TODO: update the timeline,
          onTap: () => _updateTask(task),
          trailing: MyIconButton(iconEnum: MyIconEnum.close, onPressed: () => _delete(task))
        )
      );
    }

    return children;
  }

  Future<void> _delete(TaskEntity task) async {
    await globalTaskRepository.deleteByPrimaryKey(task.id!);
    setState(() {
      _tasks.remove(task);
    });
  }

  @override
  Widget getWidget() {
    return AzureTechTodolistScaffold(
      title: DateService.formatDate(widget.date),
      canGoBack: true,
      body: Column(
        children: [
          Center(
            child: FloatingActionButton(
              onPressed: _createTask,
              foregroundColor: MyColorEnum.white,
              backgroundColor: MyColorEnum.darkGreen,
              shape: const CircleBorder(),
              child: const Text("+")
            )
          ),
          Expanded(
            child: SingleChildScrollView(child: Column(children: _getTasks()))
          )
        ]
      )
    );
  }
}

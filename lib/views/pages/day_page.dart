import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/views/forms/task_form.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_pages/utils/abstract_loading_page_state.dart';
import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:my_widgets/models/bool_change_notifier.dart';
import 'package:my_widgets/utils/my_pop_up_utils.dart';
import 'package:my_widgets/utils/my_snackbar_utils.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';

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
    _tasks = await globalTaskRepository.findByObjectAnd(TaskEntity.empty(
      date: widget.date,
      fkUserId: globalUserConnected!.id
    ));
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

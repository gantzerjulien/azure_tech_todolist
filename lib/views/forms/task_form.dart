import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:my_forms/abstract_form_widget_model.dart';
import 'package:my_forms/abstract_form_with_data.dart';
import 'package:my_forms/models/text_field_form_model.dart';
import 'package:my_widgets/widgets/my_text.dart';

class TaskForm extends AbstractFormWithData {
  final DateTime date;
  final TaskEntity? task;

  const TaskForm({
    super.key,
    required super.isReadyChangeNotifier,
    required this.date,
    this.task
  });

  @override
  State<TaskForm> createState() => TaskFormState();
}

class TaskFormState extends AbstractFormWithDataState<TaskForm, TaskEntity> {
  late final TextEditingController _titleController = TextEditingController(text: widget.task?.title);
  late final TextEditingController _contentController = TextEditingController(text: widget.task?.content);
  late final TextEditingController _startHourController = TextEditingController(text: widget.task?.startHour.toString());
  late final TextEditingController _endHourController = TextEditingController(text: widget.task?.endHour.toString());
  late final ValueNotifier<bool> _sendNotificationNotifier = ValueNotifier(widget.task?.sendNotification ?? false);

  @override
  TaskEntity getData() {
    if (widget.task != null) {
      return TaskEntity(
        id: widget.task!.id,
        title: _titleController.text,
        content: _contentController.text,
        startHour: int.parse(_startHourController.text),
        endHour: int.parse(_endHourController.text),
        date: widget.date,
        sendNotification: _sendNotificationNotifier.value,
        fkUserId: globalUserConnected!.id
      );
    } else {
      return TaskEntity.create(
        title: _titleController.text,
        content: _contentController.text,
        startHour: int.parse(_startHourController.text),
        endHour: int.parse(_endHourController.text),
        date: widget.date,
        sendNotification: _sendNotificationNotifier.value,
        fkUserId: globalUserConnected!.id
      );
    }
  }

  String? _validateHourFormat(String str) {
    int? hour = int.tryParse(str);

    if (hour == null) {
      double? d = double.tryParse(str);
      return d == null ? "L'heure doit uniquement contenir des chiffres." : "L'heure doit être un nombre entier.";
    }

    if (hour > 24) {
      return "L'heure ne doit pas dépasser 24.";
    }

    if (hour < 0) {
      return "L'heure ne doit pas être un nombre négatif.";
    }

    //TODO: find a way to check if startHour is after endHour

    return null;
  }

  @override
  List<AbstractFormWidgetModel> getWidgetModelList() {
    List<AbstractFormWidgetModel> res = [];

    res.add(
      TextFieldFormModel(
        controller: _titleController, 
        text: "Titre"
      )
    );
    
    res.add(
      TextFieldFormModel(
        controller: _contentController,
        text: "Description",
        numberMaxOfLines: 5
      )
    );

    res.add(
      TextFieldFormModel(
        controller: _startHourController,
        text: "Heure de début",
        keyBoardType: TextInputType.number,
        validator: _validateHourFormat
      )
    );

    res.add(
      TextFieldFormModel(
        controller: _endHourController,
        text: "Heure de fin",
        keyBoardType: TextInputType.number,
        validator: _validateHourFormat
      )
    );

    res.add(
      CheckBoxFormModel(
        notifier: _sendNotificationNotifier,
        text: "Envoyer une notification"
      )
    );

    return res;
  }
}

class CheckBoxFormModel extends AbstractFormWidgetModel {
  bool initialValue;
  final ValueNotifier<bool> notifier;
  final GlobalKey<MyCheckBoxState> key;

  CheckBoxFormModel({
    required ValueNotifier<bool> notifier,
    String text = ""
  }) : this._internal(
      notifier: notifier,
      initialValue: notifier.value,
      key: GlobalKey(),
      text: text
  );

  CheckBoxFormModel._internal({
    required this.initialValue,
    required this.notifier,
    required this.key,
    required String text,
  }) : super(
      MyCheckBox(key: key, notifier: notifier, text: text)
  );

  @override
  void disable() {
    key.currentState!.disable();
  }

  @override
  void enable() {
    key.currentState!.enable();
  }

  @override
  bool isReady() {
    return true;
  }

  @override
  void reset() {
    key.currentState!.value = initialValue;
  }

  @override
  Future<bool> validate() async {
    //To keep the new "initial value", in case of another modification.
    initialValue = key.currentState!.value;
    return true;
  }

}
class MyCheckBox extends StatefulWidget {
  final String text;
  final ValueNotifier<bool> notifier;
  const MyCheckBox({super.key, required this.notifier, this.text = ""});

  @override
  State<StatefulWidget> createState() {
    return MyCheckBoxState();
  }

}

class MyCheckBoxState extends State<MyCheckBox> {
  late ValueChanged<bool?>? _onChanged = _onChangedFunction;
  late bool value = widget.notifier.value;

  void _onChangedFunction(bool? value) {
    setState(() {
      widget.notifier.value = value!;
    });
  }

  void disable() {
    _onChanged = null;
  }

  void enable() {
    _onChanged = _onChangedFunction;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyText(widget.text),
        Checkbox(
          value: widget.notifier.value,
          onChanged: _onChanged
        )
      ]
    );
  }
}

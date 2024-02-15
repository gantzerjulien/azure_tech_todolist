import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/controllers/services/date_service.dart';
import 'package:azure_tech_todolist/models/task_entity.dart';
import 'package:flutter/material.dart';
import 'package:my_forms/abstract_form_widget_model.dart';
import 'package:my_forms/abstract_form_with_data.dart';
import 'package:my_forms/models/check_box_model.dart';
import 'package:my_forms/models/text_field_form_model.dart';

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
        validator: DateService.validateHourFormat
      )
    );

    res.add(
      TextFieldFormModel(
        controller: _endHourController,
        text: "Heure de fin",
        keyBoardType: TextInputType.number,
        validator: DateService.validateHourFormat
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
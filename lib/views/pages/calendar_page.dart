import 'package:azure_tech_todolist/controllers/services/date_service.dart';
import 'package:azure_tech_todolist/models/month_enum.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_widgets/enums/form_status_enum.dart';
import 'package:my_widgets/widgets/my_dropdown_button_form_field.dart';
import 'package:my_widgets/widgets/my_text_form_field.dart';
import 'package:azure_tech_todolist/views/widgets/calendar.dart';

class CalendarPage extends StatefulWidget {
  static const String route = "calendar";

  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late final ValueNotifier<MonthEnum> _monthNotifier;
  late final TextEditingController _yearController;
  late final ValueNotifier<FormStatusEnum> _yearNotifier;
  late int _year;
  late MonthEnum _month;
  late FormStatusEnum _statusYearForm;

  @override
  void initState() {
    super.initState();
    _year = 2024;
    _month = MonthEnum.values[DateTime.now().month - 1];
    _statusYearForm = FormStatusEnum.pristine;

    _monthNotifier = ValueNotifier<MonthEnum>(_month);
    _yearController = TextEditingController(text: _year.toString());
    _yearNotifier = ValueNotifier(_statusYearForm);

    _monthNotifier.addListener(_setYear);
    _yearController.addListener(_setMonth);
    _yearNotifier.addListener(_setStatusYearForm);
  }

  @override
  void dispose() {
    super.dispose();
    _monthNotifier.removeListener(_setYear);
    _yearController.removeListener(_setMonth);
    _yearNotifier.removeListener(_setStatusYearForm);
  }

  void _setStatusYearForm() {
    setState(() => _statusYearForm = _yearNotifier.value);
  }

  void _setYear() {
    setState(() => _month = _monthNotifier.value);
  }

  void _setMonth() {
    int? year = int.tryParse(_yearController.text);
    if (year != null) {
      setState(() => _year = year);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      title: "Calendrier",
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: MyTextFormField(
                  controller: _yearController,
                  text: "Année",
                  statusValueNotifier: _yearNotifier,
                  keyBoardType: TextInputType.number,
                  validator: DateService.validateYearFormat,
                )
              ),

              Expanded(
                child: MyDropdownButtonFormField<MonthEnum>(
                  initialValue: _monthNotifier.value,
                  labelText: "Mois",
                  listValues: MonthEnum.values,
                  castToStringFunction: (MonthEnum month) => month.stringValue,
                  notifier: _monthNotifier
                )
              ),
            ]
          ),
          if (_statusYearForm == FormStatusEnum.focus)
            const Text("Veuillez valider la modification de la date")
          else if (_statusYearForm == FormStatusEnum.invalid && _statusYearForm == FormStatusEnum.waiting)
            const Text("Veuillez vérifier le format de la date")
          else
            Expanded(child: Calendar(year: _year, month: _month))
        ],
      )
    );
  }
}

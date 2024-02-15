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
  late int _year;
  late MonthEnum _month;

  @override
  void initState() {
    super.initState();
    _year = 2024;
    _month = MonthEnum.values[DateTime.now().month - 1];
    _monthNotifier = ValueNotifier<MonthEnum>(_month);
    _yearController = TextEditingController(text: _year.toString());
    _monthNotifier.addListener(_setYear);
    _yearController.addListener(_setMonth);
  }

  @override
  void dispose() {
    super.dispose();
    _monthNotifier.removeListener(_setYear);
    _yearController.removeListener(_setMonth);
  }

  void _setYear() {
    setState(() => _month = _monthNotifier.value);
  }

  void _setMonth() {
     setState(() => _year = int.parse(_yearController.text));
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
                  statusValueNotifier:  ValueNotifier(FormStatusEnum.pristine),
                  keyBoardType: TextInputType.number
                //TODO: add validator
                ),
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
          Expanded(child: Calendar(year: _year, month: _month))
        ],
      )
    );
  }
}

import 'package:azure_tech_todolist/views/pages/day_page.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';

class CalendarPage extends StatefulWidget {
  static const String route = "calendar";

  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      title: "Calendrier",
      body: Center(
        child: MyElevatedButton(
          text: "Selection du jour",
          onPressed: () => Navigator.pushNamed(context, DayPage.route, arguments: DateTime(2024))
        )
      )
    );
  }
}

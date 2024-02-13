import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';

class DayPage extends StatefulWidget {
  static const String route = "calendar/day";
  const DayPage({super.key});

  @override
  State<DayPage> createState() => _DayPageState();
}

class _DayPageState extends State<DayPage> {
  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      title: "Jour", //TODO: add date here
      canGoBack: true,
      body: const Text("DayPage")
    );
  }
}

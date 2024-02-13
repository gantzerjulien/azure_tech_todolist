import 'package:azure_tech_todolist/views/pages/calendar_page.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';

class InscriptionPage extends StatefulWidget {
  static const String route = "inscription";

  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {
  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      title: "Inscription",
      canGoBack: true,
      bottomNavigationBar: false,
        body: MyElevatedButton(
        text: "Inscription",
        onPressed: () => Navigator.pushReplacementNamed(context, CalendarPage.route)
      )
    );
  }
}

import 'package:azure_tech_todolist/views/pages/calendar_page.dart';
import 'package:azure_tech_todolist/views/pages/inscription_page.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';

class ConnexionPage extends StatefulWidget {
  static const String route = "connexion";

  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      bottomNavigationBar: false,
      body: Column(
        children: [
          MyElevatedButton(
            text: "Connexion",
            onPressed: () => Navigator.pushReplacementNamed(context, CalendarPage.route)
          ),
          MyElevatedButton(
            text: "Inscription",
            onPressed: () => Navigator.pushNamed(context, InscriptionPage.route)
          )
        ]
      )
    );
  }
}

import 'package:azure_tech_todolist/views/pages/calendar_page.dart';
import 'package:azure_tech_todolist/views/pages/inscription_page.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/utils/my_snackbar_utils.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';
import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/models/user_entity.dart';

class ConnexionPage extends StatefulWidget {
  static const String route = "connexion";

  const ConnexionPage({super.key});

  @override
  State<ConnexionPage> createState() => _ConnexionPageState();
}

class _ConnexionPageState extends State<ConnexionPage> {
  Future<void> _connexion() async {
    UserEntity? user = UserEntity.empty(email: "monMail", password: "123456");
    user = await globalUserRepository.findOneByObjectAnd(UserEntity.empty(email: user.email));
    if (user == null) {
      if (context.mounted) {
        MySnackBarUtils.showError(context, "Il n'y a pas de compte correspondant à ces identifiants");
      }
    } else {
      globalUserConnected = user;
      if (context.mounted) {
        await Navigator.pushReplacementNamed(context, CalendarPage.route);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      bottomNavigationBar: false,
      body: Column(
        children: [
          MyElevatedButton(
            text: "Connexion",
            onPressed: _connexion
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

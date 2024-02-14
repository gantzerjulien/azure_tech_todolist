import 'package:azure_tech_todolist/views/pages/calendar_page.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';
import 'package:azure_tech_todolist/controllers/services/database_global.dart';
import 'package:azure_tech_todolist/models/user_entity.dart';

class InscriptionPage extends StatefulWidget {
  static const String route = "inscription";

  const InscriptionPage({super.key});

  @override
  State<InscriptionPage> createState() => _InscriptionPageState();
}

class _InscriptionPageState extends State<InscriptionPage> {

  Future<void> _inscription() async {
    UserEntity user = UserEntity.create(email: "monMail", password: "123456");
    if (await globalUserRepository.findOneByObjectAnd(UserEntity.empty(email: user.email)) == null) {
      await globalUserRepository.insertObject(user);
    }

    globalUserConnected = user;
    if (context.mounted) {
      await Navigator.pushReplacementNamed(context, CalendarPage.route);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      title: "Inscription",
      canGoBack: true,
      bottomNavigationBar: false,
      body: MyElevatedButton(
        text: "Inscription",
        onPressed: _inscription
      )
    );
  }
}

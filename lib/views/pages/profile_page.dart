import 'package:azure_tech_todolist/views/pages/connexion_page.dart';
import 'package:azure_tech_todolist/views/widgets/azure_tech_todolist_scaffold.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/widgets/my_elevated_button.dart';

class ProfilePage extends StatefulWidget {
  static const String route = "profile";
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return AzureTechTodolistScaffold(
      title: "Profil",
      body: MyElevatedButton(
        text: "Déconnecter",
        onPressed: () => Navigator.pushReplacementNamed(context, ConnexionPage.route)
      )
    );
  }
}

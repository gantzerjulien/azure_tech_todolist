import 'package:azure_tech_todolist/views/pages/day_page.dart';
import 'package:azure_tech_todolist/views/pages/calendar_page.dart';
import 'package:azure_tech_todolist/views/pages/connexion_page.dart';
import 'package:azure_tech_todolist/views/pages/inscription_page.dart';
import 'package:azure_tech_todolist/views/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:my_pages/utils/abstract_loading_page_state.dart';
import 'package:my_widgets/enums/color_enum.dart';
import 'package:azure_tech_todolist/controllers/services/database_global.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: MyColorEnum.darkGreen),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          '/' : (context) => const HomePage(),
          ConnexionPage.route : (context) => const ConnexionPage(),
          InscriptionPage.route : (context) => const InscriptionPage(),
          CalendarPage.route : (context) => const CalendarPage(),
          DayPage.route : (context) => const DayPage(),
          ProfilePage.route : (context) => const ProfilePage(),
        }
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends AbstractLoadingPageState<HomePage> {
  bool stayConnected = false;

  @override
  void initState() {
    super.initState();
    super.loadData(_loadData);
  }

  @override
  Widget getWidget() {
    return const Center(child: ConnexionPage());
  }

  Future<void> _loadData() async {
    await DatabaseBuilder.buildDb();
  }
}

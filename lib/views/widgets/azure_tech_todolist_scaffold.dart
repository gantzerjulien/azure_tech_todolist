import 'package:azure_tech_todolist/views/pages/calendar_page.dart';
import 'package:azure_tech_todolist/views/pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_widgets/enums/color_enum.dart';
import 'package:my_widgets/enums/icon_enum.dart';
import 'package:my_widgets/widgets/scaffold/my_scaffold.dart';
import 'package:my_widgets/widgets/scaffold/route.dart';
import 'package:azure_tech_todolist/models/asset_enum.dart';

class AzureTechTodolistScaffold extends MyScaffold {
  static final List<MyRoute> gameCounterRoutes = [
    MyRoute(label: "Calendrier", routePath: CalendarPage.route, icon: MyIconEnum.calendar),
    MyRoute(label: "Mon profil", routePath: ProfilePage.route, icon: MyIconEnum.profile)
  ];

  AzureTechTodolistScaffold({
    super.key,
    required Widget body,
    bool bottomNavigationBar = true,
    String title = "GameCounter",
    bool addAppBar = true,
    bool canGoBack = false,
    Color backgroundColor = MyColorEnum.white
  }) :
        super(
          body: body,
          logoPath: AssetEnum.appLogo.path,
          bottomNavigationRoutes: gameCounterRoutes,
          title: title,
          addAppBar: addAppBar,
          settingsButton: false,
          bottomNavigationBar: bottomNavigationBar,
          backGroundColor: backgroundColor,
          canGoBack: canGoBack,
          whoAreWeText: "Ceci est une application qui, je l'espère, me permettra de travailler pour Azur Tech Research."
      );
}
import 'package:azure_tech_todolist/models/month_enum.dart';
import 'package:flutter/material.dart';

class Calendar extends StatefulWidget {
  final int year;
  final MonthEnum month;

  const Calendar({required this.year, required this.month, super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _getFirstDay() {
    int month = widget.month.intValue;
    int year;
    int februaryAdjustement;
    if (month < 3) {
      year = widget.year - 1; //Because february month is not passed
      februaryAdjustement = 5;
    } else {
      year = widget.year;
      februaryAdjustement = 2;
    }

    //Magic number to alternate 30 and 31 day (ventilated by a factor of 2 for january and february)
    int alternate30and31days = 23 * month ~/ 9 + februaryAdjustement;
    // Number of leap year (yaer with 366 days). There is one every 4 years,
    // but not on new century year exept every 400 years
    int numberOfLeapYear = year ~/ 4 - year ~/ 100 + year ~/ 400;

    return (alternate30and31days + year + numberOfLeapYear) % 7;
  }

  @override
  Widget build(BuildContext context) {
    int firstDay = _getFirstDay();
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, // Number of columns
            crossAxisSpacing: 1.0,
            mainAxisSpacing: 10.0,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  if (index >= 7 && index - 7 < firstDay) {
                    return Container();
                  }
              String? day;
              switch (index) {
                case 0:
                  day = "Lundi";
                case 1:
                  day = "Mardi";
                case 2:
                  day = "Mercredi";
                case 3:
                  day = "Jeudi";
                case 4:
                  day = "Vendredi";
                case 5:
                  day = "Samedi";
                case 6:
                  day = "Dimanche";
              }

              Color? tileColor;
              if (index % 7 == 0) {
                tileColor = const Color(0xFFEF9A9A);
              } else if (index % 7 == 1) {
                tileColor = const Color(0xFFB3E5FC);
              } else if (index % 7 == 2) {
                tileColor = const Color(0xFFFFCC80);
              } else if (index % 7 == 3) {
                tileColor = const Color(0xFFFFF176);
              } else if (index % 7 == 4) {
                tileColor = const Color(0xFFF1F8E9);
              } else if (index % 7 == 5) {
                tileColor = const Color(0xFFE1BEE7);
              } else if (index % 7 == 6) {
                tileColor = const Color(0xFFBCAAA4);
              }
              return Container(
                color: tileColor,
                child: Center(
                  child: Text('${day ?? index - 7 - firstDay + 1}'),
                ),
              );
            },
            childCount: 7 + firstDay + widget.month.getNumberOfDays(widget.year),
          ),
        ),
      ],
    );
  }
}

abstract class DateService {
  static String formatDate(DateTime dateTime) {
    String month = dateTime.month < 10 ? "0${dateTime.month}" : "${dateTime.month}";
    String day = dateTime.month < 10 ? "0${dateTime.day}" : "${dateTime.day}";

    return "$day/$month";
  }

  static String formatHour(int hour) {
    return hour < 10 ? "0$hour}h" : "${hour.toString()}h";
  }

  static String? validateHourFormat(String str) {
    int? hour = int.tryParse(str);

    if (hour == null) {
      double? d = double.tryParse(str);
      return d == null ? "L'heure doit uniquement contenir des chiffres." : "L'heure doit être un nombre entier.";
    }

    if (hour > 24) {
      return "L'heure ne doit pas dépasser 24.";
    }

    if (hour < 0) {
      return "L'heure ne doit pas être un nombre négatif.";
    }

    return null;
  }

  static String? validateYearFormat(String str) {
    int? year = int.tryParse(str);

    if (year == null) {
      double? d = double.tryParse(str);
      return d == null ? "L'année doit uniquement contenir des chiffres." : "L'heure doit être un nombre entier.";
    }

    return null;
  }
}
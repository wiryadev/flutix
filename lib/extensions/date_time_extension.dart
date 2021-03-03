part of 'extensions.dart';

extension DateTimeExtension on DateTime {
  String get dateAndTime => '${this.shortDayName} ${this.day} ${this.hour}:00';

  String get shortDayName {
    switch (this.weekday) {
      case 1:
        return 'MON';
        break;
      case 2:
        return 'TUE';
        break;
      case 3:
        return 'WED';
        break;
      case 4:
        return 'THU';
        break;
      case 5:
        return 'FRI';
        break;
      case 6:
        return 'SAT';
        break;
      default:
        return 'SUN';
    }
  }
}

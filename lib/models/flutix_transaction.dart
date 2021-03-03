part of 'models.dart';

class FlutixTransaction extends Equatable {
  final String userId;
  final String title;
  final String subtitle;
  final int amount;
  final DateTime time;
  final String picture;

  FlutixTransaction({
    @required this.userId,
    @required this.title,
    @required this.subtitle,
    this.amount = 0,
    @required this.time,
    this.picture,
  });

  @override
  List<Object> get props => [
        userId,
        title,
        subtitle,
        amount,
        time,
        picture,
      ];
}

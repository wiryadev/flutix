part of 'models.dart';

class Promo extends Equatable {
  final String title;
  final String subtitle;
  final int discount;

  Promo({
    @required this.title,
    @required this.subtitle,
    @required this.discount,
  });

  @override
  // TODO: implement props
  List<Object> get props => [title, subtitle, discount];
}

List<Promo> dummyPromos = [
  Promo(
    title: 'Student Holiday',
    subtitle: 'Only for 2 peoples',
    discount: 50,
  ),
  Promo(
    title: 'Family Club',
    subtitle: 'Minimal for 3 members',
    discount: 70,
  ),
  Promo(
    title: 'Subscription Promo',
    subtitle: 'Minimum annual subscription',
    discount: 40,
  ),
];

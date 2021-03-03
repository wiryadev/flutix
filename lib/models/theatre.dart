part of 'models.dart';

class Theatre extends Equatable {
  final String name;

  Theatre(this.name);

  @override
  List<Object> get props => [name];
}

List<Theatre> dummyTheatres = [
  Theatre("CGV 23 Paskal Hyper Square"),
  Theatre("CGV Paris Van Java"),
  Theatre("XXI Cihampelas Walk"),
  Theatre("XXI Bandung Trade Center")
];

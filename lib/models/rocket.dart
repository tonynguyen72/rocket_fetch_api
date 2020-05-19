class Rocket {
  final String name;
  Rocket({this.name});

  Rocket.fromJson(Map<String, dynamic> parsed)
  : name = parsed['rocket_name'];
}
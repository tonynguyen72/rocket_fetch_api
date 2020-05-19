import 'package:flutter_space_provider/models/rocket.dart';

class Launch {
  final DateTime launchUTC;
  final Rocket rocket;

  Launch({this.launchUTC, this.rocket});

  Launch.fromJson(Map<String, dynamic> key)
      : launchUTC = DateTime.parse(key['launch_date_utc']),
        rocket = Rocket.fromJson(key['rocket']);
}

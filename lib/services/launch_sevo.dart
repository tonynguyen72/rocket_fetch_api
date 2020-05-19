import 'package:flutter_space_provider/models/launch.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
class LaunchService {
  //?
  Future<Launch> fetchLaunch() async {
    var res = await http.get('https://api.spacexdata.com/v3/launches/upcoming');

    var json = convert.jsonDecode(res.body);

    var launch = Launch.fromJson(json[3]);
    return launch;
  }

  //?
}
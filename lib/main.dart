import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_space_provider/models/launch.dart';
import 'package:flutter_space_provider/services/launch_sevo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var launchServo = LaunchService();
    return FutureProvider(
      create: (context) => launchServo.fetchLaunch(),
      child: MaterialApp(
        title: 'Rocket App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark),
        home: Home(),
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    Key key,
  }) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //?
  Timer timer;
  Launch launch;
  String countdown;

  @override
  void initState() {
    countdown = '';
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (launch != null) {
        var diff = launch.launchUTC.difference(DateTime.now().toUtc());
        setState(() {
          countdown = durationToString(diff);
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  //?
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    launch = Provider.of<Launch>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Space Launcher',
          style: GoogleFonts.ubuntu(),
        ),
        centerTitle: true,
      ),
      body: (launch == null) ? Center(child: CircularProgressIndicator())
      : Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Next Launch',
                    style: GoogleFonts.ubuntu(
                        fontSize: 12, color: Colors.redAccent),
                  ),
                  Text(
                    '$countdown' ?? 'Ready to launch',
                    style: GoogleFonts.sourceCodePro(fontSize: 50),
                  ),
                  Text(
                    launch.rocket.name,
                    style: GoogleFonts.ubuntu(fontSize: 25),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 50.0),
                child: Image.asset(
                  "assets/space.png",
                  color: Colors.white,
                ),
              ),
            ),
            Text('Launching....'),
          ],
        ),
      ),
    );
  }

  String durationToString(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return '$n';
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }
}

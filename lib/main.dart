import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:task_project/Networking.dart';
import 'package:task_project/models/Restraunt.dart';

import 'models/Banners.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//
//         home: MyHome()
//     );
//   }
// }

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Banners> futureBanner;
  Future<Map<String, dynamic>> futureRestraunt;

  @override
  void initState() {
    super.initState();
    futureBanner = Networking().fetchBanner();
    futureRestraunt = Networking().postRestraunt(1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Current Location'),
        ),
        body: Column(
          children: [getBanner(futureBanner), getSwiper(futureRestraunt)],
        ),
      ),
    );
  }
}

Center getBanner(Future<Banners> futureBanner) {
  return Center(
    child: FutureBuilder<Banners>(
      future: futureBanner,
      builder: (context, data) {
        if (data.hasData) {
          return Image.network(data.data.Banner3);
        } else if (data.hasError) {
          return Text('${data.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    ),
  );
}

Container getSwiper(Future<Map<String, dynamic>> futureRest) {
  return Container(
    width: 380,
    height: 220,
    alignment: Alignment.topLeft,
    child: FutureBuilder<Map<String, dynamic>>(
      future: futureRest,
      builder: (context, data) {
        if (data.hasData) {
          return imageSlider(data.data);
        } else if (data.hasError) {
          return Text('${data.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    ),
  );
}

Swiper imageSlider(Map<String, dynamic> urls) {
  return new Swiper(
    autoplay: true,
    itemBuilder: (BuildContext context, int index) {
      return Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                new Image.network(
                  urls["Result"][index]["Num"],
                  width: 200,
                  height: 150,
                  //fit: BoxFit.fitWidth,
                ),
              ],
            ),
            Text(
                urls["Result"][index]["amount"],
              style: TextStyle(
                fontSize: 15.0
              ),
            )
          ]
      );
    },
    itemCount: 10,
    viewportFraction: 0.8,
    scale: 0.9,
    itemHeight: 70,
  );
}

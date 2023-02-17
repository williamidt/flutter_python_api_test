import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To Python',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String grettins = '';

  /// function get data python
  dynamic getData(String url) async {

    /// final httpsUri = Uri(
    ///     scheme: 'https',
    ///     host: 'dart.dev',
    ///     path: 'guides/libraries/library-tour',
    ///     fragment: 'numbers');
    /// print(httpsUri); // https://dart.dev/guides/libraries/library-tour#numbers

    /// to real device change from 10.0.2.2 to 127.0.0.1:5000
    var uri = Uri.http('127.0.0.1', url);

    print(uri);
    var response = await http.get(uri);
    if (response.statusCode == 200) {
      var result =  convert.jsonDecode(response.body) as Map<String, dynamic>;
      print(result);
      return result;
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }


  /// start logic program
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(grettins,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          Center(
            child: SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () async {
                    var decode = await getData('/');
                    setState(() {
                      grettins = decode.toString();
                    });
                },
                child: const Text("Run python", style: TextStyle(fontSize: 24),

              )

              ),
            ),
          ),
        ],
      ),

    );
  }
}

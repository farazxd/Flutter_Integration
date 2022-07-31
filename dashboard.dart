import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
   String Url = "https://jsonplaceholder.typicode.com/users";
  getUsers() async {
    var response = await http.get(Uri.parse(Url));
    var data = jsonDecode(response.body);
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FLUTTER INTEGRATION"),),
      body: FutureBuilder(
        future: getUsers(),
        builder: (context, AsyncSnapshot snapShot) {
          if (!snapShot.hasData) {
            return const CircularProgressIndicator();
          } else {
            return ListView.builder(
                itemCount: snapShot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapShot.data[index].name),
                  );
                });
          }
        },
      ),
    );
  }
}
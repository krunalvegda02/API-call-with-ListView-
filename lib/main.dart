import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'E-commerce Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var productdata = [];
  var mydata = "";
  @override
  void initState() {
    super.initState();
    apicall();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
            itemCount: productdata.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(productdata[index]["image"].toString()),
                title: Text(productdata[index]["title"].toString()),
                subtitle: Text(productdata[index]["price"].toString()),
                trailing: Icon(Icons.arrow_forward_ios_outlined),
              );
            }));
  }

  void apicall() async {
    var url = Uri.https('fakestoreapi.com', 'products');
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    var mydata = jsonDecode(response.body);

    setState(() {
      productdata = mydata;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:gezgor/views/homepage/components/body.dart';
import 'package:gezgor/views/homepage/components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ana Sayfa"),),
      drawer: const DrawerWidget(),
      body: const Body(),
    );
  }
}

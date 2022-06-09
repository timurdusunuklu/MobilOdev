import 'package:flutter/material.dart';
import 'package:gezgor/views/categorypage/components/body.dart';

class CategoryPage extends StatefulWidget {
  String title, tur;
  CategoryPage({Key? key, required this.title, required this.tur}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title, style: const TextStyle(fontSize: 14),),),
      body: Body(tur: widget.tur),
    );
  }
}

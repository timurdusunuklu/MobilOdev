import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gezgor/views/detailpage/components/body.dart';
import 'package:gezgor/views/detailpage/components/starsdialog.dart';

class DetailPage extends StatefulWidget {
  String id;
  String baslik;
  String yorumid;
  DetailPage({Key? key, required this.id, required this.baslik, required this.yorumid}) : super(key: key);

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.baslik} Detay"),
        actions: [
          TextButton(
            child: const Text("Puanla", style: TextStyle(color: Colors.white),),
            onPressed: (){
              Get.dialog( StarsDialog(id: widget.id,));
            },
          ),
        ],
      ),
      body: Body(id: widget.id, yorumid: widget.yorumid),
    );
  }
}

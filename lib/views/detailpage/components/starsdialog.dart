import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:get/get.dart';
import 'package:gezgor/service/provider/oymodel.dart';
import 'package:gezgor/service/provider/oytoplammodel.dart';
import 'package:gezgor/service/provider/starmodel.dart';
import 'package:provider/provider.dart';

class StarsDialog extends StatelessWidget {
  String id;
  StarsDialog({Key? key, required this.id}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Oyla"),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Row(
        children: [
          SizedBox(
            height: 15,
            child: RatingStars(
              value: context.watch<StarModel>().valRead(),
              onValueChanged: (val){
                context.read<StarModel>().valChange(val);
              },
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("Oyla"),
          onPressed: (){
            FirebaseFirestore.instance.collection('konumlar').doc(id).update({
              'puan': context.read<StarModel>().valRead() + context.read<OyModel>().valRead(),
              'puanveren': context.read<OyToplamModel>().valRead() + 1,
            });
            context.read<StarModel>().valChange(0.0);
            Get.back();
          },
        ),
      ],
    );
  }
}

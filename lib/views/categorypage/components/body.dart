// ignore_for_file: must_be_immutable
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gezgor/service/provider/oymodel.dart';
import 'package:gezgor/service/provider/oytoplammodel.dart';
import 'package:gezgor/views/detailpage/detailpage.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  String tur;
  Body({Key? key, required this.tur}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('konumlar').snapshots(),
        builder: (_, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (_, index){
                var yildiz;
                DocumentSnapshot doc = snapshot.data!.docs[index];
                if(doc['puan'] == 0){
                  yildiz = 0.0;
                }else{
                  yildiz = doc['puan'] / doc['puanveren'];
                }
                if(tur == doc['tur']){
                  return Card(
                    child: ListTile(
                      title: Text(doc['name']),
                      subtitle: Text("${doc['aciklama'].toString().substring(0, 100)}..."),
                      leading: Image.network(doc['onresim'], width: 70,),
                      trailing: Text(yildiz.toString().substring(0, 3)),
                      onTap: (){
                        context.read<OyToplamModel>().valChange(doc['puanveren']);
                        context.read<OyModel>().valChange(doc['puan']);
                        Get.to(DetailPage(id: doc.id, baslik: doc['name'],yorumid: doc['yorumid'],));
                      },
                    ),
                  );
                }else{
                  return Container();
                }
              },
            );
          }else{
            return const Center(child: Text("Veriler Yükleniyor"),);
          }
        },
      ),
    );
  }
}

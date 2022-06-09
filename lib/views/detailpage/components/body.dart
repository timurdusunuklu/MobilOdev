// ignore_for_file: must_be_immutable
import 'package:gezgor/views/detailpage/components/comment.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
class Body extends StatelessWidget {
  String id, yorumid;
  Body({Key? key, required this.id, required this.yorumid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height * 0.78,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('konumlar').snapshots(),
                builder: (_, snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (_, index){
                        DocumentSnapshot doc = snapshot.data!.docs[index];
                        var yildiz;
                        if(doc['puan'] == 0){
                          yildiz = 0.0;
                        }else{
                          yildiz = doc['puan'] / doc['puanveren'];
                        }
                        if(id == doc.id){
                          List list = doc['resimler'];
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Açıklama: ${doc['aciklama']}"),
                              const SizedBox(height: 10,),
                              Text("Üçret: ${doc['ucret']}"),
                              const SizedBox(height: 10,),
                              Text("Açık olduğu süre: ${doc['zaman']}"),
                              const SizedBox(height: 10,),
                              Text("Puan: $yildiz"),
                              const SizedBox(height: 10,),
                              SizedBox(
                                width: size.width,
                                height: 280,
                                child:ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: list.length,
                                  itemBuilder: (_, index){
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(list[index]),
                                    );
                                  },
                                ),
                              ),
                            ],
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
            ),
            SizedBox(
              width: size.width,
              height: 54,
              child: ElevatedButton(
                child: const Text("Yorumlar"),
                onPressed: (){
                  Get.bottomSheet(Comment(yorumid: yorumid,));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

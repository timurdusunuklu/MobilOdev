import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comment extends StatelessWidget {
  String yorumid;

  Comment({Key? key, required this.yorumid}) : super(key: key);
  final _yorum = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 9,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(32), topRight: Radius.circular(31)),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8, top: 32),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: size.height * 0.4,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('yorumlar')
                      .doc(yorumid)
                      .collection('yorumlar')
                      .snapshots(),
                  builder: (_, snapshot) {
                    if (snapshot.data!.size != 0) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot doc = snapshot.data!.docs[index];
                          return ListTile(
                            title: Text(doc['isim']),
                            subtitle: Text(doc['yorum']),
                          );
                        },
                      );
                    } else {
                      return const Center(
                        child: Text("Yapılmış Yorum Yok"),
                      );
                    }
                  },
                ),
              ),
              TextField(
                controller: _yorum,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      FirebaseFirestore.instance
                          .collection('yorumlar')
                          .doc(yorumid)
                          .collection('yorumlar')
                          .doc()
                          .set({
                        'isim':FirebaseAuth.instance.currentUser!.displayName,
                        'yorum': _yorum.text,
                      });
                      _yorum.clear();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

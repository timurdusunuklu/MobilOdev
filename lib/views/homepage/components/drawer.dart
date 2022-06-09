import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gezgor/views/auth/login/loginpage.dart';
import 'package:gezgor/views/categorypage/categorypage.dart';
import 'package:gezgor/views/favoripage/favoripage.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
              accountName: Text(FirebaseAuth.instance.currentUser!.displayName.toString()),
              accountEmail: Text(FirebaseAuth.instance.currentUser!.email.toString()),),
          ListTile(
            title: const Text("Favoriler"),
            onTap: (){
              Get.back();
              Get.to(const FavoriPage());
            },
          ),
          ListTile(
            title: const Text("Parklar"),
            onTap: (){
              Get.back(); //20 
              Get.to(CategoryPage(title: "20 Park'tan 5 tanesi gösteriliyor", tur: 'park'));
            },
          ),
          ListTile(
            title: const Text("Kütüphaneler"),
            onTap: (){
              Get.back(); //47
              Get.to(CategoryPage(title: "47 Kütüphane'den 5 tanesi gösteriliyor", tur: 'kutuphane'));
            },
          ),
          ListTile(
            title: const Text("Tarihi Yerler"),
            onTap: (){
              Get.back(); // 61
              Get.to(CategoryPage(title: "61 Tarihi Yer' den 5 tanesi gösteriliyor", tur: 'tarihi'));
            },
          ),
          ListTile(
            title: const Text("Oteller"),
            onTap: (){
              Get.back(); // 166
              Get.to(CategoryPage(title: "166 Otel'den 5 tanesi gösteriliyor", tur: 'otel'));
            },
          ),
          ListTile(
            title: const Text("Marketler"),
            onTap: (){
              Get.back(); // 39
              Get.to(CategoryPage(title: "39 Market'ten 5 tanesi gösteriliyor", tur: 'market'));
            },
          ),
          ListTile(
            title: const Text("İbadet Yerleri"),
            onTap: (){
              Get.back(); // 3200
              Get.to(CategoryPage(title: "3200 İbadet Yerinden 5 tanesi gösteriliyor", tur: 'ibadet'));
            },
          ),
          ListTile(
            title: const Text("Otoparklar"),
            onTap: (){
              Get.back(); // 20
              Get.to(CategoryPage(title: "20 Otopark'tan 3 tanesi gösteriliyor", tur: 'otopark'));
            },
          ),
          ListTile(
            title: const Text("Çıkış Yap"),
            onTap: (){
              FirebaseAuth.instance.signOut();
              Get.offAll(const LoginPage());
            },
          ),
        ],
      ),
    );
  }
}
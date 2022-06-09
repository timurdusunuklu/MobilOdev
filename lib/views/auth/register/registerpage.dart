// ignore_for_file: depend_on_referenced_packages

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gezgor/service/auth/authservice.dart';
import 'package:gezgor/views/auth/login/loginpage.dart';
import 'package:gezgor/views/auth/register/registerpage_controller.dart';
import 'package:gezgor/views/homepage/homepage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late bool loading = false;
  final key = GlobalKey<FormState>();
  final _namecontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(
                        left: 16, bottom: 2, top: 84.70588393689854),
                    child: Text(
                      "Üye Ol",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: _namecontroller,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "Kullanıcı Adı",
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(fontSize: 15),
                  ),
                  validator: (value){
                    if(value != null && value.length < 4){
                      return 'Min. 4 karakter';
                    }else{return null;}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: _emailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: "E-posta",
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(fontSize: 15),
                  ),
                  validator: (value){
                    if(!EmailValidator.validate(value!)){
                      return 'Eposta Geçersiz';
                    }else{
                      return null;
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TextFormField(
                  controller: _passwordcontroller,
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  decoration: const InputDecoration(
                      labelText: "Şifre",
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(fontSize: 15),
                  ),
                  validator: (value){
                    if(value!.length < 8){
                      return 'Min. 8 karakter';
                    }else{return null;}
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
                child: GestureDetector(
                  onTap: () {
                    final valide = key.currentState!.validate();
                    if(valide){
                      setState(() {
                        loading = !loading;
                      });
                      Register(
                          name: _namecontroller.text,
                          email: _emailcontroller.text,
                          password: _passwordcontroller.text)
                          .register()
                          .then((value) {
                        if (value.toString() == "olumlu") {
                          setState(() {
                            loading = !loading;
                          });
                          Get.back();
                          Get.offAll(const HomePage());
                        }
                        if (value.toString().contains("invalid-email")) {
                          setState(() {
                            loading = !loading;
                          });
                          Get.snackbar("Hata", "e-posta biçimi yanlış", backgroundColor: Colors.red, icon: const Icon(Icons.error_outline),duration: const Duration(seconds: 4));
                        }
                        if (value.toString().contains("email-already-in-use")) {
                          setState(() {
                            loading = !loading;
                          });
                          Get.snackbar("Hata", "e-posta adresi sisteme kayıtlı", backgroundColor: Colors.red, icon: const Icon(Icons.error_outline),duration: const Duration(seconds: 4));
                        }
                      });
                    }
                  },
                  child: loading
                      ? Container(
                          height: 40,
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          height: 40,
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Üyeliğini Oluştur",
                                style:
                                    TextStyle(color: Colors.white, fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16)),
              OrDivider(),
              const Padding(padding: EdgeInsets.only(top: 16)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Üyeliğin var mı?",
                    style: TextStyle(fontSize: 15),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 3)),
                  GestureDetector(
                    onTap: () {
                      Get.to(const LoginPage());
                    },
                    child: const Text(
                      "Giriş Yap",
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

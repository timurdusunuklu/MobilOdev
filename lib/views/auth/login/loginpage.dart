import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gezgor/service/auth/authservice.dart';
import 'package:gezgor/views/auth/login/loginpage_controller.dart';
import 'package:gezgor/views/auth/register/registerpage.dart';
import 'package:gezgor/views/homepage/homepage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late bool loading = false;
  final key = GlobalKey<FormState>();
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
                      "Giriş Yap",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                  ),
                ],
              ),
              Container(
                height: 30,
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
                      Login(
                          password: _passwordcontroller.text,
                          email: _emailcontroller.text)
                          .login()
                          .then((value) {
                        if (value.toString() == "olumlu") {
                          Get.offAll(const HomePage());
                        }
                        if (value.toString().contains("user-not-found")) {
                          setState(() {
                            loading = !loading;
                          });
                          Get.snackbar("Hata", "Kullanıcı mevcut değil", backgroundColor: Colors.red, icon: const Icon(Icons.error_outline),duration: const Duration(seconds: 4),);
                        }
                        if (value.toString().contains("invalid-email")) {
                          setState(() {
                            loading = !loading;
                          });
                          Get.snackbar("Hata", "e-posta biçimi yanlış", backgroundColor: Colors.red, icon: const Icon(Icons.error_outline),duration: const Duration(seconds: 4));
                        }
                        if (value.toString().contains("wrong-password")) {
                          setState(() {
                            loading = !loading;
                          });
                          Get.snackbar("Hata", "şifre yanlış", backgroundColor: Colors.red, icon: const Icon(Icons.error_outline),duration: const Duration(seconds: 4));
                        }
                      });
                    }
                  },
                  child: loading
                      ? Container(
                          height: 50,
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
                          height: 50,
                          color: Colors.blue,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                "Giriş Yap",
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
                    "Henüz bir üyeliğin yok mu?",
                    style: TextStyle(fontSize: 15),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 3)),
                  GestureDetector(
                    onTap: () {
                      Get.to(const RegisterPage());
                    },
                    child: const Text(
                      "Hemen Üye Ol",
                      style: TextStyle( fontSize: 15),
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


import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final FirebaseFirestore firestore = FirebaseFirestore.instance;
class Register{
  String name;
  String email;
  String password;
  Register({
    required this.name,
    required this.email,
    required this.password
  });
  Future register()async{
    try{
      var user = await auth.createUserWithEmailAndPassword(email: email, password: password);
      var updateName = FirebaseAuth.instance.currentUser;
      updateName!.updateDisplayName(name);
      user.user!.sendEmailVerification();
      var uid = user.user!.uid;
      await firestore.collection("users").doc(user.user!.uid).set({
        'name': name,
        'email':email,
        'uid':uid,
        'password':password,
      });
      return "olumlu";
    }on FirebaseAuthException catch(e){
      return e;
    }
  }
}

class Login{
  String password;
  String email;

  Login({
    required this.password,
    required this.email
  });
  Future login() async{
    try{
       await auth.signInWithEmailAndPassword(email: email, password: password);
      return "olumlu";
    }on FirebaseAuthException catch(e){
      return e;
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../core/firebase_functions.dart';
import '../model/user_model.dart';

class AuthProvider extends ChangeNotifier{
  User? firebaseUser;
  UserModel? userModel;

  AuthProvider(){
    firebaseUser = FirebaseAuth.instance.currentUser;
    if(firebaseUser != null){
      initUser();
    }
  }
  initUser()async{
    userModel = await FirebaseFunctions.readUser();
    notifyListeners();

  }
}
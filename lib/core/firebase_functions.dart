
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../model/task_model.dart';
import '../model/user_model.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection("Tasks")
        .withConverter<TaskModel>(
      fromFirestore: (snapshot, _) {
        return TaskModel.fromJson(snapshot.data()!);
      },
      toFirestore: (value, _) {
        return value.toJson();
      },
    );
  }

  static Future<void> createTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc();
    task.id = docRef.id;
    return docRef.set(task);
  }
  static Future<void> saveUser(UserModel user){
    var collection =getTasksCollection() ;
    var docR = collection.doc(user.id);
    return docR.set(user as TaskModel);
  }

  static Future<void> updateTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc(task.id);

    return docRef.update(task.toJson());
  }

  static Future<void> deleteTask(TaskModel task) {
    var collection = getTasksCollection();
    var docRef = collection.doc(task.id);

    return docRef.delete();
  }

  static  Stream<QuerySnapshot<TaskModel>> getFavoriteStream(){
    var collection =getTasksCollection() ;
    var data = collection
        .where("userId",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where("isFavorite",isEqualTo: true).snapshots();
    return data;
  }
  static readUser()async{
    var collection =getTasksCollection() ;
    DocumentSnapshot<TaskModel> data =
    await collection.doc(FirebaseAuth.instance.currentUser!.uid).get();
    return data.data();

  }

  static Stream<QuerySnapshot<TaskModel>> getTasksStream({String? category}) {
    var collection = getTasksCollection();

    var data;
    if (category != null) {
      data = getTasksCollection()
          .where("category", isEqualTo: category)
          .snapshots();
    } else {
      data = getTasksCollection().snapshots();
    }
    return data;
  }
  static Future<void> resetPassword(
      String email,
      {
        required Function onSuccess,
        required Function onError
      }) async{
    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onSuccess();
        onError('No user found for that email.');
      } else {
        onError(e.code);
      }
    } catch (e) {
      onError(e.toString());
    }

  }

  static Future<QuerySnapshot<TaskModel>> getTasks({String? category}) async {
    var collection = getTasksCollection();
    QuerySnapshot<TaskModel> data;
    if (category != null) {
      data = await collection.where("category", isEqualTo: category).get();
    } else {
      data = await collection.get();
    }

    return data;
  }
  static Future<void> signOut() async{
    await FirebaseAuth.instance.signOut();
  }

  static Future<void> login(
      String emailAddress,
      String password, {
        required Function onSuccess,
        required Function onError,
      }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      if (credential.user!.emailVerified) {
        onSuccess();
      } else {
        onError("Email not verified");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        onError('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        onError('Wrong password provided for that user.');
      } else {
        onError(e.code);
      }
    }
  }

  static Future<void> createUser(
      String email,
      String password,
      String name, {
        required Function onSuccess,
        required Function onError,
      }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      credential.user!.sendEmailVerification();
      onSuccess();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        onError('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        onError('The account already exists for that email.');
      } else {
        onError(e.code);
      }
    } catch (e) {
      onError(e.toString());
    }
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/user.model.dart';

class UserController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firebaseClould = FirebaseFirestore.instance;

  Future<UserModel?> login({required String email, required String pass}) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = userCredential.user;
      if (user != null) {
        var queryBlock = await firebaseClould.collection("user").doc(user.uid.toString()).get();
        if (queryBlock.exists) {
          UserModel userModelNew = UserModel.fromMap(queryBlock.data() ?? {});
          return userModelNew;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }

  Future<UserModel?> register({
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      firebaseClould.collection("user").doc(user!.uid.toString()).set(UserModel(
            id: user.uid.toString(),
            name: name,
            email: email,
            first: 30,
          ).toMap());
      return UserModel(
        id: user.uid.toString(),
        name: name,
        email: email,
        first: 30,
      );
    } catch (e) {
      print("Erorr: $e");
      return null;
    }
  }

  Future<UserModel?> getCurrentUser() async {
    try {
      User? user = auth.currentUser;
      if (user != null) {
        var queryBlock = await firebaseClould.collection("user").doc(user.uid.toString()).get();
        if (queryBlock.exists) {
          UserModel userModelNew = UserModel.fromMap(queryBlock.data() ?? {});
          return userModelNew;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }

  Future<UserModel?> getUser(String id) async {
    try {
      var queryBlock = await firebaseClould.collection("user").doc(id).get();
      if (queryBlock.exists) {
        UserModel userModelNew = UserModel.fromMap(queryBlock.data() ?? {});
        return userModelNew;
      } else {
        return null;
      }
    } catch (e) {
      print("Loi: $e");
      return null;
    }
  }

  deleteAccount() async {
    try {
      var userNow = await getCurrentUser();
      if (userNow != null) {
        await firebaseClould.collection("user").doc(userNow.id.toString()).set(userNow.copyWith(name: "Deteted").toMap());
      }
      await auth.currentUser?.delete();
    } catch (e) {}
  }
}

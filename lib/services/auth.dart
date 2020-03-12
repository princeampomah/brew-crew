import 'package:brew_crew_coffee/models/user_model.dart';
import 'package:brew_crew_coffee/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance; //use Firebase Auth instance

  //Create User object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }


//Stream to check if the the user is logged in or not(Listen for AuthChange)
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  //Anonymous Sign In
  Future signInAnon() async {
    /*wait for the sign in to complete and put the result(feedback) in the instance 
   of AuthResult*/
    try {
      AuthResult result = await _auth
          .signInAnonymously(); //put the feedback in the result instance
      FirebaseUser user = result.user; //get the user's result
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }


//Sign In with Email and Password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }

  }


//Register with Email and Password
  Future signUpWithEmailAndPassword(String email, String password) async{
   try{
     AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
     FirebaseUser user = result.user;
     //Create user document in database when the user signs up
     await DatabaseService(uid: user.uid).updateUserData('New Member', '0', 100);
     return _userFromFirebaseUser(user);
   }catch(e){
     print(e.toString());
     return null;
   }
  }

//Sign Out
  Future signOut() async{
     try{
        return await _auth.signOut();
     }catch(e){
       print(e.toString());
       return null;
   }
}

}

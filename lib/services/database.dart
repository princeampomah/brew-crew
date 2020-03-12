import 'package:brew_crew_coffee/models/brew_model.dart';
import 'package:brew_crew_coffee/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  //Collection Reference
  CollectionReference brewCollection = Firestore.instance.collection('brew');

// Update user's data with this function
  Future updateUserData(String name, String sugars, int strength) async {
    return await brewCollection.document(uid).setData({
        'name' : name,
        'sugars' : sugars,
        'strength' : strength
    });
  }

  //create BrewList object from QuerySnapshot
   List<Brew> _brewListFromQuerySnapshot(QuerySnapshot snapshot){
     return snapshot.documents.map((doc){
       return Brew(
         name: doc.data['name'] ?? '',
         strength: doc.data['strength'] ?? 0,
         sugar: doc.data['sugars'] ?? '0',
       );
     }).toList();
   }


  //Stream to listen for changes in the database and retrieve the data
   Stream<List<Brew>> get brews{
     return brewCollection.snapshots()
     .map(_brewListFromQuerySnapshot);
   }


  //UserData class object from DocumentSnapshot
  UserData _userDataFromDocumentSnapshot(DocumentSnapshot snapshot){
    return UserData(
        uid: uid,
        name: snapshot.data['name'],
        sugars: snapshot.data['sugars'],
        strength: snapshot.data['strength']
    );
  }

   //User Data Stream
  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
        .map(_userDataFromDocumentSnapshot);
  }

}
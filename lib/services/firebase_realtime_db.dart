import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/data/models/user_model.dart';
class FirebaseUserService {
  FirebaseUserService._();

  static final FirebaseUserService instance = FirebaseUserService._();

  final FirebaseDatabase _db = FirebaseDatabase.instance;

  //constants
  static const String collectionPath = 'users';

// insert user data

  Future<bool> addUserData (AppUser user) async{
  try{
    await _db.ref('$collectionPath/${user.uid}').set(user.toJson());
    return true;
  }on FirebaseException catch(e){{
    rethrow;
  }}
}
  Future<AppUser?> loadUserData (String uid) async{
    try{
      DatabaseReference ref = _db.ref('$collectionPath/$uid');
      DatabaseEvent event = await ref.once();
      
      if(event.snapshot.exists){
        print(event.snapshot.value.runtimeType);
        
        Map <String, dynamic> appUserJson =
            Map <String , dynamic>.from(event.snapshot.value as Map);
        return AppUser.fromJson((appUserJson));
      }
    }on FirebaseException catch(e){{
      rethrow;
    }}

  }
  // update user data
  Future<bool> updateUserData(AppUser user) async {
    try {
      await _db.ref('$collectionPath/${user.uid}').update(user.toJson());
      return true;
    } on FirebaseException catch (e) {
      rethrow;
    }
  }
}
import 'dart:core';
import 'package:firebase_auth/firebase_auth.dart';
class PersonalUser{
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String? id;
  String? photoUrl;
  String? name;
  String email;
  String password;


  PersonalUser( this.email,this.password);

 
  String? get getName => name;
  String get getEmail => email;
  get getPassword => password;
  set setName(String name) => this.name = name;
  set setEmail(String email) => this.email = email;
  
  Future<int> registerUser(String name)async {
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: this.email, password: this.password);
      var user = userCredential.user;
      this.id = user!.uid ;
      await user.updateDisplayName(name);
    }
    on FirebaseAuthException catch(e){
      if (e.code =='weak-password'){
        return 1;
        
    } else if(e.code=='email-already-in-use'){
      return 2;
    }
   
    }
    catch(e){
      print(e);
      return 3;
    }
  
  return 0;
  }
  Future<int> signIn() async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: this.email, password: this.password);
      var user = userCredential.user;
      this.id = user!.uid ;
      this.name = user.displayName;
    }
    on FirebaseAuthException catch(e){
      if (e.code =='user-not-found'){
        return 1;
        
    } else if(e.code=='wrong-password'){
      return 2;
    }
   
    }
    catch(e){
      print(e);
      return 3;
    }
    return 0;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oil_bussiness/view/initial_user_view/initial_user_view.dart';

import '../../res/paths/paths.dart';
export 'package:flutter/foundation.dart';
export '../bloc/loading_bloc/loading_bloc_event/loading_bloc_event.dart';



class AuthenticationViewModel {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('users');


  Future addInitialUserData(BuildContext context, String id , email) async {
    try{

      await _firestore.doc(id).set({
        "userId" : id,
        "userEmail" : email,
        "accountRole" : 'initial',
        "createdData" : DateTime.now()
      }).then((value) {
      });
    }catch(error) {
      if(kDebugMode){
        print("Error while adding initial User Data >>>>>>>>> $error");
      }
    }
  }


  /// sign in method
  Future<void> signIn(BuildContext context , String email , password) async {
    context.read<LoadingBloc>().add(SetLoading());
    try{
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        // Utils.toastMessage("User Sign in successfully");

        context.read<LoadingBloc>().add(SetLoading());
        // Navigator.push(context, MaterialPageRoute(builder: (context) => SaleInvoiceView()));
      });
    }on FirebaseAuthException catch(error){
      context.read<LoadingBloc>().add(SetLoading());
      if(kDebugMode){
        print("Error while signing up from AuthViewModel >>>>>>> ${error.message} >>>>");
      }
    }
  }

  // sign Up method
  Future<void> signUp(BuildContext context , email , password) async {
    try{
      context.read<LoadingBloc>().add(SetLoading());

      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        await addInitialUserData(context , value.user!.uid.toString() , email );
        // Utils.toastMessage("User Sign up successfully");
        print("Sign Up");
        context.read<LoadingBloc>().add(SetLoading());

        Navigator.push(context, MaterialPageRoute(builder: (context) => InitialUserView()));
      });
    }on FirebaseAuthException catch(error){
      context.read<LoadingBloc>().add(SetLoading());

      // Utils.toastMessage(error.code);
      if(kDebugMode){
        print("Error while signing up from AuthViewModel >>>>>>> ${error.message} >>>>");
      }
    }
  }


  /// sign out
  void signOut(BuildContext context) async {
    try{
      await _auth.signOut().then((value) {
        // Utils.toastMessage("User Sign out Successfully");
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginView()));
      });
    }on FirebaseAuthException catch(error) {
      // Utils.toastMessage(error.code);
      if(kDebugMode){
        print("error while signing out from AuthVireModel >>>>> ${error.message}");
      }
    }
  }

}
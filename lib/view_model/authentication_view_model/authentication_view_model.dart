import 'package:cloud_firestore/cloud_firestore.dart';
import '../../res/paths/paths.dart';
export 'package:flutter/foundation.dart';



class AuthenticationViewModel {

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('users');
  final GetUserDataViewModel getUserDataViewModel = GetUserDataViewModel();


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
    final loadingBloc = context.read<LoadingBloc>();
    try{
      loadingBloc.add(SetLoading());
      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
        // Utils.toastMessage("User Sign in successfully");
        getUserDataViewModel.getuserData(context);
        loadingBloc.add(SetLoading());
        Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavView()));
      });
    }on FirebaseAuthException catch(error){
      loadingBloc.add(SetLoading());
      if(kDebugMode){
        print("Error while signing up from AuthViewModel >>>>>>> ${error.message} >>>>");
      }
    }
  }

  // sign Up method
  Future<void> signUp(BuildContext context , email , password) async {
      final loadingBloc = context.read<LoadingBloc>();
    try{
      loadingBloc.add(SetLoading());

      await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
        await addInitialUserData(context , value.user!.uid.toString() , email );
        // Utils.toastMessage("User Sign up successfully");
        loadingBloc.add(SetLoading());
        Navigator.push(context, MaterialPageRoute(builder: (context) => InitialUserView()));
      });
    }on FirebaseAuthException catch(error){
      loadingBloc.add(SetLoading());

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
        context.read<UserDataBloc>().add(ClearUserData());
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
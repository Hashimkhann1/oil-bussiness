import '../../res/paths/paths.dart';





class SplashViewModel {

  final _auth = FirebaseAuth.instance;
  final GetUserDataViewModel getUserDataViewModel = GetUserDataViewModel();

  void splashTime(BuildContext context) {

    Future.delayed(Duration(seconds: 1), () {
      if(_auth.currentUser != null){
        getUserDataViewModel.getuserData(context);
      }

      Navigator.push(context, MaterialPageRoute(builder: (context) => _auth.currentUser == null ? LoginView() : BottomNavView()));


    });

  }

}
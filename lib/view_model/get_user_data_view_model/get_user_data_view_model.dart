import 'package:oil_bussiness/view_model/bloc/user_data_bloc/user_data_bloc/user_data_bloc.dart';
import 'package:oil_bussiness/view_model/bloc/user_data_bloc/user_data_bloc_event/user_data_bloc_event.dart';

import '../../res/paths/paths.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class GetUserDataViewModel {

  final _firestore = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future getuserData(BuildContext context) async {
    try{
      DocumentSnapshot<Map<String, dynamic>> userData = await _firestore.doc(_auth.currentUser!.uid.toString()).get();

      if(userData.data() != null){

        dynamic data = await UserModel.fromJson(userData.data()!);
        context.read<UserDataBloc>().add(GetUserData(userModel: data));
      }

    }catch(error){
      if(kDebugMode){
        print("Error while getting user data form >>>>>> GetUserDataViewModel ${error}");
      }
    }
  }

}



import 'package:bloc/bloc.dart';
import 'package:oil_bussiness/model/user_model/user_model.dart';
import 'package:oil_bussiness/view_model/bloc/user_data_bloc/user_data_bloc_event/user_data_bloc_event.dart';
import 'package:oil_bussiness/view_model/bloc/user_data_bloc/user_data_bloc_state/user_data_bloc_state.dart';

class UserDataBloc extends Bloc<UserDataBlocEvent , UserDataBlocState> {

  List<UserModel> userDataList = [];

  UserDataBloc() : super(UserDataBlocState()) {
    on<GetUserData>(_getUserData);
  }


  void _getUserData(GetUserData event , Emitter<UserDataBlocState> emit) {
    print(event.userModel);
    userDataList.add(event.userModel);
    emit(state.copyWith(userDataist: List.from(userDataList)));
  }


}
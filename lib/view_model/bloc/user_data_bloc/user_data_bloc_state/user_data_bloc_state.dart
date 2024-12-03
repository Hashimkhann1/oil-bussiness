


import 'package:equatable/equatable.dart';
import 'package:oil_bussiness/model/user_model/user_model.dart';

class UserDataBlocState extends Equatable {

  final List<UserModel> userDataist;

  UserDataBlocState({this.userDataist = const []});

  UserDataBlocState copyWith({List<UserModel>? userDataist}) {
    return UserDataBlocState(userDataist: userDataist ?? this.userDataist);
  }

  @override
  List<Object?> get props => [userDataist];

}
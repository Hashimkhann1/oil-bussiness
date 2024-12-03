
import '../../../../res/paths/paths.dart';



abstract class UserDataBlocEvent extends Equatable {

  @override
  List<Object?> get props => [];

}


class GetUserData extends UserDataBlocEvent {

  final UserModel userModel;
  GetUserData({required this.userModel});

}
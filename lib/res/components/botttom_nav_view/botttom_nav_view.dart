
import 'package:flutter/cupertino.dart';
import '../../paths/paths.dart';


class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {

  int selectedView = 0;

  List view = [
    AdminHomeView(),
    AdminAllCustomersView(),
    AdminAddRole(),
    AdminProfileView()
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc , UserDataBlocState>(
        builder: (context , state) {
          if(state.userDataist.isEmpty){
            return Scaffold(
              body: Center(
                child: Container(
                  child: CircularProgressIndicator(color: AppColor.primaryColor,),
                ),
              ),
            );
          }else{
            if(state.userDataist[0].accountRole == 'initial'){
              return InitialUserView();
            }else{
              return state.userDataist[0].accountRole == 'admin' ? Scaffold(
                body: view[selectedView],
                bottomNavigationBar: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: selectedView,
                  elevation: 0,
                  selectedItemColor: AppColor.black,
                  onTap: (index) {
                    setState(() {
                      selectedView = index;
                    });
                  },
                  items: [
                    BottomNavigationBarItem(icon: Icon(Icons.home,size: 32,),label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.people,size: 32,),label: ''),
                    BottomNavigationBarItem(icon: Icon(Icons.add,size: 32,),label: ''),
                    BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_alt_circle_fill,size: 32,),label: ''),
                  ],
                  selectedIconTheme: IconThemeData(color: AppColor.primaryColor),
                ),
              ) : Scaffold();
            }
          }
        }
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:oil_bussiness/view/admin_view/all_stock_and_poducts_view/all_stock_and_poducts_view.dart';
import 'package:oil_bussiness/view/markiting_view/all_customer_view/all_customer_view.dart';
import 'package:oil_bussiness/view/markiting_view/setting_view/setting_view.dart';
import '../../paths/paths.dart';

class BottomNavView extends StatefulWidget {
  const BottomNavView({super.key});

  @override
  State<BottomNavView> createState() => _BottomNavViewState();
}

class _BottomNavViewState extends State<BottomNavView> {
  int selectedView = 0;

  final List<Widget> adminView = [
    AdminHomeView(),
    AdminAllCustomersView(),
    AdminAddRole(),
    AdminProfileView(),
  ];

  final List<Widget> marketerView = [
    AllCustomerView(),
    MarketerAddCustomerView(),
    SettingView(),
    MarketerProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserDataBloc, UserDataBlocState>(
      builder: (context, state) {
        if (state.userDataist.isEmpty) {
          return _buildLoadingView();
        }

        if (state.userDataist[0].accountRole == 'initial') {
          return InitialUserView();
        }

        // final isAdmin = state.userDataist[0].accountRole == 'admin';
        return _buildScaffold(
          state.userDataist[0].accountRole == 'admin' ? adminView : marketerView,
          state.userDataist[0].accountRole == 'admin' ? _adminBottomNavItems() : _marketerBottomNavItems(),
        );
      },
    );
  }

  Widget _buildLoadingView() {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(title: "Loadin...",fontWeight: FontWeight.bold,color: AppColor.white,),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Scaffold _buildScaffold(List<Widget> views, List<BottomNavigationBarItem> items) {
    return Scaffold(
      body: views[selectedView],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 4
            )
          ]
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedView,
          elevation: 10,
          selectedItemColor: AppColor.black,
          selectedLabelStyle: TextStyle(color: AppColor.primaryColor,fontWeight: FontWeight.bold,fontSize: 12),
          onTap: (index) => setState(() => selectedView = index),
          items: items,
          selectedIconTheme: const IconThemeData(color: AppColor.primaryColor),
        ),
      ),
    );
  }

  List<BottomNavigationBarItem> _adminBottomNavItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.home, size: 32), label: 'Dashboard'),
      BottomNavigationBarItem(icon: Icon(Icons.people, size: 32), label: 'Customers'),
      BottomNavigationBarItem(icon: Icon(Icons.add, size: 32), label: 'Assign Role'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_alt_circle_fill, size: 32), label: 'Profile'),
    ];
  }

  List<BottomNavigationBarItem> _marketerBottomNavItems() {
    return const [
      BottomNavigationBarItem(icon: Icon(Icons.people, size: 32), label: 'Customers'),
      BottomNavigationBarItem(icon: Icon(Icons.person_add, size: 32), label: 'add Customer'),
      BottomNavigationBarItem(icon: Icon(Icons.settings, size: 32), label: 'Setting'),
      BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_alt_circle_fill, size: 32), label: 'Profile'),
    ];
  }
}

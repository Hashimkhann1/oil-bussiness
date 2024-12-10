import 'package:cloud_firestore/cloud_firestore.dart';

import '../../res/paths/paths.dart';

class InitialUserView extends StatelessWidget {
  InitialUserView({super.key});

  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(
          title: "Pos App",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(_auth.currentUser!.uid.toString())
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: AppColor.primaryColor,
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  CircularProgressIndicator(
                    color: Colors.redAccent,
                  ),
                  MyText(
                    title: "Something went wrogn please Try Again!",
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor,
                  )
                ],
              );
            }
            return Center(
              child: snapshot.data!.data()!['accountRole'] != 'initial'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyText(
                          title:
                              "Congratulations! You have gained ${snapshot.data!.data()!['accountRole']} account Access \n Tap the Next button to continue to the app.",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppTextButton(
                          title: "Next",
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          textColor: AppColor.white,
                          width: 160,
                          height: 46,
                          backgroundColor: AppColor.primaryColor,
                          borderRadius: 22,
                          onTap: () {
                            context.read<UserDataBloc>().add(ClearUserData());
                            GetUserDataViewModel().getuserData(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavView()));
                          },
                        )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        MyText(
                          title: "Contact M Hasim to continue the app",
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: AppColor.primaryColor,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        AppTextButton(
                          title: "Sign Out",
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          textColor: AppColor.white,
                          backgroundColor: AppColor.primaryColor,
                          width: 200,
                          height: 50,
                          borderRadius: 22,
                          onTap: () {
                            AuthenticationViewModel().signOut(context);
                          },
                        )
                      ],
                    ),
            );
          }),
    );
  }
}

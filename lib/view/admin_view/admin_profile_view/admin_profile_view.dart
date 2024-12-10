import '../../../res/paths/paths.dart';

class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userData = context.read<UserDataBloc>().userDataList.isNotEmpty
        ? context.read<UserDataBloc>().userDataList[0]
        : null;

    if (userData == null) {
      return Scaffold(
        body: Center(child: Text("No user data available")),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: MyText(
          title: "Profile",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        iconTheme: const IconThemeData(color: AppColor.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 62,
              backgroundColor: AppColor.primaryColor,
            ),
            SizedBox(height: height * 0.1),
            userDetailTile("Name", userData.userEmail.toString().split('@')[0] , width),
            SizedBox(height: height * 0.02),
            userDetailTile("Email", userData.userEmail.toString(), width),
            SizedBox(height: height * 0.02),
            userDetailTile(
                "Phone",
                userData.phoneNumber ?? "Add Phone Number", width),
            SizedBox(height: height * 0.02),
            userDetailTile("Account Type", userData.accountRole.toString(), width),
            SizedBox(height: height * 0.04),
            AppTextButton(
              title: "Sign Out",
              fontSize: 18,
              fontWeight: FontWeight.w900,
              textColor: AppColor.white,
              width: width * 0.46,
              height: 40,
              backgroundColor: AppColor.primaryColor,
              borderRadius: 20,
              onTap: () => AuthenticationViewModel().signOut(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget userDetailTile(String label, String value , double width) {
    return Container(
      width: width * 0.94,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyText(
            title: label,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
          MyText(
            title: value,
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ],
      ),
    );
  }
}


import '../../../res/paths/paths.dart';



class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: MyText(title: "Profile",fontWeight: FontWeight.bold,color: AppColor.white,),
        iconTheme: IconThemeData(
          color: AppColor.white
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 62,backgroundColor: AppColor.primaryColor,),
            SizedBox(height: height * 0.1,),

            // User name
            Container(
              width: width * 0.94,
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: "Name",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                  MyText(title: "Name of User Here",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                ],
              ),
            ),
            SizedBox(height: height * 0.02,),

            // User Email
            Container(
              width: width * 0.94,
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              decoration: BoxDecoration(
                color: AppColor.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: "Email",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                  MyText(title: "testtest@mail.com",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                ],
              ),
            ),
            SizedBox(height: height * 0.02,),

            // Phone Number
            Container(
              width: width * 0.94,
              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
              decoration: BoxDecoration(
                  color: AppColor.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(6)
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(title: "Phone",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                  MyText(title: "03130000000",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                ],
              ),
            ),
            SizedBox(height: height * 0.04,),

            // sign out button
            AppTextButton(title: "Sign Out",fontSize: 18,fontWeight: FontWeight.w900,textColor: AppColor.white,width: width * 0.46,height: 40,backgroundColor: AppColor.primaryColor,borderRadius: 20,)
          ],
        ),
      ),
    );
  }
}

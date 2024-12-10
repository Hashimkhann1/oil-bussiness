import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oil_bussiness/view/admin_view/all_stock_and_poducts_view/all_stock_and_poducts_view.dart';
import 'package:oil_bussiness/view/markiting_view/setting_view/setting_view.dart';

import '../../../res/paths/paths.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final userData = context.read<UserDataBloc>().userDataList[0];

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: MyText(
          title: "Reports",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(userData.userId)
              .collection('soldOrders')
              .doc(
                  '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')
              .get(),
          builder: (context, data) {
            if (data.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(
                color: AppColor.primaryColor,
              );
            } else if (data.hasError) {
              print(data.error.toString());
              return CircularProgressIndicator(
                color: Colors.red,
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Today Total sale
                        TotalDataComponent(
                          description: "Sale On Cash",
                          data: data.data!['saleOnCash'].toString(),
                        ),

                        // Total Customers
                        TotalDataComponent(
                          description: "Sale on Credit",
                          data: data.data!['saleOnCredit'].toString(),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Today Total sale
                        TotalDataComponent(
                          description: "Total Sale",
                          data: data.data!['totalSale'].toString(),
                        ),

                        // Total Customers
                        TotalDataComponent(
                          description: "Total Customer",
                          data: "100",
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * 0.42,
                          padding: EdgeInsets.symmetric(
                              horizontal: 8, vertical: 10),
                          margin: EdgeInsets.only(left: width * 0.06, top: 6),
                          decoration: BoxDecoration(
                              color: AppColor.white,
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        AppColor.primaryColor.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 10)
                              ]),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              MyText(
                                title: "Total Profit".toString(),
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black.withOpacity(0.5),
                              ),
                              MyText(
                                title: data.data!['totalProfit'].toString(),
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                                color: AppColor.primaryColor,
                              ),
                            ],
                          ),
                        ),

                        // All Stock
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingView()));
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: width * 0.42,
                            height: height * 0.09,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 0),
                            margin: EdgeInsets.only(left: width * 0.05, top: 6),
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.circular(6),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.primaryColor
                                          .withOpacity(0.2),
                                      spreadRadius: 3,
                                      blurRadius: 10)
                                ]),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.settings,
                                  color: AppColor.primaryColor,
                                ),
                                SizedBox(
                                  width: 6,
                                ),
                                MyText(
                                  title: "Setting",
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),

                // Daily Reports
                SizedBox(
                  height: height * 0.3,
                  child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            padding: EdgeInsets.only(top: 8),
                            // margin: EdgeInsets.symmetric(horizontal: 6),
                            height: height * 0.3,
                            width: width * 0.3,
                            decoration: BoxDecoration(
                                color: AppColor.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(10),
                                    topLeft: Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.primaryColor
                                          .withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 1)
                                ]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyText(
                                  title: "500000",
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: AppColor.primaryColor,
                                ),
                                MyText(
                                  title:
                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                  color: AppColor.grey.withOpacity(0.9),
                                ),
                                Container(
                                  height: height * 0.2,
                                  width: 17,
                                  color: AppColor.primaryColor.withOpacity(0.9),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                )
              ],
            );
          }),
    );
  }
}

class TotalDataComponent extends StatelessWidget {
  const TotalDataComponent({
    super.key,
    required this.description,
    required this.data,
  });

  final String? description;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.42,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
                color: AppColor.primaryColor.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 10)
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(
            title: description.toString(),
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: AppColor.black.withOpacity(0.5),
          ),
          MyText(
            title: data.toString(),
            fontSize: 19,
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ],
      ),
    );
  }
}

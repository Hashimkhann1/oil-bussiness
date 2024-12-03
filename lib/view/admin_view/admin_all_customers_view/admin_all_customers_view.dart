import 'package:oil_bussiness/view/admin_view/admin_all_customers_view/admin_customer_detail_view/admin_customer_detail_view.dart';

import '../../../res/paths/paths.dart';

class AdminAllCustomersView extends StatelessWidget {
  const AdminAllCustomersView({super.key});

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: MyText(
          title: "All Customers",
          fontWeight: FontWeight.w900,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10,
                itemBuilder: (context , index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminCustomerDetailView()));
                },
                child: Container(
                  width: width * 0.98,
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: height * 0.02),
                  margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 0)
                        )
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Customer Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.person,color: AppColor.primaryColor,),
                              SizedBox(width: width * 0.06,),
                              MyText(
                                title: "Customer Name",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                          MyText(title: "${index + 1}",fontSize: 21,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Center(child: SizedBox(width: width * 0.7, child: Divider(color: AppColor.grey.withOpacity(0.4),))),
                            
                      // Customer Name
                      Row(
                        children: [
                          Icon(Icons.call,color: AppColor.primaryColor,),
                          SizedBox(width: width * 0.06,),
                          MyText(
                            title: "03130000000",
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: AppColor.black.withOpacity(0.6),
                          ),
                        ],
                      ),
                      Center(child: SizedBox(width: width * 0.7, child: Divider(color: AppColor.grey.withOpacity(0.4),))),
                            
                      // Remaining Amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.card_travel,color: AppColor.primaryColor,),
                              SizedBox(width: width * 0.06,),
                              MyText(
                                title: "Remaining Amount",
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: AppColor.black.withOpacity(0.6),
                              ),
                            ],
                          ),
                          MyText(title: "${50000}",fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

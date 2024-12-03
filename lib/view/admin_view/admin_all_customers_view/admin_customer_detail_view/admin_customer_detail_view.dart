
import '../../../../res/paths/paths.dart';

class AdminCustomerDetailView extends StatelessWidget {
  const AdminCustomerDetailView({super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(title: "Customer Name Details",color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 20,),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        children: [

          // Remaning Balance
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 8),
            margin: EdgeInsets.symmetric(vertical: 8,horizontal: 8),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 10
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                MyText(title: "Remining Amount",fontWeight: FontWeight.bold,fontSize: 20,color: AppColor.black.withOpacity(0.5),),
                MyText(title: "50000",fontWeight: FontWeight.bold,fontSize: 21,color: AppColor.primaryColor,)
              ],
            ),
          ),
          SizedBox(height: height * 0.03,),

          // All History

          Expanded(
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (context , index) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  margin: EdgeInsets.symmetric(vertical: 10,horizontal: 8),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.2),
                            blurRadius: 4,
                            spreadRadius: 5
                        )
                      ]
                  ),
                  child: Column(
                    children: [

                      // Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Date",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Total Liters
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Total Liters",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "1000",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Price per Liter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Price per Liters",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "270",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Total money
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Total Price",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "${270 * 1000}",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Total paid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Total Paid",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "160000",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Remaining amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Remaining amount",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "110000",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),

                    ],
                  ),
                );
              })
          )
        ],
      ),
    );
  }
}

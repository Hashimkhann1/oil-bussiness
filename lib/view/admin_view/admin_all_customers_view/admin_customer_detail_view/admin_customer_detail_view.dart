
import 'package:oil_bussiness/view/markiting_view/add_new_sale_view/select_product_for_sale_view/select_product_for_sale_view.dart';

import '../../../../res/paths/paths.dart';

class AdminCustomerDetailView extends StatefulWidget {

  final String customerName;
  final Map<String , dynamic> selectedCustomerData;

  AdminCustomerDetailView({super.key,required this.customerName,required this.selectedCustomerData});

  @override
  State<AdminCustomerDetailView> createState() => _AdminCustomerDetailViewState();
}

class _AdminCustomerDetailViewState extends State<AdminCustomerDetailView> {

  String selectedFilter = "All";  // Default selected radio button
  final Dummy dummy = Dummy(); // Dummy data for customer order

  @override
  Widget build(BuildContext context) {


    final userData = context.read<UserDataBloc>().userDataList[0];
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(title: "Customer ${widget.customerName}",color: AppColor.white,fontWeight: FontWeight.bold,fontSize: 20,),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        children: [

          // Remaning Balance
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 12),
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
                MyText(title: "Total Remaining Amount",fontWeight: FontWeight.bold,fontSize: 18,color: AppColor.black.withOpacity(0.5),),
                MyText(title: "50000",fontWeight: FontWeight.bold,fontSize: 21,color: AppColor.primaryColor,)
              ],
            ),
          ),

          // Filter Radio Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Radio<String>(
                    value: "All",
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                  ),
                  const Text("All"),
                ],
              ),
              Row(
                children: [
                  Radio<String>(
                    value: "Not Clear",
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                  ),
                  const Text("Not Clear"),
                ],
              ),
            ],
          ),

          // All History
          Expanded(
              child: ListView.builder(
                itemCount: dummy.customerOrderData.length,
                  itemBuilder: (context , index) {

                  final data = dummy.customerOrderData[index];

                  if(selectedFilter == 'Not Clear' && data['status'].toString() == 'clear'){
                    return SizedBox();
                  }

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
                          MyText(title: "Date",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Total Liters
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Total Liters",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: data['totalLiters'].toString(),fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Price per Liter
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Price per Liters",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: data['pricePerLiter'].toString(),fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Total money
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Total Price",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: data['totalPrice'].toString(),fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Total paid
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Total Paid",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: data['totalPaid'].toString(),fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Remaining amount
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Remaining amount",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: data['remainingAmount'].toString(),fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,)
                        ],
                      ),
                      Divider(color: Colors.grey.withOpacity(0.2),),

                      // Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Status",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          MyText(title: data['status'].toString(),fontSize: 18,fontWeight: FontWeight.bold,color: data['status'].toString() == 'clear' ? Colors.green : Colors.red,)
                        ],
                      ),
                      data['status'] == 'Not clear' ? Divider(color: Colors.grey.withOpacity(0.2),) : SizedBox(),

                      // Update credit
                      data['status'] == 'Not clear' ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Clear Remaining Amount ",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.6),),
                          Icon(Icons.edit,color: AppColor.primaryColor,)
                        ],
                      ) : SizedBox(),

                    ],
                  ),
                );
              })
          )
        ],
      ),
      floatingActionButton: userData.accountRole == 'admin' ? null : FloatingActionButton.extended(
        onPressed: () {
          // Navigator
          Navigator.push(context, MaterialPageRoute(builder: (context) => SelectProductForSaleView(customerName: widget.customerName.toString(),selectedCustomerData: widget.selectedCustomerData,)));
        },
        backgroundColor: AppColor.primaryColor,
        icon: Icon(Icons.add,color: AppColor.white,),
        label: MyText(title: "Sale",fontWeight: FontWeight.bold,fontSize: 16,color: AppColor.white,),
        // icon: Icon(Icons.add),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../res/paths/paths.dart';



class StockView extends StatelessWidget {
  StockView({super.key});
  
  final _firestore = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final userData = context.read<UserDataBloc>().userDataList[0];

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(
          title: "Stock",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [

          SizedBox(height: height * 0.03,),

          // Heading
          Center(child: MyText(title: "All Stock" , fontSize: 28,fontWeight: FontWeight.w900,color: AppColor.primaryColor,)),

          FutureBuilder(
              future: _firestore.doc(userData.accountRole == 'admin' ? userData.userId : userData.adminId.toString()).collection('ordersStock').doc('allOrderData').get(),
              builder: (context , data) {
                if(data.connectionState == ConnectionState.waiting){
                  return SizedBox(
                    width: width,
                    height: height * 0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: AppColor.primaryColor,)
                      ],
                    ),
                  );
                }else if(data.hasError) {
                  return SizedBox(
                    height: height * 0.07,
                    child: Column(
                      children: [CircularProgressIndicator(color: Colors.red,)],
                    ),
                  );
                }

                return  Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                            color: AppColor.primaryColor.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 10)
                      ]),
                  child: Column(
                    children: [

                      // // Product
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     MyText(title: "Product",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //     MyText(title: data.data!["product"],fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //   ],
                      // ),
                      //
                      // // Total Liters
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     MyText(title: "Total Liters",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //     MyText(title: data.data!.docs[index]["totalLiters"],fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //   ],
                      // ),
                      //
                      // // Purchase Price
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     MyText(title: "Purchase Price Per Liter",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //     MyText(title: data.data!.docs[index]['purchasePricePerLiter'],fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //   ],
                      // ),
                      //
                      // // Sale Price
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     MyText(title: "Sale Price Per Liter",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //     MyText(title: data.data!.docs[index]['salePricePerLiter'],fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //   ],
                      // ),
                      //
                      // // Total price
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     MyText(title: "Total Price",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //     MyText(title: data.data!.docs[index]['totalPrice'].toString() ,fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                      //   ],
                      // ),

                      // Product Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Product",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                          MyText(title: "Petrol" ,fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Liters",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                          MyText(title: data.data!['petrolStock'].toString() ,fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          MyText(title: "Sale Price",fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                          MyText(title: data.data!['petrolSalePricePerLiter'].toString() ,fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                        ],
                      ),

                    ],
                  ),
                );

                  // return Expanded(
                  //   child: ListView.builder(
                  //     itemCount: data.data!.docs.length,
                  //       itemBuilder: (context , index) {
                  //     return data.data!.docs[index]['orderStatus'] == 'sold' ? SizedBox() :;
                  //   }),
                  // );
              }
          )

        ],
      ),
    );
  }
}

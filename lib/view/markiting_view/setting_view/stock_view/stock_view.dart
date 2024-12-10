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
                }

                if (!data.hasData || !data.data!.exists) {
                  return SizedBox(
                    height: height * 0.7,
                    child: Center(
                      child: MyText(
                        title: "No Stock Data Available",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColor.primaryColor,
                      ),
                    ),
                  );
                }

                if (data.hasError) {
                  return SizedBox(
                    height: height * 0.07,
                    child: Column(
                      children: [
                        CircularProgressIndicator(color: Colors.red),
                      ],
                    ),
                  );
                }


                final stockData = data.data!.data() as Map<String, dynamic>;
                return Column(
                  children: [

                    buildStockCard(
                      title: "Petrol",
                      liters: stockData['petrolStock'] == null ? '0' : stockData['petrolStock'].toString(),
                      salePrice: stockData['petrolSalePricePerLiter'] == null ? '0' : stockData['petrolSalePricePerLiter'].toString(),
                    ),
                    buildStockCard(
                      title: "Diesel",
                      liters: stockData['dieselStock'] == null ? '0' : stockData['dieselStock'].toString(),
                      salePrice: stockData['dieselSalePricePerLiter'] == null ? '0' : stockData['dieselSalePricePerLiter'].toString(),
                    ),

                  ],
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

Widget buildStockCard({required String title, required String liters, required String salePrice}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    decoration: BoxDecoration(
      color: AppColor.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: AppColor.primaryColor.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 10,
        ),
      ],
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: "Product",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
            MyText(
              title: title,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: "Liters",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
            MyText(
              title: liters,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyText(
              title: "Sale Price",
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
            MyText(
              title: salePrice,
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: AppColor.primaryColor,
            ),
          ],
        ),
      ],
    ),
  );
}

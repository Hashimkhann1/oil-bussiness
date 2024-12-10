import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oil_bussiness/view/markiting_view/add_new_sale_view/add_new_sale_view.dart';

import '../../../../res/paths/paths.dart';

class SelectProductForSaleView extends StatelessWidget {
  final String customerName;
  final Map selectedCustomerData;

  SelectProductForSaleView({
    Key? key,
    required this.customerName,
    required this.selectedCustomerData,
  }) : super(key: key);

  final CollectionReference _firestore =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    final userData = context.read<UserDataBloc>().userDataList[0];
    final userId = userData.accountRole == 'admin'
        ? userData.userId
        : userData.adminId.toString();

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
        children: [
          SizedBox(height: height * 0.03),
          Center(
            child: MyText(
              title: "Select Product For Sale",
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: AppColor.primaryColor,
            ),
          ),
          Expanded(
            child: FutureBuilder<DocumentSnapshot>(
              future: _firestore
                  .doc(userId)
                  .collection('ordersStock')
                  .doc('allOrderData')
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child:
                        CircularProgressIndicator(color: AppColor.primaryColor),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "An error occurred. Please try again.",
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return Center(
                    child: Text(
                      "No stock data available.",
                      style:
                          TextStyle(fontSize: 18, color: AppColor.primaryColor),
                    ),
                  );
                }

                final stockData = snapshot.data!.data() as Map<String, dynamic>;
                return ListView(
                  padding: EdgeInsets.all(8.0),
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewSaleView(
                                    customerName: customerName,
                                    selectedOrder: {
                                      'productName': 'Petrol',
                                      "totalLiters": stockData["petrolStock"],
                                      "salePrice" : stockData["petrolSalePricePerLiter"],
                                      'purchasePrice' : stockData["petrolPurchasePricePerLiter"]
                                    },
                                    selectedCustomerData:
                                        selectedCustomerData)));
                      },
                      child: _buildStockCard(
                        context: context,
                        productName: "Petrol",
                        totalLiters:
                            stockData["petrolStock"]?.toString() ?? "0",
                        salePrice:
                            stockData["petrolSalePricePerLiter"]?.toString() ??
                                "0",
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddNewSaleView(
                                    customerName: customerName,
                                    selectedOrder: {
                                      'productName': 'Diesel',
                                      "totalLiters": stockData["dieselStock"],
                                      "salePrice" : stockData["dieselSalePricePerLiter"],
                                      'purchasePrice' : stockData["dieselPurchasePricePerLiter"]
                                    },
                                    selectedCustomerData:
                                    selectedCustomerData)));
                      },
                      child: _buildStockCard(
                        context: context,
                        productName: "Diesel",
                        totalLiters: stockData["dieselStock"]?.toString() ?? "0",
                        salePrice:
                            stockData["dieselSalePricePerLiter"]?.toString() ??
                                "0",
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStockCard({
    required BuildContext context,
    required String productName,
    required String totalLiters,
    required String salePrice,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: EdgeInsets.symmetric(vertical: 8),
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
          _buildRow(title: "Product", value: productName),
          _buildRow(title: "Total Liters", value: totalLiters),
          _buildRow(title: "Sale Price", value: salePrice),
        ],
      ),
    );
  }

  Widget _buildRow({required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title: title,
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
        MyText(
          title: value,
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: AppColor.primaryColor,
        ),
      ],
    );
  }
}

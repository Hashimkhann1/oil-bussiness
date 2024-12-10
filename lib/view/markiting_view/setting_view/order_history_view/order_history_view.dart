import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../res/paths/paths.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final userData = context.read<UserDataBloc>().userDataList[0];

    final orderHistoryPath = FirebaseFirestore.instance
        .collection('users')
        .doc(userData.accountRole == 'admin' ? userData.userId : userData.adminId)
        .collection('ordersStock')
        .doc('allOrderData')
        .collection('allOrderHistory')
        .doc('${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')
        .collection('orderHistory');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(
          title: "Order History",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        children: [
          // Heading
          MyText(
            title: "Order History",
            fontWeight: FontWeight.w900,
            fontSize: 28,
            color: AppColor.primaryColor,
          ),

          // Order history
          FutureBuilder<QuerySnapshot>(
            future: orderHistoryPath.get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: height * 0.7,
                  width: width,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColor.primaryColor,
                    ),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(
                  child: MyText(
                    title: "Something went wrong!",
                    fontSize: 18,
                    color: Colors.red,
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: MyText(
                    title: "No orders found for today.",
                    fontSize: 18,
                    color: AppColor.primaryColor,
                  ),
                );
              }

              final docs = snapshot.data!.docs;

              return Expanded(
                child: ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final order = docs[index];
                    return _OrderCard(order: order);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _OrderCard extends StatelessWidget {
  final QueryDocumentSnapshot order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
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
          _InfoRow(label: "Product", value: order['product']),
          _InfoRow(label: "Liters", value: order['totalLiters']),
          _InfoRow(label: "Purchase Price Per Liter", value: order['purchasePricePerLiter']),
          _InfoRow(label: "Sale Price Per Liter", value: order['salePricePerLiter']),
          _InfoRow(label: "Total Price", value: order['totalPrice'].toString()),
          _InfoRow(label: "Total Profit", value: order['totalProfit'].toString()),
          _InfoRow(label: "Order Id", value: order['orderId'].toString()),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        MyText(
          title: label,
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

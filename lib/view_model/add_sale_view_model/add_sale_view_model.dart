import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oil_bussiness/main.dart';
import 'package:oil_bussiness/res/paths/paths.dart';

class AddSaleViewModel {
  final _firestore = FirebaseFirestore.instance.collection('users');

  // Save sold order to sold order history
  Future saveSoldOrderToOrdersHistory(
      BuildContext context,
      String customerName,
      customerId,
      Map<String, dynamic> saleOrderData,
      int totalReceiveAmount,
      int remainingAMount,
      ) async {
    try {
      final userData = context.read<UserDataBloc>().userDataList[0];

      saleOrderData['orderStatus'] = 'sold';
      saleOrderData['customerId'] = customerId.toString();
      saleOrderData['customerName'] = customerName.toString();
      saleOrderData['receivedAmount'] = totalReceiveAmount;

      print(saleOrderData);

      await _firestore
          .doc(userData.adminId)
          .collection('soldOrders')
          .doc(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')
          .collection("ordersHistory")
          .doc(saleOrderData['orderId'])
          .set(saleOrderData)
          .then((onValue) {
            print("Order is saved >>>>>>>>>> :)");
            saveSaleIntoCustomerHistory(context ,customerId , saleOrderData , remainingAMount);
      });
    } catch (error) {
      print(
          "Error while saving Sold Order to Order History >>>> from AddSaleViewModel >>>>> $error");
    }
  }

  // Save sold order to customer history with custom data
  Future saveSaleIntoCustomerHistory(
      BuildContext context, String customerId, Map<String , dynamic> saleData , int remainingAMount) async {
    final userData = context.read<UserDataBloc>().userDataList[0];

    try {
      print(">>>>>>>>>>>>>>>>>>>>");
      saleData['remainingAmount'] = remainingAMount == 0 ? 0 : remainingAMount;
      saleData['status'] = remainingAMount == 0 ? 'clear' : 'Not clear';
      print(saleData);

      await _firestore
          .doc(userData.adminId)
          .collection('customers')
          .doc(customerId)
          .collection("salesHistory")
          .doc(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')
          .collection('sales').doc(saleData['orderId']).set(saleData).then((onValue) {
        deleteOrderFromStock(context , userData.adminId.toString() , saleData['orderId']);
      }).then((onValue) {
        updateToDaySaleData(context , saleData , userData.adminId.toString());
      });
    } catch (error) {
      print(
          "Error while saveSaleIntoCustomerHistory from AddSaleViewModel >>> $error");
    }
  }


  // Delete sold Order from stock
  Future deleteOrderFromStock(BuildContext context, String adminId , orderId) async {

    try{
      await _firestore.doc(adminId.toString()).collection('ordersStock').doc(orderId).delete();
    }catch(error){
      print("Error while deleting order form stock from AddSaleViewModel >>>>> $error");
    }
  }

  // update today sale data
  Future<void> updateToDaySaleData(
      BuildContext context, Map<String, dynamic> soldOrderData, String adminId) async {
    try {
      // Reference to the specific document for today's sales
      final documentRef = _firestore
          .doc(adminId)
          .collection('soldOrders')
          .doc(
          '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}');

      // Get the current document
      final documentSnapshot = await documentRef.get();

      // Check if the document exists
      if (documentSnapshot.exists) {
        // Retrieve the current saleOnCash value or set it to 0 if it doesn't exist
        final currentTotalSale = documentSnapshot.data()?['totalSale'] ?? 0;
        final currentSaleOnCredit = documentSnapshot.data()?['saleOnCredit'] ?? 0;
        final currentSaleOnCash = documentSnapshot.data()?['saleOnCash'] ?? 0;
        final currentTotalProfit = documentSnapshot.data()?['totalProfit'] ?? 0;

        // Add the new sale price to the current saleOnCash
        final updatedTotalSale = currentTotalSale + soldOrderData['totalPrice'];
        final updatedSaleOnCredit = currentSaleOnCredit + soldOrderData['remainingAmount'];
        final updatedSaleOnCash = currentSaleOnCash + soldOrderData['receivedAmount'];
        final updatedTotalProfit = currentTotalProfit + soldOrderData['totalProfit'];

        // Update the document with the new value
        await documentRef.update({
          "totalSale": updatedTotalSale,
          "saleOnCredit" : updatedSaleOnCredit,
          "saleOnCash" : updatedSaleOnCash,
          "totalProfit" : updatedTotalProfit,
        }).then((onValue) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        });
      } else {
        // If the document does not exist, create it with the current saleOrderData
        await documentRef.set(
            {
              "totalSale": soldOrderData['totalPrice'],
              "saleOnCredit" : soldOrderData['remainingAmount'],
              "saleOnCash" : soldOrderData['receivedAmount'],
              "totalProfit" : soldOrderData['totalProfit'],
            }
        ).then((onValue) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        });
      }
    } catch (error) {
      print(
          "Error while updating today's sale data after order sold from AddSaleViewModel >>>> $error");
    }
  }

}

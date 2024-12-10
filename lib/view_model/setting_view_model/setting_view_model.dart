import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:oil_bussiness/res/paths/paths.dart';

class SettingViewModel {
  final _firestore = FirebaseFirestore.instance.collection('users');

  /// Add products
  Future addProduct(
      BuildContext context, TextEditingController productName) async {
    final userData = context.read<UserDataBloc>();
    context.read<LoadingBloc>().add(SetLoading());

    try {
      await _firestore
          .doc(userData.userDataList[0].adminId.toString())
          .collection('products')
          .add({
        "productName": productName.text.toString(),
        'addedDate': DateTime.now()
      }).then((onValue) {
        context.read<LoadingBloc>().add(SetLoading());
        productName.clear();
        Navigator.pop(context);
      });
    } catch (error) {
      context.read<LoadingBloc>().add(SetLoading());
      print("Error while add product from SettingViewModel >>> $error");
    }
  }

  /// Save Order
  Future saveOrder(
      BuildContext context,
      TextEditingController totalLiters,
      TextEditingController purchasePricePerLiter,
      TextEditingController salePricePerLiter,
      int totalPrice,
      int totalProfit,
      String selectedProductValue) async {
    try {
      final userData = context.read<UserDataBloc>();
      context.read<LoadingBloc>().add(SetLoading());

      var docRef = _firestore
          .doc(userData.userDataList[0].adminId.toString())
          .collection('ordersStock')
          .doc('allOrderData')
          .collection('allOrderHistory')
          .doc(
              '${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}')
          .collection('orderHistory').doc();

      await docRef.set({
        'product': selectedProductValue,
        'orderId':docRef.id,
        "totalLiters": totalLiters.text.toString(),
        "purchasePricePerLiter": purchasePricePerLiter.text.toString(),
        "salePricePerLiter": salePricePerLiter.text.toString(),
        "totalPrice": totalPrice,
        "totalProfit": totalProfit,
        "orderDate": DateTime.now(),
        "formattedDate":
            "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}"
      }).then((onValue) {
        print("Order is saved >>>>>>>>");
        updateOrderStock(
            context,
            userData.userDataList[0].adminId.toString(),
            selectedProductValue,
            totalLiters,
            purchasePricePerLiter,
            salePricePerLiter);
      });
    } catch (error) {
      context.read<LoadingBloc>().add(SetLoading());
      print("Error while saveing Order from SettingViewMoel >>>>> $error");
    }
  }

  Future updateOrderStock(
      BuildContext context,
      String adminId,
      String selectedProduct,
      TextEditingController totalLiters,
      TextEditingController purchasePricePerLiter,
      TextEditingController salePricePerLiter) async {
    try {
      final documentRef =
          _firestore.doc(adminId).collection('ordersStock').doc('allOrderData');

      final documentSnapshot = await documentRef.get();

      if (documentSnapshot.exists) {
        final currentStock = documentSnapshot.data()?[
                selectedProduct == "Petrol" ? 'petrolStock' : 'dieselStock'] ??
            0;
        final updatedStock =
            currentStock + (int.tryParse(totalLiters.text) ?? 0);

        await documentRef.update({
          selectedProduct == "Petrol" ? 'petrolStock' : 'dieselStock':
              updatedStock,
          selectedProduct == "Petrol"
                  ? 'petrolPurchasePricePerLiter'
                  : 'dieselPurchasePricePerLiter':
              int.tryParse(purchasePricePerLiter.text) ?? 0,
          selectedProduct == "Petrol"
                  ? 'petrolSalePricePerLiter'
                  : 'dieselSalePricePerLiter':
              int.tryParse(salePricePerLiter.text) ?? 0,
        });
      } else {
        await documentRef.set({
          selectedProduct == "Petrol" ? 'petrolStock' : 'dieselStock':
              int.tryParse(totalLiters.text) ?? 0,
          selectedProduct == "Petrol"
                  ? 'petrolPurchasePricePerLiter'
                  : 'dieselPurchasePricePerLiter':
              int.tryParse(purchasePricePerLiter.text) ?? 0,
          selectedProduct == "Petrol"
                  ? 'petrolSalePricePerLiter'
                  : 'dieselSalePricePerLiter':
              int.tryParse(salePricePerLiter.text) ?? 0,
        });
      }

      totalLiters.clear();
      purchasePricePerLiter.clear();
      salePricePerLiter.clear();
    } catch (error) {
      print("Error while updating order stock >>>>> $error");
    } finally {
      context.read<LoadingBloc>().add(SetLoading());
    }
  }
}

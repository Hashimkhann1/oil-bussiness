import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../res/paths/paths.dart';

class AddCustomerViewModel {
  final _firestoer = FirebaseFirestore.instance.collection('users');
  final Uuid uuid = Uuid();

  Future addCustomer(BuildContext context, {
    required TextEditingController customerName,
    required TextEditingController customerEmail,
    required TextEditingController customerAddress,
    required TextEditingController customerPhoneNumber,
  }) async {
    try {
      // Show loading indicator
      context.read<LoadingBloc>().add(SetLoading());
      final userData = context.read<UserDataBloc>().userDataList[0];

      // Generate a document reference with a unique ID
      var docRef = _firestoer.doc(userData.adminId).collection('customers').doc(); // Automatically generates a document ID

      // Get the unique ID from the document reference
      String customerId = docRef.id;

      // Add customer data to Firestore
      await docRef.set({
        "customerId": customerId,
        "customerName": customerName.text.trim(),
        "customerEmail": customerEmail.text.trim(),
        "customerAddress": customerAddress.text.trim(),
        "customerPhoneNumber": customerPhoneNumber.text.trim(),
        "remainingAmount": 0,
        "status": "clear",
        "createdDate": DateTime.now(),
      });

      // Stop loading indicator
      context.read<LoadingBloc>().add(SetLoading());

      // Clear textfields
      customerName.clear();
      customerEmail.clear();
      customerAddress.clear();
      customerPhoneNumber.clear();

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: MyText(
            title: 'Customer added successfully',
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: AppColor.white,
          ),
          backgroundColor: AppColor.primaryColor,
        ),
      );
    } catch (error) {
      context.read<LoadingBloc>().add(SetLoading());

      // Log and show error message
      debugPrint('Error while adding customer: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add customer: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

}

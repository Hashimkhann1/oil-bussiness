import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oil_bussiness/res/paths/paths.dart';

class AssignRoleViewModel {
  final _firestore = FirebaseFirestore.instance.collection('users');
  final _auth = FirebaseAuth.instance;

  Future<void> assignRole(BuildContext context, TextEditingController userEmail, String assignRole) async {
    try {

      // Start Loading
      context.read<LoadingBloc>().add(SetLoading());
      print(userEmail.text.toString());

      // Query the 'users' collection to find the document with matching userEmail
      QuerySnapshot querySnapshot = await _firestore
          .where('userEmail', isEqualTo: userEmail.text.toString())
          .get();

      // Check if the document exists
      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          // Cast the document data to a Map
          var data = doc.data() as Map<String, dynamic>;

          // Check if userEmail matches
          if (data['userEmail'] == userEmail.text.toString()) {

            await _firestore.doc(doc.id).update({
              'accountRole': "marketer",
              'adminId' : _auth.currentUser!.uid.toString()
            });
            userEmail.clear();

          }
        }
        context.read<LoadingBloc>().add(SetLoading());
        // Notify the user that the role was assigned successfully
        if (kDebugMode) {
          print('Role assigned successfully.');
        }
      } else {

        context.read<LoadingBloc>().add(SetLoading());

        // Handle the case where no user is found
        if (kDebugMode) {
          print('No user found with the provided email. >>>>>>>');
        }
      }
    } catch (error) {

      context.read<LoadingBloc>().add(SetLoading());

      // Handle errors
      if (kDebugMode) {
        print('Error assigning role: $error');
      }
    }
  }
}

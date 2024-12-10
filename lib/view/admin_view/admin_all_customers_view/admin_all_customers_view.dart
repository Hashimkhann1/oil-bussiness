import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oil_bussiness/view/admin_view/admin_all_customers_view/admin_customer_detail_view/admin_customer_detail_view.dart';

import '../../../res/paths/paths.dart';



class AdminAllCustomersView extends StatefulWidget {
  AdminAllCustomersView({super.key});

  @override
  State<AdminAllCustomersView> createState() => _AdminAllCustomersViewState();
}

class _AdminAllCustomersViewState extends State<AdminAllCustomersView> {

  final Dummy dummy = Dummy();  // dummy data
  String selectedFilter = "All";  // Default selected radio button
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: const MyText(
          title: "All Customers",
          fontWeight: FontWeight.w900,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        children: [

          // Filter Radio Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    value: "Clear",
                    groupValue: selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                  ),
                  const Text("Clear"),
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


          // Search text field
          SizedBox(height: 3,),
          AppTextField(hintText: "Search Customer",fontSize: 16,width: width * 0.95,height: height * 0.08,),
          SizedBox(height: 3,),

          // All Customers
          FutureBuilder(
              future: FirebaseFirestore.instance.collection('users').doc(_auth.currentUser!.uid).collection('customers').get(),
              builder: (context , data) {
                if(data.connectionState == ConnectionState.waiting){
                  return SizedBox(
                      height: height * 0.6,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: AppColor.primaryColor,),
                        ],
                      ));
                }
                else if (data.hasError){
                  return SizedBox(
                    height: height * 0.6,
                    child: Column(
                      children: [
                        CircularProgressIndicator(color: Colors.red,),
                        MyText(title: "Failed to get customer data")
                      ],
                    ),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.data!.docs.length,
                    itemBuilder: (context, index) {
                      final customer = dummy.allCustomerData[index];

                      if (selectedFilter == "Clear" && data.data!.docs[index]['status'] != "clear") {
                        return SizedBox(); // Skip customers not matching 'Clear'
                      }
                      if (selectedFilter == "Not Clear" && data.data!.docs[index]['status'] != "Not clear") {
                        return SizedBox(); // Skip customers not matching 'Not Clear'
                      }

                      return CustomerCard(
                        width: width,
                        customerName: data.data!.docs[index]['customerName'],
                        phoneNumber: data.data!.docs[index]['customerPhoneNumber'],
                        remainingAmount: data.data!.docs[index]['remainingAmount'],
                        status: data.data!.docs[index]['status'],
                        index: index,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminCustomerDetailView(customerName: data.data!.docs[index]['customerName'],selectedCustomerData: data.data!.docs[index].data(),)));
                        },
                      );
                    },
                  ),
                );
              })
        ],
      ),
    );
  }
}

class CustomerCard extends StatelessWidget {
  final double width;
  final String customerName;
  final String phoneNumber;
  final int remainingAmount;
  final String status;
  final int index;
  final VoidCallback onTap;

  const CustomerCard({
    super.key,
    required this.width,
    required this.customerName,
    required this.phoneNumber,
    required this.remainingAmount,
    required this.status,
    required this.index,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width * 0.98,
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 16),
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        decoration: BoxDecoration(
          color: AppColor.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColor.primaryColor.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Name
            _buildRow(
              context,
              icon: Icons.person,
              title: customerName,
              trailing: index + 1,
            ),
            // const Divider(),

            // Phone Number
            // _buildRow(
            //   context,
            //   icon: Icons.call,
            //   title: phoneNumber,
            // ),
            // const Divider(),
            //
            // _buildRow(
            //   context,
            //   icon: Icons.money,
            //   title: "Remaining Amount",
            //   trailing: remainingAmount,
            // ),
            const Divider(),

            // Remaining Amount
            _buildRow(
              context,
              icon: Icons.card_travel,
              title: "Status",
              trailing: status,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(BuildContext context,
      {required IconData icon, required String title, dynamic trailing}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Icon
            Icon(icon, color: AppColor.primaryColor),
            SizedBox(width: width * 0.06),

            // // Title
            MyText(
              title: title,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: AppColor.black.withOpacity(0.6),
            ),
          ],
        ),
        if (trailing != null)
          MyText(
            title: trailing.toString(),
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: trailing.runtimeType == int
                ? AppColor.primaryColor
                : trailing == 'clear'
                ? Colors.green
                : Colors.red,
          ),
      ],
    );
  }
}


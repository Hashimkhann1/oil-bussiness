import 'package:oil_bussiness/view_model/add_customer_view_model/add_customer_view_model.dart';

import '../../../res/paths/paths.dart';

class MarketerAddCustomerView extends StatelessWidget {
  MarketerAddCustomerView({super.key});

  final cutomerName = TextEditingController();
  final cutomerEmail = TextEditingController();
  final cutomerPhoneNum = TextEditingController();
  final cutomerAddress = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(
          title: "Add New Customer",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // add Customer Title
                MyText(
                  title: "Add Customer",
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: AppColor.primaryColor,
                ),
                SizedBox(
                  height: height * 0.08,
                ),

                Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Customer Name
                        AppTextField(
                          controller: cutomerName,
                          hintText: "Customer Name",
                          fontSize: 15,
                          height: height * 0.06,
                          width: width * 0.87,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Name";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // Customer phone number
                        AppTextField(
                          controller: cutomerEmail,
                          hintText: "Customer Email",
                          fontSize: 15,
                          height: height * 0.06,
                          width: width * 0.87,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Email";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // Customer Eamil
                        AppTextField(
                          controller: cutomerPhoneNum,
                          hintText: "Customer Phone Number",
                          fontSize: 15,
                          height: height * 0.06,
                          width: width * 0.87,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Phone Number";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        // Customer Address
                        AppTextField(
                          controller: cutomerAddress,
                          hintText: "Customer Address",
                          fontSize: 15,
                          height: height * 0.06,
                          width: width * 0.87,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Enter Address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),

                // Add Customer Button
                BlocBuilder<LoadingBloc, LoadingBlocState>(
                  builder: (context, state) {
                    return AppTextButton(
                      title: "Add Customer",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textColor: AppColor.white,
                      backgroundColor: AppColor.primaryColor,
                      width: width * 0.55,
                      height: 50,
                      borderRadius: 22,
                      isLoading: state.isLoading,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          AddCustomerViewModel().addCustomer(context,
                              customerName: cutomerName,
                              customerEmail: cutomerEmail,
                              customerAddress: cutomerAddress,
                              customerPhoneNumber: cutomerPhoneNum);
                        }
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

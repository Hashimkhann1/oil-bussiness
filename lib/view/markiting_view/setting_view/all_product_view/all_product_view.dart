import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:oil_bussiness/view_model/setting_view_model/setting_view_model.dart';

import '../../../../res/paths/paths.dart';

class AllProductView extends StatelessWidget {
  AllProductView({super.key});

  final productNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    final userData = context.read<UserDataBloc>().userDataList[0];
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(
          title: "All Products",
          color: AppColor.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Heading
            MyText(
              title: "All Products",
              fontSize: 28,
              fontWeight: FontWeight.w900,
              color: AppColor.primaryColor,
            ),

           FutureBuilder(
               future: FirebaseFirestore.instance.collection('users').doc(userData.accountRole == 'admin' ? userData.userId.toString() : userData.adminId.toString()).collection('products').get(),
               builder: (context , data) {
                 if(data.connectionState == ConnectionState.waiting){
                   return SizedBox(height: height * 0.7, child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(color: AppColor.primaryColor,),
                     ],
                   ));
                 }
                 else if(data.hasError){
                   return SizedBox(height: height * 0.7, child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       CircularProgressIndicator(color: Colors.red,),
                     ],
                   ));
                 }
                 return data.data!.docs.length == 0 ? MyText(title: "Product is not added") : Expanded(
                   child: ListView.builder(
                       itemCount: data.data!.docs.length,
                       itemBuilder: (context , index) {
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
                                     blurRadius: 10)
                               ]),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               MyText(
                                 title: "Product Name",
                                 fontSize: 18,
                                 color: AppColor.primaryColor,
                               ),
                               MyText(
                                 title: data.data!.docs[index]['productName'],
                                 fontSize: 18,
                                 color: AppColor.primaryColor,
                               ),
                             ],
                           ),
                         );
                       }),
                 );
               })

          ],
        ),
      ),
      
      
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColor.primaryColor,
        icon: Icon(Icons.add, color: AppColor.white),
        label: MyText(
          title: "Add Product",
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColor.white,
        ),
        onPressed: () {
          // Directly show the dialog instead of defining a function
          showDialog(
            context: context, // Use the context from the onPressed callback
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("My title"),
                content: Form(
                    key: _formKey,
                    child: AppTextField(
                      hintText: "Product Name",
                      controller: productNameController,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Product Name";
                        }
                        return null;
                      },
                    )),
                actions: [
                  AppTextButton(
                    title: "Cancel",
                    backgroundColor: AppColor.primaryColor,
                    width: width * 0.26,
                    height: height * 0.05,
                    fontSize: 16,
                    textColor: AppColor.white,
                    fontWeight: FontWeight.bold,
                    borderRadius: 22,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  BlocBuilder<LoadingBloc, LoadingBlocState>(
                    builder: (context, state) {
                      return AppTextButton(
                        title: "Add",
                        backgroundColor: AppColor.primaryColor,
                        width: width * 0.26,
                        height: height * 0.05,
                        fontSize: 16,
                        textColor: AppColor.white,
                        fontWeight: FontWeight.bold,
                        borderRadius: 22,
                        isLoading: state.isLoading,
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            SettingViewModel()
                                .addProduct(context, productNameController);
                          }
                        },
                      );
                    },
                  )
                ],
              );
            },
          );
        },
      ),
    );
  }
}

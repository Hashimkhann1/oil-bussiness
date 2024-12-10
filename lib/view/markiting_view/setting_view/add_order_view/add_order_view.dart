import 'package:oil_bussiness/view_model/setting_view_model/setting_view_model.dart';

import '../../../../res/paths/paths.dart';

class AddOrderView extends StatefulWidget {
  const AddOrderView({super.key});

  @override
  State<AddOrderView> createState() => _AddOrderViewState();
}

class _AddOrderViewState extends State<AddOrderView> {

  final totalLiterController = TextEditingController();
  final purchasePricePerLiterController = TextEditingController();
  final salepricePerLiterController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String selectedProductValue = "Petrol";

  @override
  void initState() {
    super.initState();

    totalLiterController.addListener(_updateUI);
    purchasePricePerLiterController.addListener(_updateUI);
    salepricePerLiterController.addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    totalLiterController.dispose();
    purchasePricePerLiterController.dispose();
    salepricePerLiterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(
          title: "Add Order",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  title: "Add New Order",
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: AppColor.primaryColor,
                ),
                SizedBox(height: height * 0.08),

                SizedBox(
                  width: width * 0.9,
                  child: DropdownButton(
                      items: const [
                        DropdownMenuItem(
                          value: "Petrol",
                          child: MyText(title: "Petrol"),
                        ),
                        DropdownMenuItem(
                          value: "Diesel",
                          child: MyText(
                            title: "Diesel",
                          ),
                        )
                      ],
                      value: selectedProductValue,
                      onChanged: (newVaue) {
                        setState(() {
                          selectedProductValue = newVaue.toString();
                        });
                      }),
                ),

                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      AppTextField(
                        hintText: " ",
                        labelText: "Total Liters",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        fontSize: 15,
                        height: height * 0.06,
                        width: width * 0.87,
                        controller: totalLiterController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter Total Liters";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        hintText: " ",
                        labelText: "Purchase Price per Liter",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        fontSize: 15,
                        height: height * 0.06,
                        width: width * 0.87,
                        controller: purchasePricePerLiterController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter Purchase Price per Liter";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      AppTextField(
                        hintText: " ",
                        labelText: "Sale Price Per Price",
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        fontSize: 15,
                        height: height * 0.06,
                        width: width * 0.87,
                        controller: salepricePerLiterController,
                        validator: (value) {
                          if(value!.isEmpty){
                            return "Enter Sale Price Per Liter";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: width * 0.86,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Total Price",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.6),
                            ),
                            MyText(
                              title: totalLiterController.text.isEmpty ||
                                      purchasePricePerLiterController
                                          .text.isEmpty
                                  ? "0"
                                  : (int.tryParse(purchasePricePerLiterController.text)! * int.tryParse(totalLiterController.text)!)
                                      .toString(),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.6),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: width * 0.86,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom:
                                BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Total Profit",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.6),
                            ),
                            MyText(
                              title: totalLiterController.text.isEmpty ||
                                      purchasePricePerLiterController
                                          .text.isEmpty ||
                                      salepricePerLiterController.text.isEmpty
                                  ? "0"
                                  : (int.tryParse(salepricePerLiterController.text)! * int.tryParse(totalLiterController.text)! - (int.tryParse(purchasePricePerLiterController.text)! * int.tryParse(totalLiterController.text)!))
                                      .toString(),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.6),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                BlocBuilder<LoadingBloc, LoadingBlocState>(
                  builder: (context, state) {
                    return AppTextButton(
                      title: "Save order",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      textColor: AppColor.white,
                      backgroundColor: AppColor.primaryColor,
                      width: width * 0.55,
                      height: 50,
                      borderRadius: 22,
                      isLoading: state.isLoading,
                      onTap: () {
                        if(_formKey.currentState!.validate()) {
                          SettingViewModel().saveOrder(context, totalLiterController, purchasePricePerLiterController, salepricePerLiterController, (int.tryParse(purchasePricePerLiterController.text)! * int.tryParse(totalLiterController.text)!), (int.tryParse(salepricePerLiterController.text)! * int.tryParse(totalLiterController.text)! - (int.tryParse(purchasePricePerLiterController.text)! * int.tryParse(totalLiterController.text)!)),selectedProductValue);
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

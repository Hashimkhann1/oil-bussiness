
import 'package:oil_bussiness/view_model/add_sale_view_model/add_sale_view_model.dart';

import '../../../res/paths/paths.dart';



class AddNewSaleView extends StatefulWidget {
  final String customerName;
  final Map<String , dynamic> selectedOrder;
  final Map selectedCustomerData;

  const AddNewSaleView({super.key, required this.customerName, required this.selectedOrder,required this.selectedCustomerData});

  @override
  State<AddNewSaleView> createState() => _AddNewSaleViewState();
}

class _AddNewSaleViewState extends State<AddNewSaleView> {
  final totalLiterController = TextEditingController();
  final pricePerLiterController = TextEditingController();
  final receivePriceController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    totalLiterController.addListener(_updateUI);
    pricePerLiterController.addListener(_updateUI);
    receivePriceController.addListener(_updateUI);
  }

  void _updateUI() {
    setState(() {});
  }

  @override
  void dispose() {
    totalLiterController.dispose();
    pricePerLiterController.dispose();
    receivePriceController.dispose();
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
          title: "Sale to ${widget.customerName}",
          fontWeight: FontWeight.bold,
          color: AppColor.white,
          fontSize: 18,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MyText(
                  title: "Sale to ${widget.customerName}",
                  fontWeight: FontWeight.w800,
                  fontSize: 28,
                  color: AppColor.primaryColor,
                ),
                SizedBox(height: height * 0.08),
                Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: width * 0.86,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Product",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                            MyText(
                              title: widget.selectedOrder['productName'],
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Total Liters
                      Container(
                        width: width * 0.86,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Total Liters",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                            MyText(
                              title: widget.selectedOrder['totalLiters'].toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      SizedBox(height: 10),

                      // Sale Price
                      Container(
                        width: width * 0.86,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Sale Price",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                            MyText(
                              title: widget.selectedOrder['salePrice'].toString(),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Total Price
                      Container(
                        width: width * 0.86,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Total Price",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                            MyText(
                              title: "Total Price",
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.7),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 10),

                      // Receive Price Text field
                      Form(
                        key: _formKey,
                        child: AppTextField(
                          hintText: " ",
                          labelText: "Receive Price",
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                          fontSize: 15,
                          height: height * 0.06,
                          width: width * 0.87,
                          controller: receivePriceController,
                          validator: (value) {
                            if(value!.isEmpty){
                              return "Enter Receive Price";
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),

                      // Remaining Amount
                      Container(
                        width: width * 0.86,
                        height: height * 0.06,
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: AppColor.grey, width: 1.7),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            MyText(
                              title: "Remaining amount",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.6),
                            ),
                            MyText(
                              title: receivePriceController.text.isEmpty
                                  ? "0"
                                  : (() {
                                // Parse the values with null safety
                                final receivedPrice = int.tryParse(receivePriceController.text) ?? 0;
                                final totalPrice = widget.selectedOrder['totalPrice'];


                                // Calculate remaining amount
                                return (totalPrice - receivedPrice).toString();
                              })(),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColor.black.withOpacity(0.6),
                            ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),

                // Sale Button
                AppTextButton(
                  title: "Sale",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  textColor: AppColor.white,
                  backgroundColor: AppColor.primaryColor,
                  width: width * 0.55,
                  height: 50,
                  borderRadius: 22,
                  onTap: () {
                    if(_formKey.currentState!.validate()){

                      final receivedPrice = int.tryParse(receivePriceController.text) ?? 0;
                      AddSaleViewModel().saveSoldOrderToOrdersHistory(context, widget.customerName, widget.selectedCustomerData['customerId'], widget.selectedOrder,int.tryParse(receivePriceController.text)!, (widget.selectedOrder['totalPrice'] - receivedPrice));

                    }
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


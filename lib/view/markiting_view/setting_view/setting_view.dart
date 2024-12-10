import 'package:oil_bussiness/view/markiting_view/setting_view/add_order_view/add_order_view.dart';
import 'package:oil_bussiness/view/markiting_view/setting_view/all_product_view/all_product_view.dart';
import 'package:oil_bussiness/view/markiting_view/setting_view/order_history_view/order_history_view.dart';
import 'package:oil_bussiness/view/markiting_view/setting_view/stock_view/stock_view.dart';

import '../../../res/paths/paths.dart';

class SettingView extends StatelessWidget {
  const SettingView({super.key});

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
          title: "Setting",
          color: AppColor.white,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: AppColor.white),
        automaticallyImplyLeading: userData.accountRole == 'admin' ? true : false,
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.04,
            ),
            AppTextButton(
              title: "All Products",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              width: width * 0.94,
              height: height * 0.06,
              borderRadius: 8,
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllProductView()));
              },
            ),
            SizedBox(
              height: userData.accountRole == 'admin' ? 0 : height * 0.02,
            ),
            userData.accountRole == 'admin' ? SizedBox() : AppTextButton(
              title: "Add Order",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              width: width * 0.94,
              height: height * 0.06,
              borderRadius: 8,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddOrderView()));
              },
            ),
            SizedBox(
              height: height * 0.02,
            ),
            AppTextButton(
              title: "Order History",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              width: width * 0.94,
              height: height * 0.06,
              borderRadius: 8,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => OrderHistoryView()));
              },
            ),

            SizedBox(
              height: height * 0.02,
            ),

            AppTextButton(
              title: "Stock",
              fontSize: 20,
              fontWeight: FontWeight.bold,
              textColor: AppColor.white,
              backgroundColor: AppColor.primaryColor,
              width: width * 0.94,
              height: height * 0.06,
              borderRadius: 8,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => StockView()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

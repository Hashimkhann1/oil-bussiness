import '../../../res/paths/paths.dart';


class AllStockAndPoductsView extends StatelessWidget {
  const AllStockAndPoductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        title: MyText(title: "All products and stock",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.white,),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        children: [

          // ///////// Below code is hard coded for two time /////////

          // For Petrole
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(.3),
                  blurRadius: 12,
                  spreadRadius: 3
                )
              ]
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: "Product Name",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                    MyText(title: "Petrol",fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                  ],
                ),
                Divider(color: AppColor.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: "In Stock",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                    MyText(title: "20000 L",fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                  ],
                ),

              ],
            ),
          ),

          // For Desial
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: AppColor.primaryColor.withOpacity(.3),
                  blurRadius: 12,
                  spreadRadius: 3
                )
              ]
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: "Product Name",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                    MyText(title: "Diesel",fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                  ],
                ),
                Divider(color: AppColor.grey,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(title: "In Stock",fontSize: 18,fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                    MyText(title: "20000 L",fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primaryColor),
                  ],
                ),

              ],
            ),
          )
        ],
      ),
    );
  }
}

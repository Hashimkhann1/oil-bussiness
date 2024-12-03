import '../../../res/paths/paths.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: MyText(title: "Reports",fontWeight: FontWeight.bold,color: AppColor.white,),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              // Today Total sale
              TotalDataComponent(description: "Today Total Sale",data: "50000",),

              // Total Customers
              TotalDataComponent(description: "Total Customer",data: "100",)

            ],
          ),


          // Daily Reports
         SizedBox(
           height: height * 0.3,
           child: ListView.builder(
             itemCount: 10,
               scrollDirection: Axis.horizontal,
               itemBuilder: (context , index) {
             return  Padding(
               padding: const EdgeInsets.symmetric(horizontal: 8.0),
               child: Container(
                 padding: EdgeInsets.only(top: 8),
                 // margin: EdgeInsets.symmetric(horizontal: 6),
                 height: height * 0.3,
                 width: width * 0.3,
                 decoration: BoxDecoration(
                     color: AppColor.white,
                     borderRadius: BorderRadius.only(topRight: Radius.circular(10),topLeft: Radius.circular(10)),
                     boxShadow: [
                       BoxShadow(
                           color: AppColor.primaryColor.withOpacity(0.1),
                           blurRadius: 10,
                           spreadRadius: 1
                       )
                     ]
                 ),
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     MyText(title: "500000",fontSize: 20,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
                     Container(height: height * 0.24, width: 17, color: AppColor.primaryColor.withOpacity(0.9),)
                   ],
                 ),
               ),
             );
           }),
         )
        ],
      ),
    );
  }
}




class TotalDataComponent extends StatelessWidget {
  const TotalDataComponent({
    super.key,
    required this.description,
    required this.data,
  });

  final String? description;
  final String? data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: AppColor.primaryColor.withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 10
          )
        ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MyText(title: description.toString(),fontSize: 17,fontWeight: FontWeight.bold,color: AppColor.black.withOpacity(0.5),),
          MyText(title: data.toString(),fontSize: 19,fontWeight: FontWeight.bold,color: AppColor.primaryColor,),
        ],
      ),
    );
  }
}

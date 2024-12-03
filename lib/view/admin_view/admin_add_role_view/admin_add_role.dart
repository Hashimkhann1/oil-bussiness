

import 'package:flutter/material.dart';
import 'package:oil_bussiness/res/color/app_color.dart';
import 'package:oil_bussiness/res/components/app_text_button.dart';
import 'package:oil_bussiness/res/components/app_text_field.dart';
import 'package:oil_bussiness/res/components/my_text.dart';

class AdminAddRole extends StatefulWidget {
  const AdminAddRole({super.key});

  @override
  State<AdminAddRole> createState() => _AdminAddRoleState();
}

class _AdminAddRoleState extends State<AdminAddRole> {

  String selectedValue = "Marketing";

  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primaryColor,
        automaticallyImplyLeading: false,
        title: MyText(title: "Assign Role",fontWeight: FontWeight.w900,color: AppColor.white,),
        iconTheme: IconThemeData(color: AppColor.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyText(title: "Assign Role",fontSize: 24,fontWeight: FontWeight.w900,color: AppColor.primaryColor,),
            SizedBox(height: height * 0.06,),

            AppTextField(hintText: "Employ Email",fontSize: 17,),

            SizedBox(height: height * 0.03,),

            DropdownButton(
                items: const [
                  DropdownMenuItem(value: "Marketing",child: MyText(title:"Marketing"),),
                  DropdownMenuItem(value: "Purchasing or Recovery",child: MyText(title:"Purchasing or Recovery",),)
                ],
                value: selectedValue,
                onChanged: (newVaue) {
                  setState(() {
                    selectedValue = newVaue.toString();
                  });
                }),

            SizedBox(height: 20,),
            
            AppTextButton(title: "Add",fontSize: 20,fontWeight: FontWeight.bold,width: width * 0.4,height: 44,backgroundColor: AppColor.primaryColor,textColor: AppColor.white,borderRadius: 22,)
          ],
        ),
      )
    );
  }
}

import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '/src/core/utils/extensions.dart';


class AppBars {
 static AppBar appBarDefault({String title='',String secondIconImage ='',VoidCallback? onSecondIconTap, VoidCallback? onTap}){
   return AppBar(
     title: CustomText(
       text: title,
       fontW: FW.semibold,
       fontSize: 16,
       color: KCTitle,
     ),
     backgroundColor: Colors.white,
     centerTitle: true,
     elevation: 0.0,
     leading: IconButton(
       onPressed: onTap??(){
        Get.back();
       },
       icon: Icon(
         Icons.arrow_back_ios_outlined,
         color: KCMainBlack,
         size: 20.h,
       ),
     ),
     actions: [
       secondIconImage.isNotEmpty?
       IconButton(
         onPressed: onSecondIconTap??(){

         },
         icon: ImageIcon(
           AssetImage('assets/icons/${secondIconImage}'),
           color: KCMainBlack,
           size: 20.h,
         ),
       ):
       0.0.ESH()
     ],
   );
 }





 static AppBar appBarLogo({String logo='assets/icons/logo.png'}){
   return AppBar(
     title: Image.asset(
       'assets/icons/$logo',
       height: 33.h,
     ),
     leading: IconButton(
       onPressed:(){
         Get.back();
       },
       icon: Icon(
         Icons.menu,
         color: KCIconWhite,
         size: 20.h,
       ),
     ),
     backgroundColor: Colors.blue,
     centerTitle: true,
     elevation: 0.0,
   );
 }

 static AppBar appBarHome({String logo='assets/icons/logo.png'}){
   return AppBar(
     title: Image.asset(
       'assets/icons/$logo',
       height: 34.h,
       width: 57.w,
     ),
     leading: IconButton(
       onPressed:(){
         Get.to(()=> Drawer(
           elevation: 0.0,
             child:Center(
               child: Container(
                 height: double.infinity,
                 width: 200,
                 color: Colors.amber,
               ),
             )
         ));
       },
       icon: Icon(
         Icons.menu,
         color: KCIconWhite,
         size: 24.h,
       ),
     ),

     backgroundColor: Colors.transparent,
     centerTitle: true,
     elevation: 0.0,
   );
 }



}

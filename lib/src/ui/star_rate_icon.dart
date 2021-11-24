import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class StarRateIcons extends StatelessWidget {
  final int rate;
  final Function(int)? onTap;


  StarRateIcons({this.rate=0,this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 5; i++)
              GestureDetector(
                onTap: (){
                  onTap!(i+1);
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.w),
                  child: Icon(
                    Icons.star,
                    color: i>=rate ? Color(0xffBBBDC1):Color(0xffFFA133),
                    size: 28.h,
                  ),
                ),
              )
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     for (int i = 0; i < rate; i++)
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 1.w),
        //         child: Icon(
        //           Icons.star,
        //           color: Color(0xffFFA133),
        //           size: 28.h,
        //         ),
        //       ),
        //     for (int i = 0; i < 5-rate; i++)
        //       Padding(
        //         padding: EdgeInsets.symmetric(horizontal: 1.w),
        //         child: Icon(
        //           Icons.star,
        //           color: Colors.transparent,
        //           size: 28.h,
        //         ),
        //       )
        //   ],
        // ),
      ],
    );
  }
}

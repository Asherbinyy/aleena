
import 'package:aleena/src/core/constants/color_constants.dart';
import 'package:aleena/src/core/utils/extensions.dart';
import 'package:aleena/src/ui/widgets/GeneralWidgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class QuestionsForm extends StatefulWidget {
  final String questions;
  final String answer;

  QuestionsForm({required this.questions, required this.answer});

  @override
  State<QuestionsForm> createState() => _QuestionsFormState();
}

class _QuestionsFormState extends State<QuestionsForm> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(width: 1.w, color: Color(0xFFDBDBDE))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(maxWidth: 300),
                    child: CustomText(
                      text: widget.questions,
                      fontW: FW.semibold,
                      fontSize: 16,
                      color: KCBlueMenu,
                    ),
                  ),
                  Icon(
                    !isOpen
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_up,
                    color: Colors.black,
                    size: 20.w,
                  ),
                ],
              ),
              16.0.ESH(),
              !isOpen
                  ? 0.0.ESH()
                  : Container(
                padding: EdgeInsets.only(left: 32.w),
                width: double.infinity,
                child: CustomText(
                  text: widget.answer,
                  fontW: FW.semibold,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';

class ListBuilderCustomWidget extends StatelessWidget {


  const ListBuilderCustomWidget({
    Key? key,required this.title,required this.documentNumber,this.expiry,required this.onTap,required this.onEditTap
  }) : super(key: key);
final String title;
final String documentNumber;
final String? expiry;
final Function()? onTap;
final Function()? onEditTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),

                    image: DecorationImage(
                        image: NetworkImage("https://www.fjsolicitors.co.uk/wp-content/uploads/2022/12/drafting-legal-documents-scaled.jpg"),
                        fit: BoxFit.fill
                    )
                ),
                height: 80.h,
                width: 80.h,
              ),
              kSizedW10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s16) ,),
                  Text(documentNumber,style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14) ,),
                 expiry != null ? Text("Expiry $expiry",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14) ,):kSizedBox,
                ],
              ),

            ],
          ),

          IconButton(onPressed: onEditTap, icon: Icon(Icons.edit,color: ColorManager.grey3,))

        ],
      ),
    );
  }
}

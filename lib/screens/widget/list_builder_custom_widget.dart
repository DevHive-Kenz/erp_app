import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/color_manger.dart';
import '../../constants/constants.dart';
import '../../constants/font_manager.dart';
import '../../constants/style_manager.dart';
import '../../constants/values_manger.dart';

class ListBuilderCustomWidget extends StatelessWidget {


  const ListBuilderCustomWidget({
    Key? key,
  }) : super(key: key);

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
                  Text("Licence",style: getSemiBoldStyle(color: ColorManager.black,fontSize: FontSize.s16) ,),
                  Text("7896 5413 5651 5356 2",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14) ,),
                  Text("Expiry 10-02-2025",style: getRegularStyle(color: ColorManager.black,fontSize: FontSize.s14) ,),
                ],
              ),

            ],
          ),

          IconButton(onPressed: (){}, icon: Icon(Icons.edit,color: ColorManager.grey3,))

        ],
      ),
    );
  }
}

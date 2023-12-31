import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/app_routes.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/core/service/shared_preferance_service.dart';
import 'package:kenz_app/provider/general_notifier.dart';
import 'package:kenz_app/screens/home_screen/widget/settings_tile_widget.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../../constants/asset_manager.dart';
import '../../../constants/font_manager.dart';
import '../../../constants/values_manger.dart';
import '../../widget/appbar_main_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final generalNotifier = context.read<GeneralNotifier>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        leading: IconButton(onPressed: ()=> Navigator.pop(context),icon: Icon(Icons.arrow_back,color: ColorManager.black,),),
        title: Text("Settings",style: getBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s18),),),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                kSizedBox20,
                Center(
                  child: CircleAvatar(
                    radius: 80.r,
                    backgroundImage: NetworkImage(
                        "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500"),
                  ),
                ),
                kSizedBox10,
                Text("${generalNotifier.getUserName}",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s14),),
                kSizedBox30,
                SettingsTile(icons: Icons.print_rounded,title: "Setup Printer",onTap: ()=>Navigator.pushNamed(context, printerSettingsScreen),),
                kSizedBox20,

                SettingsTile(onTap:  (){
                  AwesomeDialog(
                      dismissOnTouchOutside: true,
                      context: context,
                      dialogType: DialogType.question,
                      animType: AnimType.BOTTOMSLIDE,

                      title: "Confirmation",
                      desc: "Are you sure you want to logout",
                      descTextStyle: getSemiBoldStyle(color: ColorManager.primaryLight),
                      // desc:'Please login again',
                      btnCancelOnPress: () {},
                      btnOkText: "yes",
                      btnOkOnPress: () async {
                        CacheService cacheService = CacheService();
                        await cacheService.deleteSignUpCache();
                        Navigator.pushNamedAndRemoveUntil(context,loginRoute,(Route<dynamic> route) => false);
                      },
                      btnOkColor: ColorManager.primaryLight)
                      .show();
                },title: "Logout",icons: Icons.logout_rounded,color: ColorManager.red,),

              ],
            ),
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.done:
                    return Positioned(
                      bottom: 15,
                      right: 0,
                      left: 0,
                      child: Text(
                        'Version: ${snapshot.data?.version}\nBuildVersion: ${snapshot.data?.buildNumber}\nApp Name: Kenz App',
                        textAlign: TextAlign.center,
                        style: getRegularStyle(color: ColorManager.grey3),),
                    );
                  default:
                    return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}


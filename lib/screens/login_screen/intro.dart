import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import '../../constants/app_routes.dart';
import '../../constants/asset_manager.dart';
import '../../constants/string_manager.dart';
import '../../core/service/shared_preferance_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    // initPlatformState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 2000))
          .then((value) => checkCredential(context));
    });
    super.initState();
  }

  void checkCredential(BuildContext context) async {
    final CacheService cacheService = CacheService();
    // Navigator.of(context).pushAndRemoveUntil(
    //     MaterialPageRoute(builder: (context) => const OnBoardingScreen()),
    //     (route) => false);
    // Todo: Uncomment whenever colors added in the backend

    final token = await cacheService.readCache(key: AppStrings.token);

    if (token != null) {
      // bool hasExpired = JwtDecoder.isExpired(token);
      // print("is Token Expired? $hasExpired");
      if (false) {
        Navigator.pushNamedAndRemoveUntil(
            context, loginRoute, (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, mainRoute, (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, loginRoute, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: [

            Center(
              child: Image.asset(
                ImageAssets.logo,
                height: 70.h,
              ),
            ),
            // kSizedBox42,
            // FutureBuilder<PackageInfo>(
            //   future: PackageInfo.fromPlatform(),
            //   builder: (context, snapshot) {
            //     switch (snapshot.connectionState) {
            //       case ConnectionState.done:
            //         return Positioned(
            //           bottom: 15,
            //           right: 0,
            //           left: 0,
            //           child: Text(
            //             'Version: ${snapshot.data?.version}\nBuildVersion: ${snapshot.data?.buildNumber}\nApp Name: ${AppStrings.appName}',
            //             textAlign: TextAlign.center,
            //             style: getRegularStyle(color: ColorManager.grey3),),
            //         );
            //       default:
            //         return const SizedBox();
            //     }
            //   },
            // ),


          ],
        ),
      ),
    );
  }
}

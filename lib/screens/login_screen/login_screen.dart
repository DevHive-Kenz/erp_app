import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kenz_app/constants/app_routes.dart';
import 'package:kenz_app/constants/color_manger.dart';
import 'package:kenz_app/constants/constants.dart';
import 'package:kenz_app/constants/font_manager.dart';
import 'package:kenz_app/constants/style_manager.dart';
import 'package:kenz_app/constants/values_manger.dart';

import '../widget/rounded_button_widget.dart';
class LoginScreen extends HookWidget {


  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = useTextEditingController();
    final passController = useTextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Padding(
                padding:  EdgeInsets.only(top: 100.h),
                child: Center(child: Image.asset("asset/images/logo.png",height: 90.h,)),
              ),
              Form(

                child: Padding(
                  padding:  EdgeInsets.only(top:150.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Hello 👋",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s30) ),
                    Text("Welcome !",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s28) ),
                  kSizedBox50,
                     AuthTextField(userController: userController,title: "Enter User Name",),
                      kSizedBox20,
                      AuthTextField(userController: passController,title: "Enter Password",),
                      kSizedBox10,
                      Align(
                          alignment: Alignment.centerRight,
                          child: Text("Forgot password",style: getSemiBoldStyle(color: ColorManager.primaryLight,fontSize: FontSize.s16) )),
                      kSizedBox35,

                      RoundedButtonWidget(
                        title: "Login",
                        function: (){
                          Navigator.pushNamed(context, mainRoute);
                        },

                      )

                    ],
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,

    required this.userController,
    required this.title,
  }) : super(key: key);

  final TextEditingController userController;
  final String title;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: userController,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: title,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIconColor: Colors.red,
        contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey5, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.primaryLight, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffD32F2F), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffD32F2F), width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(35.0)),
        ),
      ),
    );
  }
}

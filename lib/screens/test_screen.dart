
import 'package:flutter/material.dart';
class test extends StatelessWidget {
  const test({super.key,required this.ima});
 final Widget ima;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        children: [
          ima
        ],
      ),
    );
  }
}

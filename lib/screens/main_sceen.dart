import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/general_notifier.dart';
import 'company_screen/company_screen.dart';



class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {



  int index = 0;
  late final  themeNotifier;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _asyncMethod();
    });
super.initState();
  }

  _asyncMethod() async {
    await Future.wait([
     context.read<GeneralNotifier>().checkAxisCount(context: context)

    ]);
  }

  final pages = <Widget>[
const CompanyScreen()
    // const StockScreen(),

  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBody: true,
      body: pages[index],
      // bottomNavigationBar: BottomNavigationBar(

          // items:  const <BottomNavigationBarItem>[
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.stacked_line_chart_rounded),
          //   //   label: "Stocks" ,
          //   // ),
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.home_filled),
          //   //   label: "Home" ,
          //   // ),
          //   // BottomNavigationBarItem(
          //   //   icon: Icon(Icons.book_rounded),
          //   //   label: "Report",
          //   // ),
          // ],
          // currentIndex: index,
          // onTap: (value){
          //   setState(() {
          //     index = value;
          //   });
      //     }
      // ),
      //

      // TabBarMaterialWidget(
      //   index: index,
      //   onChangedTab: onChangedTab,
      // ),
    );
  }

  void onChangedTab(int index) {
    setState(() {
      this.index = index;
 });
   }
}
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/notifier/auth/auth_notifier.dart';

import 'dataBase_fetch_notifier.dart';
import 'database_functionalities_notifier.dart';
import 'general_notifier.dart';

List<SingleChildWidget> providers = [...providersList];

//independent providers
List<SingleChildWidget> providersList = [

  ChangeNotifierProvider(create: (_) => GeneralNotifier()),
  ChangeNotifierProvider(create: (_) => AuthNotifier()),
  ChangeNotifierProvider(create: (_) => DataBaseFunctionalities()),
  ChangeNotifierProvider(create: (_) => DataBaseFetch()),


];
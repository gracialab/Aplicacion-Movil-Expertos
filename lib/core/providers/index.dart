import 'package:mr_fix_expert/core/providers/documents_and_help_center_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:mr_fix_expert/core/providers/user_provider.dart';
import 'package:mr_fix_expert/core/providers/purchase_provider.dart';
import 'package:mr_fix_expert/core/providers/bottom_navigation.dart';

List<SingleChildWidget> storeProviders = [
  ChangeNotifierProvider(create: (_) => UserProvider()),
  ChangeNotifierProvider(create: (_) => PurchaseProvider()),
  ChangeNotifierProvider(create: (_) => BottomBarProvider()),
  ChangeNotifierProvider(create: (_) => DocumentsAndHelpCenterProvider()),
];

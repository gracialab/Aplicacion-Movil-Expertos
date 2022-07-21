import 'package:jiffy/jiffy.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> initialConfig() async {
  await Firebase.initializeApp();
  await Jiffy.locale('es');
}

import 'package:firebase_core/firebase_core.dart';
import 'package:oil_bussiness/firebase_options.dart';

import 'res/paths/paths.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}



import 'package:emplolance/features/authentication/repository/authentication_repository.dart';
import 'package:emplolance/features/authentication/screens/welcome_screen.dart';
import 'package:emplolance/firebase_options.dart';
import 'package:emplolance/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      darkTheme: TAppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const CircularProgressIndicator(),
    );
  }
}

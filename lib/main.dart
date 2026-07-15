import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rider/auth/login_scree.dart';
import 'package:rider/screen/pool_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const securestorage = FlutterSecureStorage();
  final String? token = await securestorage.read(key: 'rider_auth_token');
  runApp(MyApp(isLoggedIn: token != null));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: isLoggedIn ? const PoolScreen() : const LoginScree(),
      ),
    );
  }
}

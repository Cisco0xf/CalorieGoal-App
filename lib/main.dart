import 'package:flowapp/commoms/navigator_key.dart';
import 'package:flowapp/constants/colors.dart';
import 'package:flowapp/presentaition_layer/screens/welcome_screen/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toastification/toastification.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();
  
  runApp(
    const ProviderScope(
      child: AppRoot(),
    ),
  );
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: const WelcomeScreen(),
        theme: ThemeData(
          scaffoldBackgroundColor: AppColors.bgColor,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
          ),
        ),
      ),
    );
  }
}

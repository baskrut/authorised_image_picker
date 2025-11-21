import 'package:authorised_image_picker/ui/screens/login_screen.dart';
import 'package:authorised_image_picker/ui/screens/home_screen.dart';
import 'package:authorised_image_picker/ui/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ProviderScope(child: MaterialWidget());
  }
}

class MaterialWidget extends ConsumerWidget {
  const MaterialWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Builder(
      builder: (context) {
        return MaterialApp(
          routes: {
            SplashScreen.id: (context) => const SplashScreen(),
            HomeScreen.id: (context) => const HomeScreen(),
            LoginScreen.id: (context) => const LoginScreen(),
          },
        );
      },
    );
  }
}

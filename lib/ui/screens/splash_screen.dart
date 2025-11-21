import 'dart:async';

import 'package:authorised_image_picker/servises/prefs_servise.dart';
import 'package:authorised_image_picker/ui/screens/home_screen.dart';
import 'package:authorised_image_picker/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const String id = '/';

  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Future.microtask(() => startupLogic());
    });
    super.initState();
  }

  void startupLogic() async {
    if (context.mounted) {
      final Prefs prefs = Prefs();

      await prefs.getAccessToken().then((token) {
        if (mounted) {
          if (token.isNotEmpty) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.id);
          } else {
            Navigator.of(context).pushReplacementNamed(LoginScreen.id);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(color: Colors.blueAccent),
        child: Center(child: Text('Splash Screen')),
      ),
    );
  }
}

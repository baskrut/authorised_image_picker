import 'package:authorised_image_picker/providers/auth_provider.dart';
import 'package:authorised_image_picker/ui/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainLayout extends StatelessWidget {
  final Widget child;
  final Function? onBackTap;
  final String appBarTitle;

  const MainLayout({super.key, required this.child, this.appBarTitle = '', this.onBackTap});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final NavigatorState navigator = Navigator.of(context);
        if (navigator.canPop()) {
          onBackTap?.call();
          navigator.pop();
        }
      },

      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: MainAppBar(title: appBarTitle),
        body: Padding(padding: EdgeInsets.all(16), child: child),
      ),
    );
  }
}

class MainAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String title;

  const MainAppBar({super.key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: Text(title, style: TextStyle(color: Colors.white)),
      centerTitle: false,
      titleSpacing: 0,
      leadingWidth: 56,
      backgroundColor: Colors.greenAccent,
      scrolledUnderElevation: 0,
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          color: Colors.transparent,
          height: 24.0,
          width: 24.0,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 18),
          child: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {
            ref.read(loginProvider.notifier).logout();
            Navigator.of(context).pushReplacementNamed(LoginScreen.id);
          },
          child: Icon(Icons.logout),
        ),
      ],
    );
  }
}

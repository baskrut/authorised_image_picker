import 'package:authorised_image_picker/ui/widgets/focus_layout.dart';
import 'package:flutter/material.dart';

class SecondaryLayout extends StatelessWidget {
  final VoidCallback? onDisposeFocus;
  final Widget child;
  final EdgeInsets? padding;

  const SecondaryLayout({
    super.key,
    required this.child,
    this.onDisposeFocus,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return FocusLayout(
      onTap: onDisposeFocus,
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        resizeToAvoidBottomInset: true,

        body: SafeArea(
          child: Padding(padding: padding ?? const EdgeInsets.all(16.0), child: child),
          // )
        ),
      ),
    );
  }
}

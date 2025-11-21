import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String label;
  final Function() onTap;
  final Color? labelColor;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? iconColor;
  final String? iconName;
  final bool loading;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const CommonButton({
    required this.label,
    required this.onTap,
    required this.loading,
    this.buttonColor = Colors.teal,
    this.labelColor,
    this.borderColor,
    this.iconColor,
    this.iconName,
    this.padding,
    this.textStyle,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: padding ?? EdgeInsets.all(16),
        decoration: BoxDecoration(color: buttonColor, borderRadius: BorderRadius.circular(12.0)),
        child: loading
            ? Center(
                child: SizedBox(
                  height: 15.0,
                  width: 15.0,
                  child: CircularProgressIndicator(color: labelColor ?? Colors.white),
                ),
              )
            : Center(
                child: Text(
                  label,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style:
                      textStyle ??
                      Theme.of(context).textTheme.bodySmall?.copyWith(color: labelColor ?? Colors.white),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatefulWidget {
  final String? prefixIconPath;
  final Widget? suffixIcon;
  final Color? prefixIconColor;
  final String? label;
  final String? hint;
  final TextStyle? hintStyle;
  final bool obscureText;

  final TextEditingController? textController;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final String? errorText;
  final String? Function(String?)? validator;
  final VoidCallback? onEditingComplete;
  final TextInputType? keyboardType;
  final TextStyle? errorStyle;
  final Color? errorIconColor;
  final bool enabled;
  final bool readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction? textInputAction;
  final Function? onFieldSubmitted;
  final bool autofocus;
  final String? counterText;

  final double scrollPadding;
  final Widget? prefixIcon;
  final FloatingLabelBehavior? floatingLabelBehavior;

  const TextInputField({
    required this.textController,
    this.keyboardType,
    this.prefixIconPath,
    this.prefixIconColor,
    this.prefixIcon,
    this.label,
    this.hint,
    this.hintStyle,
    this.onChanged,
    this.suffixIcon,
    this.focusNode,
    this.nextFocusNode,
    this.errorText,
    this.errorStyle,
    this.validator,
    this.errorIconColor,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.inputFormatters,
    this.onEditingComplete,
    this.textInputAction,
    this.onFieldSubmitted,
    this.autofocus = false,
    this.counterText,
    this.scrollPadding = 60.0,
    this.floatingLabelBehavior,
    super.key,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      scrollPadding: EdgeInsets.only(bottom: widget.scrollPadding),
      autofocus: widget.autofocus,
      onEditingComplete: widget.onEditingComplete,
      inputFormatters: widget.inputFormatters,
      textInputAction: widget.textInputAction,
      enabled: widget.enabled,
      readOnly: widget.readOnly,
      keyboardType: widget.keyboardType,
      textAlign: TextAlign.left,
      controller: widget.textController,
      style: Theme.of(context).textTheme.bodyMedium,
      maxLines: 1,
      obscureText: widget.obscureText,
      focusNode: widget.focusNode,
      onChanged: (x) async {
        widget.onChanged?.call(x);
      },
      onFieldSubmitted: (term) {
        if (widget.onFieldSubmitted != null) {
          widget.onFieldSubmitted!();
        }
        _onFieldSubmitted(context);
      },
      validator: widget.validator,
      decoration: InputDecoration(
        isDense: true,
        alignLabelWithHint: false,
        suffixIcon: widget.suffixIcon,
        suffixIconConstraints: const BoxConstraints(maxHeight: 30.0, maxWidth: 132.0),
        counterText: widget.counterText ?? '',
        floatingLabelBehavior: widget.floatingLabelBehavior,
        labelText: widget.label,
        labelStyle: TextStyle(height: 4, color: Theme.of(context).textTheme.bodyMedium?.color),

        hintText: widget.hint,
        errorText: widget.errorText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(
            color: widget.errorText != null ? Colors.red : Theme.of(context).dividerColor,
            width: 1.0,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Theme.of(context).dividerColor, width: 1.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.0),
        ),
      ),
    );
  }

  void _onFieldSubmitted(BuildContext context) {
    widget.focusNode?.unfocus();
    FocusScope.of(context).requestFocus(widget.nextFocusNode);
  }
}

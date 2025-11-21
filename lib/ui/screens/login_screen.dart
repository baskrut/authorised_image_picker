import 'package:authorised_image_picker/providers/auth_provider.dart';
import 'package:authorised_image_picker/ui/screens/home_screen.dart';
import 'package:authorised_image_picker/ui/widgets/common_button.dart';
import 'package:authorised_image_picker/ui/widgets/secondary_layout.dart';
import 'package:authorised_image_picker/ui/widgets/text_input_field.dart';
import 'package:authorised_image_picker/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final class LoginScreen extends ConsumerStatefulWidget {
  static const String id = '/LoginScreen';

  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  late final TextEditingController emailController = TextEditingController();
  late final TextEditingController passwordController = TextEditingController();

  bool obscureText = true;
  String? emailError;
  String? passwordError;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SecondaryLayout(
      child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                TextInputField(
                  label: 'Email',
                  textController: emailController,
                  errorText: emailError,
                  onChanged: (x) {
                    if (x.isNotEmpty && emailError != null) {
                      setState(() {
                        emailError = null;
                      });
                    }
                  },
                ),
                const SizedBox(height: 16),
                TextInputField(
                  label: 'Password',
                  textController: passwordController,
                  errorText: passwordError,
                  obscureText: obscureText,
                  onChanged: (x) {
                    if (x.isNotEmpty && passwordError != null) {
                      setState(() {
                        passwordError = null;
                      });
                    }
                  },
                  suffixIcon: IconButton(
                    icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),
                const Spacer(),
                const SizedBox(height: 16),
                CommonButton(
                  label: 'Login',
                  loading: ref.watch(loginProvider).isLoading,
                  onTap: () async {
                    if (validate(emailController.text, passwordController.text)) {
                      final token = await ref
                          .read(loginProvider.notifier)
                          .login(emailController.text, passwordController.text);
                      if (token != null && context.mounted) {
                        Navigator.of(context).pushReplacementNamed(HomeScreen.id);
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool validate(String email, String password) {
    if (email.isEmpty) {
      setState(() {
        emailError = 'Field should not be empty';
      });
    } else if (!validateEmail(email)) {
      setState(() {
        emailError = 'Wrong email format';
      });
    }
    if (password.isEmpty) {
      setState(() {
        passwordError = 'Field should not be empty';
      });
    }

    return emailError == null && passwordError == null ? true : false;
  }
}

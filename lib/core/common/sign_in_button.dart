import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/constants/constants.dart';
import 'package:reddit_clone_flutter/features/auth/controller/auth_controller.dart';
import 'package:reddit_clone_flutter/theme/pallete.dart';

class SignInButton extends ConsumerWidget {
  const SignInButton({super.key});

  void signInWithGoogle(
    BuildContext context,
    WidgetRef ref,
  ) {
    ref.read(authControllerProvider.notifier).signInWithGoogle(context);
  }

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    return ElevatedButton.icon(
      onPressed: () => signInWithGoogle(context, ref),
      icon: Image.asset(
        Constants.googleLogoPath,
        width: 35,
      ),
      label: Text(
        "Continue with Google",
        style: TextStyle(
          fontSize: 18,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Pallete.greyColor,
        minimumSize: Size(
          double.infinity,
          50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(999),
        ),
      ),
    );
  }
}

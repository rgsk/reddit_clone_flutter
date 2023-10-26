import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/utils.dart';
import 'package:reddit_clone_flutter/features/auth/repository/auth_repository.dart';

final authControllerProvider = Provider(
  (ref) => AuthController(
    authRepository: ref.read(
      authRepositoryProvider,
    ),
  ),
);

class AuthController {
  final AuthRepository _authRepository;

  AuthController({required AuthRepository authRepository})
      : _authRepository = authRepository;

  void signInWithGoogle(BuildContext context) async {
    final result = await _authRepository.signInWithGoogle();
    result.fold(
      (failure) {
        showSnackBar(
          context,
          failure.message,
        );
      },
      (userModel) {
        // store in the provider
      },
    );
  }
}

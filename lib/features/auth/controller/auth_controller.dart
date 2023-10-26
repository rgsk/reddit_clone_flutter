import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit_clone_flutter/core/utils.dart';
import 'package:reddit_clone_flutter/features/auth/repository/auth_repository.dart';
import 'package:reddit_clone_flutter/models/user_model.dart';

final userProvider = StateProvider<UserModel?>((ref) => null);

final authControllerProvider = StateNotifierProvider<AuthController, bool>(
  (ref) => AuthController(
    authRepository: ref.watch(
      authRepositoryProvider,
    ),
    ref: ref,
  ),
);

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;
  AuthController({
    required AuthRepository authRepository,
    required Ref ref,
  })  : _authRepository = authRepository,
        _ref = ref,
        super(false);

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final result = await _authRepository.signInWithGoogle();
    state = false;
    result.fold(
      (failure) {
        showSnackBar(
          context,
          failure.message,
        );
      },
      (userModel) {
        // store in the provider
        _ref.read(userProvider.notifier).update(
              (state) => userModel,
            );
      },
    );
  }
}

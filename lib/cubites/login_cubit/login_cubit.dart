import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubites/login_cubit/login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialInitialState());

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  Future<void> signInUser(
      {required String email, required String password}) async {
    emit(SocialLoginLoadingState());

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      emit(SocialLoginSuccessState(FirebaseAuth.instance.currentUser!.uid));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        emit(SocialLoginErrorState('user not found'));
      } else if (e.code == 'wrong-password') {
        emit(SocialLoginErrorState('wrong password'));
      }
    } catch (e) {
      emit(SocialLoginErrorState('some thing want wrong'));
    }
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubites/register_cubit/register_state.dart';
import 'package:social_app/model/user_model.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  Future<void> registerUser({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    emit(SocilaRegisterLoadingState());

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((value) {
        createUser(
            name: name, phone: phone, email: email, uId: value.user!.uid);
      });
      //  emit(SocialRegisterSuccessState()); //! because the indecator is stop to work after go to home layout
    } on FirebaseAuthException catch (e) {
      emit(SocialRegisterErrorState(e.message.toString()));
    } catch (e) {
      emit(SocialRegisterErrorState('some thing want wrong'));
    }
  }

  void createUser({
    required String name,
    required String phone,
    required String email,
    required String uId,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      email: email,
      uId: uId,
      isEmailVerified: false,
    );

    //! in this case i set the value in user collection
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(SocilaRegisterUserSuccessState());
    }).catchError((error) {
      emit(SocialRegisterUserErrorState(error.toString()));
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}

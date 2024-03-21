import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubites/register_cubit/register_state.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  // get categoriesModel => null;

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  // ShopLoginModel? loginModel;

  // void userRegister(
  //     {required String email,
  //     required String password,
  //     required String name,
  //     required String phone}) {
  //   emit(ShopRegisterLoadingState());
  //   //! called endpoints
  //   DioHelper.postData(
  //     url: register,
  //     data: {
  //       'name': name,
  //       'phone': phone,
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     //? [value.data] => this all data from json
  //     loginModel = ShopLoginModel.fromJson(value.data); //? all data in json
  //     emit(ShopRegisterSuccessState(loginModel));
  //   }).catchError((error) {
  //     print(error);
  //     emit(ShopRegisterErrorState(error.toString()));
  //   });
  // }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}

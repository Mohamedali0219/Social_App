import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubites/login_cubit/shop_login_state.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialInitialState());

  get categoriesModel => null;

  static SocialLoginCubit get(context) => BlocProvider.of(context);

  // ShopLoginModel? loginModel;

  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(ShopLoginLoadingState());
  //   //! called endpoints
  //   DioHelper.postData(
  //     url: login,
  //     data: {
  //       'email': email,
  //       'password': password,
  //     },
  //   ).then((value) {
  //     //? [value.data] => this all data from json
  //     loginModel = ShopLoginModel.fromJson(value.data); //? all data in json
  //     emit(ShopLoginSuccessState(loginModel));
  //   }).catchError((error) {
  //     print(error);
  //     emit(ShopLoginErrorState(error.toString()));
  //   });
  // }

  IconData suffixIcon = Icons.visibility_outlined;
  bool isPassword = true;
  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffixIcon =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangePasswordVisibilityState());
  }
}

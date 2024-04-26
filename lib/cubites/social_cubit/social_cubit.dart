import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/screens/chats.dart';
import 'package:social_app/screens/feeds.dart';
import 'package:social_app/screens/settings.dart';
import 'package:social_app/screens/users.dart';

class SocialCubit extends Cubit<SocialState> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userData;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //! value from type documentSnapshot
      print(value.data());
      userData = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(BottonNavBarChangeState());
    }
  }
}

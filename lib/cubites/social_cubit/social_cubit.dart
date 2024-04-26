import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/model/user_model.dart';
import 'package:social_app/screens/chats.dart';
import 'package:social_app/screens/feeds.dart';
import 'package:social_app/screens/new_post.dart';
import 'package:social_app/screens/settings.dart';
import 'package:social_app/screens/users.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitial());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserModel? userModel;

  void getUserData() {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //! value from type documentSnapshot
      print(value.data());
      userModel = UserModel.fromJson(value.data()!);
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = const [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];

  List<String> titles = [
    'Feeds',
    'Chats',
    'posts',
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

  File? profileImage;
  var picker = ImagePicker();
  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      debugPrint(profileImage!.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      debugPrint(coverImage!.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialCovereImagePickedErrorState());
    }
  }

  String imageProfileUrl = '';
  void uploadProfileImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          //!upload link to firebase storage
          debugPrint(value);
          imageProfileUrl = value;
          emit(SocialUploadProfileImageSuccessState());
        }).catchError((e) {
          emit(SocialUploadProfileImageErrorState());
        });
      },
    ).catchError((e) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  String imageCovereUrl = '';
  void uploadCoverImage() {
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          //!upload link to firebase storage
          debugPrint(value);
          imageCovereUrl = value;
          emit(SocialUploadCoverImageSuccessState());
        }).catchError((e) {
          emit(SocialUploadCovereImageErrorState());
        });
      },
    ).catchError((e) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  //! function to upload image to firebase storage
  String imageprofile = ''; //!for test function
  String imagecover = '';
  void uploadImage({imageKind, image, folderName}) {
    FirebaseStorage.instance
        .ref()
        .child('$folderName/${Uri.file(image!.path).pathSegments.last}')
        .putFile(image!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          debugPrint(value);
          if (imageKind == kProfileImage) {
            imageprofile = value;
            emit(SocialUploadImageSuccessState());
          } else if (imageKind == kCoverImage) {
            imagecover = value;
            emit(SocialUploadImageSuccessState());
          }
        }).catchError((e) {
          emit(SocialUploadImageErrorState());
        });
      },
    ).catchError((e) {
      emit(SocialUploadImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialUserUpdateLoadingState());
    if (profileImage != null) {
      uploadProfileImage();
    } else if (coverImage != null) {
      uploadCoverImage();
    } else {
      UserModel model = UserModel(
          name: name,
          phone: phone,
          bio: bio,
          //! old values [image,cover,email,uId] to don't give me the null
          image: userModel!.image,
          cover: userModel!.cover,
          email: userModel!.email,
          uId: userModel!.uId,
          isEmailVerified: false);
      FirebaseFirestore.instance
          .collection('users')
          .doc(userModel!.uId)
          .update(model.toMap())
          .then((value) {
        getUserData(); //! i don't need to emit state becuse getUserData will emit state
      }).catchError((error) {
        emit(SocialUpdateUserErrorState());
      });
    }
  }
}

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/constant.dart';
import 'package:social_app/cubites/social_cubit/social_state.dart';
import 'package:social_app/model/post_model.dart';
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

  // String imageProfileUrl = '';
  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialProfileUserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          //!upload link to firebase storage
          debugPrint(value);
          // imageProfileUrl = value;
          // emit(SocialUploadProfileImageSuccessState()); //!  because the indecator is stop to work for any resone if emit anther state
          updateUserData(name: name, phone: phone, bio: bio, image: value);
        }).catchError((e) {
          emit(SocialUploadProfileImageErrorState());
        });
      },
    ).catchError((e) {
      emit(SocialUploadProfileImageErrorState());
    });
  }

  // String imageCovereUrl = '';
  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialCoverUserUpdateLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          //!upload link to firebase storage
          debugPrint(value);
          //  imageCovereUrl = value;
          //  emit(SocialUploadCoverImageSuccessState()); //! because the indecator is stop to work for any resone if emit anther state
          updateUserData(name: name, phone: phone, bio: bio, cover: value);
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
  //? note according to the single rsponsipility principle
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

  // void updateUser({
  //   required String name,
  //   required String phone,
  //   required String bio,
  // }) {
  //   emit(SocialUserUpdateLoadingState());
  //   if (profileImage != null) {
  //     uploadProfileImage();
  //   } else if (coverImage != null) {
  //     uploadCoverImage();
  //   } else {
  //     UserModel model = UserModel(
  //         name: name,
  //         phone: phone,
  //         bio: bio,
  //         //! old values [image,cover,email,uId] to don't give me the null
  //         image: userModel!.image,
  //         cover: userModel!.cover,
  //         email: userModel!.email,
  //         uId: userModel!.uId,
  //         isEmailVerified: false);
  //     FirebaseFirestore.instance
  //         .collection('users')
  //         .doc(userModel!.uId)
  //         .update(model.toMap())
  //         .then((value) {
  //       getUserData(); //! i don't need to emit state becuse getUserData will emit state
  //     }).catchError((error) {
  //       emit(SocialUpdateUserErrorState());
  //     });
  //   }
  // }

  void updateUserData({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(SocialUserUpdateLoadingState());
    UserModel model = UserModel(
        name: name,
        phone: phone,
        bio: bio,
        //! old values [image,cover,email,uId] to don't give me the null
        image: image ?? userModel!.image,
        cover: cover ?? userModel!.cover,
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

  File? postImage;

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  Future<void> getPostImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      debugPrint(postImage!.path);
      emit(SocialPostImagePickedSuccessState());
    } else {
      debugPrint('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then(
      (value) {
        value.ref.getDownloadURL().then((value) {
          createPost(
            dateTime: dateTime,
            text: text,
            postImage: value,
          );
        }).catchError((e) {
          emit(SocialCreatePostErrorState());
        });
      },
    ).catchError((e) {
      emit(SocialCreatePostErrorState());
    });
  }

  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }) {
    PostModel model = PostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      iamgePost: postImage,
    );
    emit(SocialCreatePostLoadingState());
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit((SocialCreatePostSuccessgState()));
      getPosts();
    }).catchError((error) {
      emit((SocialCreatePostErrorState()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  void getPosts() {
    emit(SocialGetPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      for (var element in value.docs) {
        element.reference.collection('likes').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((e) {});
      }
      emit(SocialGetPostsSuccessState());
    }).catchError((e) {
      emit(SocialGetPostsErrorState(e.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikeSuccessState());
    }).catchError((e) {
      emit(SocialLikeErrorState(e.toString()));
    });
  }
}

abstract class SocialStates {}

final class SocialInitial extends SocialStates {}

final class SocialGetUserLoadingState extends SocialStates {}

final class SocialGetUserSuccessState extends SocialStates {}

final class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

final class BottonNavBarChangeState extends SocialStates {}

final class SocialNewPostState extends SocialStates {}

class SocialProfileImagePickedSuccessState extends SocialStates {}

class SocialProfileImagePickedErrorState extends SocialStates {}

class SocialCoverImagePickedSuccessState extends SocialStates {}

class SocialCovereImagePickedErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCovereImageErrorState extends SocialStates {}

class SocialUploadImageSuccessState extends SocialStates {}

class SocialUploadImageErrorState extends SocialStates {}

class SocialUserUpdateLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

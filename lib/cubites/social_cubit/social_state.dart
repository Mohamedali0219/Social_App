abstract class SocialStates {}

final class SocialInitial extends SocialStates {}

final class SocialGetUserLoadingState extends SocialStates {}

final class SocialGetUserSuccessState extends SocialStates {}

final class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

final class SocialGetAllUserLoadingState extends SocialStates {}

final class SocialGetAllUserSuccessState extends SocialStates {}

final class SocialGetAllUserErrorState extends SocialStates {
  final String error;
  SocialGetAllUserErrorState(this.error);
}

final class SocialLikeSuccessState extends SocialStates {}

final class SocialLikeErrorState extends SocialStates {
  final String error;
  SocialLikeErrorState(this.error);
}

final class SocialGetPostsLoadingState extends SocialStates {}

final class SocialGetPostsSuccessState extends SocialStates {}

final class SocialGetPostsErrorState extends SocialStates {
  final String error;
  SocialGetPostsErrorState(this.error);
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

class SocialProfileUserUpdateLoadingState extends SocialStates {}

class SocialCoverUserUpdateLoadingState extends SocialStates {}

class SocialUpdateUserErrorState extends SocialStates {}

//? Posts
class SocialCreatePostLoadingState extends SocialStates {}

class SocialCreatePostSuccessgState extends SocialStates {}

class SocialCreatePostErrorState extends SocialStates {}

class SocialPostImagePickedSuccessState extends SocialStates {}

class SocialPostImagePickedErrorState extends SocialStates {}

class SocialCreatePostImageLoadingState extends SocialStates {}

class SocialRemovePostImageState extends SocialStates {}

class SocialSendMessageSuccessState extends SocialStates {}

class SocialSendMessageErrorState extends SocialStates {}

class SocialGetMessageSuccessState extends SocialStates {}

class SoicalGetMessageErrorState extends SocialStates {}

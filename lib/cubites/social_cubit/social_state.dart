abstract class SocialState {}

final class SocialInitial extends SocialState {}

final class SocialGetUserLoadingState extends SocialState {}

final class SocialGetUserSuccessState extends SocialState {}

final class SocialGetUserErrorState extends SocialState {
  final String error;
  SocialGetUserErrorState(this.error);
}

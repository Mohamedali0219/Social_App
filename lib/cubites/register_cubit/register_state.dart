abstract class SocialRegisterStates {}

class SocialRegisterInitialState extends SocialRegisterStates {}

class SocilaRegisterLoadingState extends SocialRegisterStates {}

class SocialRegisterSuccessState extends SocialRegisterStates {}

class SocialRegisterErrorState extends SocialRegisterStates {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocilaRegisterUserSuccessState extends SocialRegisterStates {}

class SocialRegisterUserErrorState extends SocialRegisterStates {
  final String? error;
  SocialRegisterUserErrorState(this.error);
}

class ChangeRegisterPasswordVisibilityState extends SocialRegisterStates {}

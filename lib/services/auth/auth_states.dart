class AuthStates {
  final bool isAuthenticated;
  final bool isLoading;
  final String? errorMessage;

  AuthStates._({
    required this.isAuthenticated,
    required this.isLoading,
    this.errorMessage,
  });

  factory AuthStates.loggedIn() =>
      AuthStates._(isAuthenticated: true, isLoading: false);
  factory AuthStates.loggedOut() =>
      AuthStates._(isAuthenticated: false, isLoading: false);
  factory AuthStates.loading() =>
      AuthStates._(isAuthenticated: false, isLoading: true);
  factory AuthStates.error(String message) => AuthStates._(
    isAuthenticated: false,
    isLoading: false,
    errorMessage: message,
  );
}

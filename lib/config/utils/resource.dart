abstract class Resource<T> {
  Resource();
}

class Init extends Resource {
  Init();
}

class Loading extends Resource {
  Loading();
}

class Success<T> extends Resource<T> {
  final T data;
  Success(this.data);
}

class Error<T> extends Resource<T> {
  final String error;

  Error(this.error);

  String getErrorMessage() {
    switch (error) {
      case 'network-request-failed':
        return 'Timeout';
      case 'invalid-credential':
        return 'Invalid credentials';
      case 'email-already-in-use':
        return 'Email already in use';
      case 'user-disabled':
        return 'Account disabled';
      default:
        return 'Something went wrong';
    }
  }
}

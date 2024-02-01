abstract class Resource<T> {
  Resource();
}

class Init<T> extends Resource<T> {
  final String data;
  Init(this.data);
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
      case 'username-already-in-use':
        return 'Username already in use';
      case 'user-disabled':
        return 'Account disabled';
      case 'photo-could-not-be-selected':
        return 'The photo could not be selected';
      case 'too-many-requests':
        return 'Too many requests';
      case 'wrong-password': 
        return 'Incorrect passowrd'; 
      case 'user-not-found': 
        return 'User not found'; 
      default:
        print('error get error $error');
        return 'Something went wrong';
    }
  }
}

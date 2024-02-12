enum ResourceStatus { loading, success, error, init }

class Resource<T> {
  final ResourceStatus status;
  final T? data;
  final String? message;

  Resource(this.status, {this.data, this.message});

  static String getMessage( String? message) {
  if ( message != null) {
    switch (message) {
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
        return 'Incorrect password';
      case 'user-not-found':
        return 'User not found';
      case 'post-deleted': 
        return 'Post deleted';
      case 'post-created-successfully':
        return 'Post created successfully';
      default:
        return 'Something went wrong';
    }
  } else {
    return ''; // No send error message when is other status
  }
}
}

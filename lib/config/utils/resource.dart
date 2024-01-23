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
        return 'No se pudo conectar con el servidor';
      case 'invalid-credential':
        return 'Email o contraseña incorrectos';
      default:
        return 'Error desconocido: $error';
    }
  }
}

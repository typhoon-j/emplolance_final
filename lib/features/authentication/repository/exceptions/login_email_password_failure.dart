class LogInWithEmailAndPasswordFailure {
  final String message;

  const LogInWithEmailAndPasswordFailure(
      [this.message = 'Unknown error ocurred']);

  factory LogInWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'user-not-found':
        return const LogInWithEmailAndPasswordFailure(
            'No existe una cuenta con este correo');
      case 'wrong-password':
        return const LogInWithEmailAndPasswordFailure(
            'La contraseña es incorrecta');
      case 'user-disabled':
        return const LogInWithEmailAndPasswordFailure(
            'El usuario esta inhabilitado');
      default:
        return const LogInWithEmailAndPasswordFailure();
    }
  }
}

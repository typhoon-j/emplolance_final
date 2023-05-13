class SignUpWithEmailAndPasswordFailure {
  final String message;

  const SignUpWithEmailAndPasswordFailure(
      [this.message = 'Unknown error ocurred']);

  factory SignUpWithEmailAndPasswordFailure.code(String code) {
    switch (code) {
      case 'weak-password':
        return const SignUpWithEmailAndPasswordFailure(
            'Ingrese una contraseña más fuerte');
      case 'invalid-email':
        return const SignUpWithEmailAndPasswordFailure(
            'Email no valido o mal escrito');
      case 'email-already-in-use':
        return const SignUpWithEmailAndPasswordFailure(
            'Ya existe una cuenta con este correo');
      case 'operation-not-allowed':
        return const SignUpWithEmailAndPasswordFailure(
            'Operacion no permitida');
      case 'user-disabled':
        return const SignUpWithEmailAndPasswordFailure(
            'El usuario esta deshabilitado. Contacte a soporte');
      default:
        return const SignUpWithEmailAndPasswordFailure();
    }
  }
}

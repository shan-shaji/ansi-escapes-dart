class AnsiException implements Exception {
  String? msg;

  AnsiException(this.msg);

  @override
  String toString() {
    return msg!;
  }
}

class TypeException extends AnsiException {
  TypeException(String? msg) : super(msg);
}

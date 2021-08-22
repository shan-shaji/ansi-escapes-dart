class AnsiException implements Exception {
  String? msg;
  AnsiException([msg]);

  @override
  String toString() {
    return msg!;
  }
}

class TypeException extends AnsiException {
  String? msg;
  TypeException([msg]) : super(msg);
}

import 'package:ansi_escapes/src/utils/exceptions.dart';

const ESC = '\u001B[';
const OSC = '\u001B]';
const BEL = '\u0007';
const SEP = ';';

class AnsiEscapes {
  String curserTo(x, y) {
    if (x.runtimeType != int) {
      throw TypeException('The `x` argument is required');
    }
    if (y.runtimeType != int) {
      return ESC + (x + 1) + 'G';
    }
    return ESC + (y + 1) + ';' + (x + 1) + 'H';
  }

  String cursorMove(x, y) {
    if (x.runtimeType != int) {
      throw TypeException('The `x` argument is required');
    }

    var returnValue = '';

    if (x < 0) {
      returnValue += ESC + (-x) + 'D';
    } else if (x > 0) {
      returnValue += ESC + x + 'C';
    }

    if (y < 0) {
      returnValue += ESC + (-y) + 'A';
    } else if (y > 0) {
      returnValue += ESC + y + 'B';
    }
    return returnValue;
  }
}

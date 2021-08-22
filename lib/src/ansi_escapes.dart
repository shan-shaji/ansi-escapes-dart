import 'dart:io';

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

  String cursorUp([count = 1]) => ESC + count.toString() + 'A';
  String cursorDown([count = 1]) => ESC + count.toString() + 'B';
  String cursorForward([count = 1]) => ESC + count.toString() + 'C';
  String cursorBackward([count = 1]) => ESC + count.toString() + 'D';

  String cursorLeft = ESC + 'G';
  String cursorGetPosition = ESC + '6n';
  String cursorNextLine = ESC + 'E';
  String cursorPrevLine = ESC + 'F';
  String cursorHide = ESC + '?25l';
  String cursorShow = ESC + '?25h';

  String eraseEndLine = ESC + 'K';
  String eraseStartLine = ESC + '1K';
  String eraseLine = ESC + '2K';
  String eraseDown = ESC + 'J';
  String eraseUp = ESC + '1J';
  String eraseScreen = ESC + '2J';
  String scrollUp = ESC + 'S';
  String scrollDown = ESC + 'T';

  String clearScreen = '\u001Bc';

  String eraseLines(count) {
    var clear = '';

    for (var i = 0; i < count; i++) {
      clear += eraseLine + (i < count - 1 ? cursorUp() : '');
    }
    if (count) {
      clear += cursorLeft;
    }
    return clear;
  }

  String get clearTerminal => Platform.isWindows
      ? '$eraseScreen${ESC}0f'
      :
      // 1. Erases the screen (Only done in case `2` is not supported)
      // 2. Erases the whole screen including scrollback buffer
      // 3. Moves cursor to the top-left position
      // More info: https://www.real-world-systems.com/docs/ANSIcode.html
      '$eraseScreen${ESC}3J${ESC}H';

  String beep = BEL;

  String link(url, text) {
    return [
      OSC,
      '8',
      SEP,
      SEP,
      url,
      BEL,
      text,
      OSC,
      '8',
      SEP,
      SEP,
      BEL,
    ].join('');
  }

  String image(buffer, Options options) {
    var returnValue = '${OSC}1337;File=inline=1';

    if (options.width != null) {
      returnValue += ';width=${options.width}';
    }

    if (options.height != null) {
      returnValue += ';height=${options.height}';
    }

    if (options.preserveAspectRatio == false) {
      returnValue += ';preserveAspectRatio=0';
    }

    return returnValue + ':' + buffer.toString('base64') + BEL;
  }
}

class Options {
  int? width;
  int? height;
  bool? preserveAspectRatio;

  Options({
    this.height,
    this.preserveAspectRatio,
    this.width,
  });
}

import 'dart:io';

import 'package:ansi_escapes/src/constants/constants.dart';
import 'package:ansi_escapes/src/helper/options.dart';
import 'package:ansi_escapes/src/utils/exceptions.dart';

class AnsiEscapes {
  /// Set the absolute position of the cursor. x0 y0 is the top left of the screen.
  String curserTo(x, y) {
    if (x.runtimeType != int) {
      throw TypeException('The `x` argument is required');
    }
    if (y.runtimeType != int) {
      return ESC + (x + 1) + 'G';
    }
    return ESC + (y + 1).toString() + ';' + (x + 1).toString() + 'H';
  }

  /// Set the position of the cursor relative to its current position.
  String cursorMove(x, y) {
    if (x.runtimeType != int) {
      throw TypeException('The `x` argument is required');
    }

    var returnValue = '';

    if (x < 0) {
      returnValue += ESC + (-x).toString() + 'D';
    } else if (x > 0) {
      returnValue += ESC + x.toString() + 'C';
    }

    if (y < 0) {
      returnValue += ESC + (-y).toString() + 'A';
    } else if (y > 0) {
      returnValue += ESC + y.toString() + 'B';
    }
    return returnValue;
  }

  /// Move cursor up a specific amount of rows. Default `count`` value is 1.
  String cursorUp([count = 1]) => ESC + count.toString() + 'A';

  /// Move cursor down a specific amount of rows. Default `count` value is 1.
  String cursorDown([count = 1]) => ESC + count.toString() + 'B';

  /// Move cursor forward a specific amount of columns. Default `count` is 1.
  String cursorForward([count = 1]) => ESC + count.toString() + 'C';

  /// Move cursor backward a specific amount of columns. Default `count` is 1.
  String cursorBackward([count = 1]) => ESC + count.toString() + 'D';

  /// [cursorLeft] Move cursor to the left side.
  String cursorLeft = ESC + 'G';

  /// [cursorGetPosition] Get cursor position.
  String cursorGetPosition = ESC + '6n';

  /// [cursorNextLine] Move cursor to the next line.
  String cursorNextLine = ESC + 'E';

  /// [cursorPrevLine] Move cursor to the previous line.
  String cursorPrevLine = ESC + 'F';

  /// [cursorHide] Hide cursor.
  String cursorHide = ESC + '?25l';

  /// [cursorShow] Show cursor.
  String cursorShow = ESC + '?25h';

  /// [eraseEndLine] Erase from the current
  /// cursor position to the end of the current line.
  String eraseEndLine = ESC + 'K';

  /// [eraseStartLine] Erase from the current
  /// cursor position to the start of the current line.
  String eraseStartLine = ESC + '1K';

  /// [eraseLine] E1rase the entire current line.
  String eraseLine = ESC + '2K';

  /// [eraseDown] Erase the screen from the current
  /// line down to the bottom of the screen.
  String eraseDown = ESC + 'J';

  /// [eraseUp] Erase the screen from the current
  /// line up to the top of the screen.
  String eraseUp = ESC + '1J';

  /// [eraseScreen] Erase the screen and move the cursor the top left position.
  String eraseScreen = ESC + '2J';

  /// [scrollUp] Scroll display up one line.
  String scrollUp = ESC + 'S';

  /// [scrollDown] Scroll display down one line.
  String scrollDown = ESC + 'T';

  /// [clearScreen] Clear the terminal screen. (Viewport)
  String clearScreen = '\u001Bc';

  /// Erase from the current cursor position up the specified amount of rows `count`.
  String eraseLines(count) {
    var clear = '';

    for (var i = 0; i < count; i++) {
      clear += eraseLine + (i < count - 1 ? cursorUp() : '');
    }
    if (count != null) {
      clear += cursorLeft;
    }
    return clear;
  }

  /// Clear the whole terminal, including scrollback buffer. (Not just the visible part of it)
  String get clearTerminal => Platform.isWindows
      ? '$eraseScreen${ESC}0f'
      :
      // 1. Erases the screen (Only done in case `2` is not supported)
      // 2. Erases the whole screen including scrollback buffer
      // 3. Moves cursor to the top-left position
      // More info: https://www.real-world-systems.com/docs/ANSIcode.html
      '$eraseScreen${ESC}3J${ESC}H';

  /// [beep] Output a beeping sound.
  String beep = BEL;

  /// [link] Create a clickable link.
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

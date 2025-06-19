import 'dart:convert';
import 'dart:io';
import 'dart:typed_data' show Uint8List;

import 'package:ansi_escapes/src/constants/constants.dart';
import 'package:ansi_escapes/src/utils/exceptions.dart';

class AnsiEscapes {
  AnsiEscapes._();

  static AnsiEscapes instance = AnsiEscapes._();

  /// Set the absolute position of the cursor. x0 y0 is the top left of the screen.
  String cursorTo(int x, [int? y]) {
    if (y == null) {
      return '$esc${x + 1}G';
    }
    return '$esc${y + 1};${x + 1}H';
  }

  /// Set the position of the cursor relative to its current position.
  String cursorMove(int x, int y) {
    if (x.runtimeType != int) {
      throw TypeException('The `x` argument is required');
    }

    var returnValue = '';

    if (x < 0) {
      returnValue += '$esc${-x}D';
    } else if (x > 0) {
      returnValue += '$esc${x}C';
    }

    if (y < 0) {
      returnValue += '$esc${-y}A';
    } else if (y > 0) {
      returnValue += '$esc${y}B';
    }
    return returnValue;
  }

  /// Move cursor up a specific amount of rows. Default `count`` value is 1.
  String cursorUp([int count = 1]) => '$esc${count}A';

  /// Move cursor down a specific amount of rows. Default `count` value is 1.
  String cursorDown([int count = 1]) => '$esc${count}B';

  /// Move cursor forward a specific amount of columns. Default `count` is 1.
  String cursorForward([int count = 1]) => '$esc${count}C';

  /// Move cursor backward a specific amount of columns. Default `count` is 1.
  String cursorBackward([int count = 1]) => '$esc${count}D';

  /// [cursorLeft] Move cursor to the left side.
  String cursorLeft = '${esc}G';

  /// [cursorGetPosition] Get cursor position.
  String cursorGetPosition = '${esc}6n';

  /// [cursorNextLine] Move cursor to the next line.
  String cursorNextLine = '${esc}E';

  /// [cursorPrevLine] Move cursor to the previous line.
  String cursorPrevLine = '${esc}F';

  /// [cursorHide] Hide cursor.
  String cursorHide = '$esc?25l';

  /// [cursorShow] Show cursor.
  String cursorShow = '$esc?25h';

  /// [eraseEndLine] Erase from the current
  /// cursor position to the end of the current line.
  String eraseEndLine = '${esc}K';

  /// [eraseStartLine] Erase from the current
  /// cursor position to the start of the current line.
  String eraseStartLine = '${esc}1K';

  /// [eraseLine] E1rase the entire current line.
  String eraseLine = '${esc}2K';

  /// [eraseDown] Erase the screen from the current
  /// line down to the bottom of the screen.
  String eraseDown = '${esc}J';

  /// [eraseUp] Erase the screen from the current
  /// line up to the top of the screen.
  String eraseUp = '${esc}1J';

  /// [eraseScreen] Erase the screen and move the cursor the top left position.
  String eraseScreen = '${esc}2J';

  /// [scrollUp] Scroll display up one line.
  String scrollUp = '${esc}S';

  /// [scrollDown] Scroll display down one line.
  String scrollDown = '${esc}T';

  /// [clearScreen] Clear the terminal screen. (Viewport)
  String clearScreen = '\u001Bc';

  /// Erase from the current cursor position up the specified amount of rows `count`.
  String eraseLines(int count) {
    var clear = '';

    for (var i = 0; i < count; i++) {
      clear += eraseLine + (i < count - 1 ? cursorUp() : '');
    }

    clear += cursorLeft;
    return clear;
  }

  /// Clear the whole terminal, including scroll back buffer. (Not just the visible part of it)
  String get clearTerminal => Platform.isWindows
      ? '$eraseScreen${esc}0f'
      :
      // 1. Erases the screen (Only done in case `2` is not supported)
      // 2. Erases the whole screen including scroll back buffer
      // 3. Moves cursor to the top-left position
      // More info: https://www.real-world-systems.com/docs/ANSIcode.html
      '$eraseScreen${esc}3J${esc}H';

  /// [beep] Output a beeping sound.
  String beep = bel;

  /// [link] Create a clickable link.
  /// Only supported in selected terminals
  String link(String url, String text) {
    return [
      osc,
      '8',
      sep,
      sep,
      url,
      bel,
      text,
      osc,
      '8',
      sep,
      sep,
      bel,
    ].join('');
  }

  /// Display an image.
  String image(
    Uint8List filePathInBytes, {
    int? width,
    int? height,
    bool? preserveAspectRatio,
  }) {
    var returnValue = '${osc}1337;File=inline=1';

    if (width != null) {
      returnValue += ';width=$width';
    }

    if (height != null) {
      returnValue += ';height=$height';
    }

    if (preserveAspectRatio == false) {
      returnValue += ';preserveAspectRatio=0';
    }

    return '$returnValue:${base64Encode(filePathInBytes)}$bel';
  }
}

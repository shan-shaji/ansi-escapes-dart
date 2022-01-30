# ansi-escapes

> [ANSI escape codes]() for manipulating the terminal

## Install

```
$ dart pub add ansi_escapes

```

## Usage

```dart
import 'package:ansi_escapes/ansi_escapes.dart';

// Moves the cursor two rows up and to the left
stdout.write(ansiEscapes.cursorUp(2) + ansiEscapes.cursorLeft);
//=> '\u001B[2A\u001B[1000D'

```

## API

### cursorTo(x, y)

Set the absolute position of the cursor. `x0` `y0` is the top left of the screen.

### cursorMove(x, y)

Set the position of the cursor relative to its current position.

### cursorUp(count)

Move cursor up a specific amount of rows. Default is `1`.

### cursorDown(count)

Move cursor down a specific amount of rows. Default is `1`.

### cursorForward(count)

Move cursor forward a specific amount of columns. Default is `1`.

### cursorBackward(count)

Move cursor backward a specific amount of columns. Default is `1`.

### cursorLeft

Move cursor to the left side.

### cursorSavePosition

Save cursor position.

### cursorRestorePosition

Restore saved cursor position.

### cursorGetPosition

Get cursor position.

### cursorNextLine

Move cursor to the next line.

### cursorPrevLine

Move cursor to the previous line.

### cursorHide

Hide cursor.

### cursorShow

Show cursor.

### eraseLines(count)

Erase from the current cursor position up the specified amount of rows.

### eraseEndLine

Erase from the current cursor position to the end of the current line.

### eraseStartLine

Erase from the current cursor position to the start of the current line.

### eraseLine

Erase the entire current line.

### eraseDown

Erase the screen from the current line down to the bottom of the screen.

### eraseUp

Erase the screen from the current line up to the top of the screen.

### eraseScreen

Erase the screen and move the cursor the top left position.

### scrollUp

Scroll display up one line.

### scrollDown

Scroll display down one line.

### clearScreen

Clear the terminal screen. (Viewport)

### clearTerminal

Clear the whole terminal, including scrollback buffer. (Not just the visible part of it)

### beep

Output a beeping sound.

### link(text, url)

Create a clickable link.

[Supported terminals.](https://gist.github.com/egmontkob/eb114294efbcd5adb1944c9f3cb5feda) 


Inspired from [Sindre Sorhus](https://github.com/sindresorhus) of  [ansi-escapes](https://www.npmjs.com/package/ansi-escapes) package .


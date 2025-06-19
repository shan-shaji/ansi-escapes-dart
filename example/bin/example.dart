import 'dart:io';
import 'package:ansi_escapes/ansi_escapes.dart';

void main() async {
  // Clear the screen
  stdout.write(ansiEscapes.clearScreen);

  // Move cursor to line 5, column 10
  stdout.write(ansiEscapes.cursorTo(10, 5));

  // Print some text at the new location
  print('Hello from ansi_escapes!');

  // Wait a moment and then erase 2 lines
  Future.delayed(Duration(seconds: 2), () {
    stdout.write(ansiEscapes.eraseLines(2));
  });

  // Hide the cursor for dramatic effect
  stdout.write(ansiEscapes.cursorHide);

  // Wait 4 seconds and then show the cursor again
  Future.delayed(Duration(seconds: 4), () {
    stdout.write(ansiEscapes.cursorShow);
  });

  final bytesFile = await File('assets/hello_terminal.png').readAsBytes();
  stdout.write(ansiEscapes.image(bytesFile));
}

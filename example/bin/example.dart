import 'dart:io';
import 'package:ansi_escapes/ansi_escapes.dart';

void main(List<String> arguments) {
  stdout.write(ansiEscapes.link('https://github.com', 'github'));
}

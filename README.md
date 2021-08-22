<p align="center">
	<a href="#"><img src="https://i.imgur.com/82fSz51.png" width="900px" /></a>
	<p align="center"><b>Style your terminal strings🎨</b>  </p>
</p>

----

This is a feature clone of the awesome [Chalk](https://github.com/chalk/chalk) (JavaScript) library.

All credits go to [Sindre Sorhus](https://github.com/sindresorhus).

[![Build Status](https://www.travis-ci.com/shan-shaji/chalkdart.svg?branch=main)](https://www.travis-ci.com/shan-shaji/chalkdart)

<img src='https://raw.githubusercontent.com/shan-shaji/chalkdart/main/screenshot.PNG'>

## Highlights

- Expressive API
- Highly performant
- Ability to nest styles
- Clean and focused

## Install

With dart:

```dart
$ dart pub add chalk
```
With Flutter:

```dart
$ flutter pub add chalk
```
Chalk comes with an easy to use API where you just chain the styles you want.

```dart
  var ch = Chalk();

  // Specify font face by using [ftFace] property
  print(ch.blue('blue text', ftFace: ChalkFtFace.italic));
  print(ch.red('red Text', ftFace: ChalkFtFace.bold));

  // Chain styles
  print(ch.faint('faint text').blue());
  print(ch.cyan('cyan').bold());

  // Not widely supported
  print(ch.yellow('yellow').underLined());
  print(ch.yellow('yellow').strikeThrough());

  // Combine styled and normal strings
  print('chain text'.green() + ' Normal Text ' + 'chain text2'.red());
  print('\n');
```





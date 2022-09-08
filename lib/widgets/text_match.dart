import 'package:flutter/material.dart';

/// Виджет для выделения текста по совпадению(в автокомплите например)
class TextMatch extends StatelessWidget {
  final String searchString;
  final String content;
  final TextStyle? style;
  final TextStyle? matchStyle;

  const TextMatch({
    Key? key,
    required this.searchString,
    required this.content,
    this.style,
    this.matchStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final matches = searchString.isEmpty
        ? <RegExpMatch>[]
        : RegExp(searchString.toLowerCase())
            .allMatches(content.toLowerCase())
            .toList();
    final parts = <InlineSpan>[];
    if (matches.isEmpty) {
      parts.add(TextSpan(text: content));
    } else {
      var i = 0;
      var matchIndex = 0;
      while (true) {
        if (matchIndex >= matches.length) {
          final end = content.substring(matches.last.end);
          if (end.isNotEmpty) {
            parts.add(TextSpan(
                text: content.substring(matches.last.end), style: style));
          }
          break;
        }
        final match = matches[matchIndex];
        if (match.start > i) {
          final slice = content.substring(i, match.start);
          parts.add(TextSpan(text: slice, style: style));
          i = match.start;
          continue;
        }
        final slice = content.substring(match.start, match.end);
        parts.add(TextSpan(
          text: slice,
          style: matchStyle,
        ));
        matchIndex += 1;
        i = match.end;
      }
    }

    return Text.rich(
      TextSpan(
        children: parts,
      ),
    );
  }
}

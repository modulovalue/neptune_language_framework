import 'lexer.dart';

enum MatchingStatus {
  matched,
  nothingFound,
}

abstract class NeptuneTokenLiteral {
  LexerMatchResult parse(String str, int lastPositionTo);
}

/// Regex Troubleshooting:
///
/// - Each regex should start with a caret '^' to
///
/// - If you're trying to parse multiples of something like lalalala with [la]+
///   then don't forget to use the + and not the * to not match zero characters
///
class RegexToken implements NeptuneTokenLiteral {
  final String regex;

  const RegexToken(this.regex);

  @override
  LexerMatchResult parse(String str, int lastPositionTo) {
    MatchingStatus status;
    String matchedString;
    String leftString;

    assert(regex != null);
    assert(str != null);
    assert(str != "");

    final reg = RegExp(regex, multiLine: true);
    final o = reg.matchAsPrefix(str);
    if (o == null) {
      status = MatchingStatus.nothingFound;
      leftString = matchedString;
    } else {
      status = MatchingStatus.matched;
      matchedString = o.group(0);
      leftString = str.replaceFirst(matchedString, "");
      if (leftString == "") {
        leftString = null;
      }
    }

    return LexerMatchResult(
        matchedString: matchedString,
        status: status,
        token: this,
        positionFrom: lastPositionTo ?? 0,
        left: leftString);
  }

  @override
  String toString() => "'" + regex + "'";
}

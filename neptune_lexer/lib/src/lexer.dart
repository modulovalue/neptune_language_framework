
import 'package:meta/meta.dart';

import 'matcher.dart';

abstract class LexerResponse {
  final String shortDescription;

  const LexerResponse(this.shortDescription);

  @override
  String toString() {
    return "${runtimeType.toString()}: ${shortDescription.toString()}";
  }
}

class LexerResponseSuccessful extends LexerResponse {
  const LexerResponseSuccessful() : super("success");
}

class LexerResponseUnknownError extends LexerResponse {
  const LexerResponseUnknownError(String description) : super(description);
}

class LexerResponseUnknownToken extends LexerResponse {
  const LexerResponseUnknownToken(String description) : super(description);
}

class LexerExecutionInfo {
  final Duration durationToExecute;

  const LexerExecutionInfo({@required this.durationToExecute});
}

class LexerResult {
  final List<LexerMatchResult> successfulResult;
  final LexerResponse respone;
  final LexerExecutionInfo executionInfo;

  const LexerResult({
    @required this.successfulResult,
    @required this.respone,
    @required this.executionInfo,
  });
}

abstract class Lexer {
  String delimiter();

  List<String> dontRemoveDelimiterInThisRegex() => [];

  /// Be careful of the order
  /// if a literal can consume another literal and it's higher up the list then the other will be ignored
  List<NeptuneTokenLiteral> literals();

  LexerResult lex(String code) {
    return collectMatches(
      splitWithDelimiter(code, delimiter(), dontRemoveDelimiterInThisRegex()),
      literals(),
      delimiter(),
    );
  }

  static List<String> splitWithDelimiter(String string, String delimiter,
      List<String> dontRemoveDelimiterInThisRegex) {
    String regex;

    /// Create regex for ""context sensitive"" splitting
    if (dontRemoveDelimiterInThisRegex.isEmpty) {
      regex = delimiter;
    } else {
      // [^\s"']+|
      regex = "($delimiter)"
          r'|'
          '${dontRemoveDelimiterInThisRegex.join("|")}';
    }

    /// Split off delimiters and ""context sensitive"" strings
    final a = RegExp(regex, multiLine: true);
    final b = a.allMatches(string);
    final c = b.map((Match match) {
      return match
          .groups(List.generate(match.groupCount, (i) {
        return i;
      }))
          .map((String f) {
        return f;
      }).toList();
    }).toList();

    /// concat delimiters and ""context sens. strings"" back to the end of found tokens
    final List<String> splitRaw = string.split(RegExp(regex, multiLine: true));
    final List<String> split = List<String>.from(splitRaw);
//        List<String> splitToInsert = List<String>.from(splitRaw, growable: true);
    int insertOffset = 0;

    c.asMap().forEach((int i, List<String> str) {
      if (str.isNotEmpty) {
        split.insert(i + insertOffset + 1, str[0]);
        insertOffset += 1;
      }
    });

    split.removeWhere((t) => t == "");
    return split;
  }

  static LexerResult collectMatches(List<String> split,
      List<NeptuneTokenLiteral> literals, String delimiter) {
    final Stopwatch stopwatch = Stopwatch()..start();
    int leftTrimSize = 0;
    while (RegExp(delimiter).matchAsPrefix(split.first) != null) {
      leftTrimSize += split.removeAt(0).length;
    }

    final List<LexerMatchResult> matches = [];
    LexerResponse lexerResponse;
    try {
      lexerResponse = createMatches(leftTrimSize, split, literals, (match) {
        matches.add(match);
      }, delimiter);
    } catch (e, f) {
      print(f);
      lexerResponse = LexerResponseUnknownError(
          "Unknown error :(, ${e.toString()} ${f.toString()}");
    }

    stopwatch.stop();
    return LexerResult(
      respone: lexerResponse ?? const LexerResponseSuccessful(),
      successfulResult: matches,
      executionInfo: LexerExecutionInfo(durationToExecute: stopwatch.elapsed),
    );
  }

  static LexerResponse createMatches(
      int leftPaddingRemovedPos,
      List<String> split,
      List<NeptuneTokenLiteral> literals,
      Function(LexerMatchResult) addMatch,
      String delimiter) {
    LexerResponse lastLexerResponse;
    for (final String rawToken in split) {
      final LexerMatchResult firstRun = _workMatches(
        literals,
        rawToken,
        leftPaddingRemovedPos,
      );

      final Match rawTokenDelimiterMatch =
          RegExp(delimiter).matchAsPrefix(rawToken);
      if (rawTokenDelimiterMatch == null) {
        final finishedRun =
            getMatchForRawToken(firstRun, addMatch, literals, delimiter);

        if (finishedRun.value is! LexerResponseSuccessful) {
          return finishedRun.value;
        } else {
          lastLexerResponse = finishedRun.value;
        }
        // ignore: parameter_assignments
        leftPaddingRemovedPos = finishedRun.key.positionTo;
      } else {
        lastLexerResponse = const LexerResponseSuccessful();
        // ignore: parameter_assignments
        leftPaddingRemovedPos += 1;
      }
    }
    return lastLexerResponse;
  }

  static LexerMatchResult _workMatches(
    List<NeptuneTokenLiteral> literals,
    String rawToken,
    int lastPositionTo,
  ) {
    for (final NeptuneTokenLiteral literal in literals) {
      final LexerMatchResult match = literal.parse(rawToken, lastPositionTo);
      if (match.status == MatchingStatus.matched) {
        return match;
      }
    }
    return null;
  }

  static MapEntry<LexerMatchResult, LexerResponse> getMatchForRawToken(
      LexerMatchResult singleRun,
      Function(LexerMatchResult) addMatch,
//        LexerMatchResult lastFoundMatch,
      List<NeptuneTokenLiteral> literals,
      String delimiter) {
    if (singleRun != null) {
      addMatch(singleRun);
      if (singleRun.left != null && singleRun.left != "") {
        final LexerMatchResult furtherRun = _workMatches(
          literals,
          singleRun.left,
          singleRun.positionTo,
        );

        if (furtherRun == null) {
//                    var xaddedPadToPrevious = singleRun.left.length;
//          singleRun.match..positionFrom;
//                    += addedPadToPrevious;
          return MapEntry(singleRun, const LexerResponseSuccessful());
        } else {
          if (furtherRun.matchedString == null) {
            if (furtherRun.left != null && furtherRun.left != "") {
              const MapEntry(null, LexerResponseUnknownToken("'obladi oblada"));
            }
            throw Exception("Unexpected error 13940");
          } else {
            return getMatchForRawToken(
                furtherRun, addMatch, literals, delimiter);
          }
        }
      } else {
        return MapEntry(singleRun, const LexerResponseSuccessful());
      }
    } else {
      return MapEntry(
          singleRun,
          const LexerResponseUnknownToken("'${""
//                lastFoundMatch?.toString()
              }' is not known, "
              "did you add the Literal to the lexer?"));
    }
  }
}

class LexerMatchResult {
  final MatchingStatus status;
  final NeptuneTokenLiteral token;
  final String matchedString;
  final int positionFrom;
  final String left;

  const LexerMatchResult({
    @required this.status,
    @required this.token,
    @required this.matchedString,
    @required this.positionFrom,
    @required this.left,
  });

  int get positionTo {
    if (matchedString?.length != null) {
      return positionFrom + (matchedString.length);
    } else {
      return positionFrom;
    }
  }

  @override
  String toString() =>
      'LexerMatchResult{status: $status, token: $token, matchedString: $matchedString, positionFrom: $positionFrom, left: $left}';
}

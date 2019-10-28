import '../../../neptune_language_framework.dart';

abstract class LexerResponse {
    String shortDescription;

    LexerResponse(this.shortDescription);

    @override
    String toString() {
        return "${runtimeType.toString()}: ${shortDescription.toString()}";
    }
}

class LexerResponseSuccessful extends LexerResponse {
    LexerResponseSuccessful() : super("success");
}

class LexerResponseUnknownError extends LexerResponse {
    LexerResponseUnknownError(String description) : super(description);
}

class LexerResponseUnknownToken extends LexerResponse {
    LexerResponseUnknownToken(String description) : super(description);
}

class LexerExecutionInfo {
    Duration durationToExecute;

    LexerExecutionInfo({@required this.durationToExecute});
}

class LexerResult {
    List<LexerMatchResult> successfulResult;
    LexerResponse respone;
    LexerExecutionInfo executionInfo;

    LexerResult({
        @required this.successfulResult,
        @required this.respone,
    });
}

abstract class Lexer extends Object with PrettyPrinterTemplate implements PrettyPrinter {

    String delimiter();

    List<String> dontRemoveDelimiterInThisRegex() {
        return [];
    }

    /// Be careful of the order
    /// if a literal can consume another literal and it's higher up the list then the other will be ignored
    List<NeptuneTokenLiteral> literals();

    LexerResult lex(String code) {
        final List<String> split = splitWithDelimiter(code, delimiter(), dontRemoveDelimiterInThisRegex());
//        assert (code == split.join(""));
        final Stopwatch stopwatch = Stopwatch()
            ..start();
        var result = collectMatches(split, literals(), delimiter());
        stopwatch.stop();
        result..executionInfo = LexerExecutionInfo(durationToExecute: stopwatch.elapsed);
        return result;
    }

    static List<String> splitWithDelimiter(String string, String delimiter,
        List<String> dontRemoveDelimiterInThisRegex) {
        String regex;


        /// Create regex for ""context sensitive"" splitting
        if (dontRemoveDelimiterInThisRegex.isEmpty) {
            regex = delimiter;
        } else { // [^\s"']+|
            regex = "($delimiter)"
            r'|''${dontRemoveDelimiterInThisRegex.join("|")}';
        }


        /// Split off delimiters and ""context sensitive"" strings
        var a = RegExp(regex, multiLine: true);
        var b = a.allMatches(string);
        var c = b.map((Match match) {
            return match.groups(List.generate(match.groupCount, (i) {
                return i;
            })).map((String f) {
                return f;
            }).toList();
        }).toList();


        /// concat delimiters and ""context sens. strings"" back to the end of found tokens
        List<String> splitRaw = string.split(RegExp(regex, multiLine: true));
        List<String> split = List<String>.from(splitRaw);
//        List<String> splitToInsert = List<String>.from(splitRaw, growable: true);
        int insertOffset = 0;

        c.asMap().forEach((int i, List<String> str) {
            if(str.isNotEmpty) {
                split.insert(i + insertOffset + 1, str[0]);
                insertOffset += 1;
            }
        });

        split.removeWhere((t) => t == "");
        return split;
    }

    static LexerResult collectMatches(List<String> split, List<NeptuneTokenLiteral> literals,
        String delimiter) {
        int leftTrimSize = 0;
        while (RegExp(delimiter).matchAsPrefix(split.first) != null) {
            leftTrimSize += split
                .removeAt(0)
                .length;
        }

        List<LexerMatchResult> matches = [];
        LexerResponse lexerResponse;
        try {
            lexerResponse = createMatches(
                leftTrimSize,
                split,
                literals,
                    (match) {
                    matches.add(match);
                }, delimiter);
        } catch (e, f) {
            print(f);
            lexerResponse = LexerResponseUnknownError("Unknown error :(, ${e.toString()} ${f.toString()}");
        }
        return LexerResult(
            respone: lexerResponse ?? LexerResponseSuccessful(),
            successfulResult: matches,
        );
    }

    static LexerResponse createMatches(int leftPaddingRemovedPos, List<String> split,
        List<NeptuneTokenLiteral> literals,
        Function(LexerMatchResult) addMatch, String delimiter) {
        LexerResponse lastLexerResponse;
        for (String rawToken in split) {
            LexerRunResult firstRun = _workMatches(
                literals,
                rawToken,
                leftPaddingRemovedPos,
            );

            Match rawTokenDelimiterMatch = RegExp(delimiter).matchAsPrefix(rawToken);
            if (rawTokenDelimiterMatch == null) {
                var finishedRun = getMatchForRawToken(
                    firstRun,
                    addMatch,
                    literals,
                    delimiter);

                if (finishedRun.value is! LexerResponseSuccessful) {
                    return finishedRun.value;
                } else {
                    lastLexerResponse = finishedRun.value;
                }
                leftPaddingRemovedPos = finishedRun.key.positionTo;
            } else {
                lastLexerResponse = LexerResponseSuccessful();
                leftPaddingRemovedPos += 1;
            }
        }
        return lastLexerResponse;
    }

    static LexerRunResult _workMatches(List<NeptuneTokenLiteral> literals,
        String rawToken,
        int lastPositionTo,) {
        for (NeptuneTokenLiteral literal in literals) {
            LexerRunResult match = literal.parse(rawToken, lastPositionTo);
            if (match.match.status == MatchingStatus.matched) {
                return match;
            }
        }
        return null;
    }

    static MapEntry<LexerMatchResult, LexerResponse> getMatchForRawToken(LexerRunResult singleRun,
        Function(LexerMatchResult) addMatch,
//        LexerMatchResult lastFoundMatch,
        List<NeptuneTokenLiteral> literals, String delimiter) {
        if (singleRun != null) {
            addMatch(singleRun.match);
            if (singleRun.left != null && singleRun.left != "") {
                LexerRunResult furtherRun = _workMatches(
                    literals,
                    singleRun.left,
                    singleRun.match.positionTo,
                );

                if (furtherRun == null) {
//                    var xaddedPadToPrevious = singleRun.left.length;
                    singleRun.match
                        ..positionFrom;
//                    += addedPadToPrevious;
                    return MapEntry(singleRun.match, LexerResponseSuccessful());
                } else {
                    if (furtherRun.match.matchedString == null) {
                        if (furtherRun.left != null && furtherRun.left != "") {
                            MapEntry(
                                null, LexerResponseUnknownToken("'obladi oblada"));
                        }
                        throw "Unexpected error 13940";
                    } else {
                        return getMatchForRawToken(furtherRun, addMatch,
                            literals
                            , delimiter);
                    }
                }
            } else {
                return MapEntry(singleRun.match, LexerResponseSuccessful());
            }
        } else {
            return MapEntry(
                singleRun?.match, LexerResponseUnknownToken("'${""
//                lastFoundMatch?.toString()
            }' is not known, "
                "did you add the Literal to the lexer?"));
        }
    }

    @override
    void prettyPrint({LexerPrinter printer = const SimpleLexerPrinter()}) {
        printer.prettyPrint(this);
    }
}

class LexerMatchResult {

    MatchingStatus status;
    NeptuneTokenLiteral token;
    String matchedString;
    int positionFrom;

    LexerMatchResult({
        @required this.status,
        @required this.token,
        @required this.matchedString,
        @required this.positionFrom,
    });

    int get positionTo {
        if (matchedString?.length != null) {
            return positionFrom + (matchedString.length);
        } else {
            return positionFrom;
        }
    }

    @override
    String toString() {
        return "'$matchedString' $positionFrom $positionTo";
    }
}

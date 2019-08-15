import '../../../neptune_language_framework.dart';

enum MatchingStatus {
    matched,
    nothingFound,
}

abstract class Matcher {
    LexerRunResult match(String str, NeptuneTokenLiteral token, int lastPositionTo);

    @override
    String toString();
}

class LexerRunResult {
    LexerMatchResult match;
    String left;

    LexerRunResult(this.match, this.left);
}

class RegexMatcher extends Matcher {

    String regex;

    RegexMatcher({@required this.regex});

    @override
    LexerRunResult match(String str, NeptuneTokenLiteral token, int lastPositionTo) {
        MatchingStatus status;
        String matchedString;
        String leftString;

        assert(regex != null);
        assert(str != null);
        assert(str != "");

        var reg = new RegExp(regex, multiLine: true);
        Match o = reg.matchAsPrefix(str);
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

        return new LexerRunResult(
            new LexerMatchResult(
                matchedString: matchedString,
                status: status,
                token: token,
                positionFrom: lastPositionTo == null ? 0 : lastPositionTo,
            ),
            leftString,
        );
    }

    @override
    String toString() {
        return "'" + regex + "'";
    }
}

abstract class NeptuneTokenLiteral {

    Matcher matcher();

    LexerRunResult parse(String str, int lastPositionTo) {
        return matcher().match(str, this, lastPositionTo);
    }

    @override
    String toString() {
        return matcher().toString();
    }
}

class RegexLiteral extends NeptuneTokenLiteral {

    RegexLiteral(this.regex);

    String regex;

    @override
    Matcher matcher() {
        return new RegexMatcher(regex: regex);
    }
}
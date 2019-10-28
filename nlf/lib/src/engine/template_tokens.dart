import '../../neptune_language_framework.dart';

/// Regex Troubleshooting:
///
/// - Each regex should start with a caret '^' to
///
/// - If you're trying to parse multiples of something like lalalala with [la]+
///   then don't forget to use the + and not the * to not match zero characters
///


/// Keywords
///
///
///
///
///

class ReturnTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^return");
}

Rule returnn = LiteralNode(ReturnTokenLiteral());

class WhileTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^while");
}

Rule whilee = LiteralNode(WhileTokenLiteral());

class AndTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^and");
}

Rule andWord = LiteralNode(AndTokenLiteral());

class ThenTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^then");
}

Rule thenWord = LiteralNode(ThenTokenLiteral());


class NullTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^null");
}

Rule nullWord = LiteralNode(NullTokenLiteral());


class TrueBoolTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^true");
}

Rule trueBoolWord = LiteralNode(TrueBoolTokenLiteral());

class FalseBoolTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^false");
}

Rule falseBoolWord = LiteralNode(FalseBoolTokenLiteral());


class TextTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[a-zA-Z]+");
}

Rule textTokenLiteral = LiteralNode(TextTokenLiteral());

/// Math symbols
///
///
///
///
///

class AddSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[+]");
}

Rule addSymTokenLiteral = LiteralNode(AddSymTokenLiteral());

class EqualsTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[=]");
}

Rule equals = LiteralNode(EqualsTokenLiteral());

class CommaSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[,]");
}

Rule commaSymTokenLiteral = LiteralNode(CommaSymTokenLiteral());

class MinusSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[-]");
}

Rule minusSymTokenLiteral = LiteralNode(MinusSymTokenLiteral());

class MulSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[*]");
}

Rule mulSymTokenLiteral = LiteralNode(MulSymTokenLiteral());


class DivSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[/]");
}

Rule divSymTokenLiteral = LiteralNode(DivSymTokenLiteral());


class LessSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[<]");
}

Rule lessSymTokenLiteral = LiteralNode(LessSymTokenLiteral());


class BiggerSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[>]");
}

Rule biggerSymTokenLiteral = LiteralNode(BiggerSymTokenLiteral());

/// Number Types
///
///
///
///
///
class IntTypeTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^int");
}

Rule intType = LiteralNode(IntTypeTokenLiteral());


class StringTypeTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^String");
}

Rule stringType = LiteralNode(StringTypeTokenLiteral());


/// Number literals
///
///
///
///
///

class IntTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^\d+");
}

Rule intTokenLiteral = LiteralNode(IntTokenLiteral());

class JsonNumberTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?");
}

Rule jsonNumberTokenLiteral = LiteralNode(JsonNumberTokenLiteral());

class StringWith2QuotesTokenLiteral extends NeptuneTokenLiteral {

    static final String regex = '("([^"]*)")|(\'([^\']*)\')';

    @override
    Matcher matcher() => RegexMatcher(regex: "^$regex");
}

Rule stringW2QTokenLiteral = LiteralNode(StringWith2QuotesTokenLiteral());

/// TODO check this literal, unicode support might be missing
class JSONStringTokenLiteral extends NeptuneTokenLiteral {
    /// "([^\\"]|\\")*"
    static final String regex = r'"([^\\"]|\\|\\")*"';

    @override
    Matcher matcher() => RegexMatcher(regex: "^$regex");
}

Rule jsonStringTokenLiteral = LiteralNode(JSONStringTokenLiteral());

class PositiveNumberTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[+]?([.]\d+|\d+[.]?\d*)");
}

Rule positiveNumberTokenLiteral = LiteralNode(PositiveNumberTokenLiteral());


class SpacesLineTokenLiteral extends NeptuneTokenLiteral {
    static String regex = r"(\f|\n|\r|\t|\v|\r\n| | )";

    @override
    Matcher matcher() => RegexMatcher(regex: "^$regex");
}

Rule spacesLineTokenLiteral = LiteralNode(SpacesLineTokenLiteral());

/// Braces
///
///
///
///
///

class LeftParanTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[(]");
}

Rule leftParan = LiteralNode(LeftParanTokenLiteral());

class RightParanTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[)]");
}

Rule rightParan = LiteralNode(RightParanTokenLiteral());

class LeftCurlyTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[{]");
}

Rule leftCurly = LiteralNode(LeftCurlyTokenLiteral());


class RightCurlyTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[}]");
}

Rule rightCurly = LiteralNode(RightCurlyTokenLiteral());


class LeftBracketTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[[]");
}

Rule leftBracket = LiteralNode(LeftBracketTokenLiteral());


class RightBracketTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[\]]");
}

Rule rightBracket = LiteralNode(RightBracketTokenLiteral());

/// Other
///
///
///
///
///

class SemicolonTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[;]");
}

Rule semicolon = LiteralNode(SemicolonTokenLiteral());


class ColonTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^[:]");
}

Rule colon = LiteralNode(ColonTokenLiteral());

/// Fun
///
///
///
///
///

class ChickenEmojiTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^☺️");
}

Rule chickenEmojiLiteral = LiteralNode(ChickenEmojiTokenLiteral());
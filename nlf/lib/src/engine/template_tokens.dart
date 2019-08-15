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
    Matcher matcher() => new RegexMatcher(regex: r"^return");
}

Rule returnn = new LiteralNode(new ReturnTokenLiteral());

class WhileTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^while");
}

Rule whilee = new LiteralNode(new WhileTokenLiteral());

class AndTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^and");
}

Rule andWord = new LiteralNode(new AndTokenLiteral());

class ThenTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^then");
}

Rule thenWord = new LiteralNode(new ThenTokenLiteral());


class NullTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^null");
}

Rule nullWord = new LiteralNode(new NullTokenLiteral());


class TrueBoolTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^true");
}

Rule trueBoolWord = new LiteralNode(new TrueBoolTokenLiteral());

class FalseBoolTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^false");
}

Rule falseBoolWord = new LiteralNode(new FalseBoolTokenLiteral());


class TextTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[a-zA-Z]+");
}

Rule textTokenLiteral = new LiteralNode(new TextTokenLiteral());

/// Math symbols
///
///
///
///
///

class AddSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[+]");
}

Rule addSymTokenLiteral = new LiteralNode(new AddSymTokenLiteral());

class EqualsTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[=]");
}

Rule equals = new LiteralNode(new EqualsTokenLiteral());

class CommaSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[,]");
}

Rule commaSymTokenLiteral = new LiteralNode(new CommaSymTokenLiteral());

class MinusSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[-]");
}

Rule minusSymTokenLiteral = new LiteralNode(new MinusSymTokenLiteral());

class MulSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[*]");
}

Rule mulSymTokenLiteral = new LiteralNode(new MulSymTokenLiteral());


class DivSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[/]");
}

Rule divSymTokenLiteral = new LiteralNode(new DivSymTokenLiteral());


class LessSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[<]");
}

Rule lessSymTokenLiteral = new LiteralNode(new LessSymTokenLiteral());


class BiggerSymTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[>]");
}

Rule biggerSymTokenLiteral = new LiteralNode(new BiggerSymTokenLiteral());

/// Number Types
///
///
///
///
///
class IntTypeTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^int");
}

Rule intType = new LiteralNode(new IntTypeTokenLiteral());


class StringTypeTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^String");
}

Rule stringType = new LiteralNode(new StringTypeTokenLiteral());


/// Number literals
///
///
///
///
///

class IntTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^\d+");
}

Rule intTokenLiteral = new LiteralNode(new IntTokenLiteral());

class JsonNumberTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?");
}

Rule jsonNumberTokenLiteral = new LiteralNode(new JsonNumberTokenLiteral());

class StringWith2QuotesTokenLiteral extends NeptuneTokenLiteral {

    static final String regex = '("([^"]*)")|(\'([^\']*)\')';

    @override
    Matcher matcher() => new RegexMatcher(regex: "^$regex");
}

Rule stringW2QTokenLiteral = new LiteralNode(new StringWith2QuotesTokenLiteral());

/// TODO check this literal, unicode support might be missing
class JSONStringTokenLiteral extends NeptuneTokenLiteral {
    /// "([^\\"]|\\")*"
    static final String regex = r'"([^\\"]|\\|\\")*"';

    @override
    Matcher matcher() => new RegexMatcher(regex: "^$regex");
}

Rule jsonStringTokenLiteral = new LiteralNode(new JSONStringTokenLiteral());

class PositiveNumberTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[+]?([.]\d+|\d+[.]?\d*)");
}

Rule positiveNumberTokenLiteral = new LiteralNode(new PositiveNumberTokenLiteral());


class SpacesLineTokenLiteral extends NeptuneTokenLiteral {
    static String regex = r"(\f|\n|\r|\t|\v|\r\n| | )";

    @override
    Matcher matcher() => new RegexMatcher(regex: "^$regex");
}

Rule spacesLineTokenLiteral = new LiteralNode(new SpacesLineTokenLiteral());

/// Braces
///
///
///
///
///

class LeftParanTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[(]");
}

Rule leftParan = new LiteralNode(new LeftParanTokenLiteral());

class RightParanTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[)]");
}

Rule rightParan = new LiteralNode(new RightParanTokenLiteral());

class LeftCurlyTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[{]");
}

Rule leftCurly = new LiteralNode(new LeftCurlyTokenLiteral());


class RightCurlyTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[}]");
}

Rule rightCurly = new LiteralNode(new RightCurlyTokenLiteral());


class LeftBracketTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[[]");
}

Rule leftBracket = new LiteralNode(new LeftBracketTokenLiteral());


class RightBracketTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[\]]");
}

Rule rightBracket = new LiteralNode(new RightBracketTokenLiteral());

/// Other
///
///
///
///
///

class SemicolonTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[;]");
}

Rule semicolon = new LiteralNode(new SemicolonTokenLiteral());


class ColonTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[:]");
}

Rule colon = new LiteralNode(new ColonTokenLiteral());

/// Fun
///
///
///
///
///

class ChickenEmojiTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^☺️");
}

Rule chickenEmojiLiteral = new LiteralNode(new ChickenEmojiTokenLiteral());
import '../../neptune_language_framework.dart';

/// Regex Troubleshooting:
///
/// - Each regex should start with a caret '^' to
///
/// - If you're trying to parse multiples of something like lalalala with [la]+
///   then don't forget to use the + and not the * to not match zero characters
///

/// Keywords

class ReturnTokenLiteral extends RegexToken {
  const ReturnTokenLiteral() : super(r"^return");
}

const Rule returnn = LiteralNode(ReturnTokenLiteral());

class WhileTokenLiteral extends RegexToken {
  const WhileTokenLiteral() : super(r"^while");
}

const Rule whilee = LiteralNode(WhileTokenLiteral());

class AndTokenLiteral extends RegexToken {
  const AndTokenLiteral() : super(r"^and");
}

const Rule andWord = LiteralNode(AndTokenLiteral());

class ThenTokenLiteral extends RegexToken {
  const ThenTokenLiteral() : super(r"^then");
}

const Rule thenWord = LiteralNode(ThenTokenLiteral());

class NullTokenLiteral extends RegexToken {
  const NullTokenLiteral() : super(r"^null");
}

const Rule nullWord = LiteralNode(NullTokenLiteral());

class TrueBoolTokenLiteral extends RegexToken {
  const TrueBoolTokenLiteral() : super(r"^true");
}

const Rule trueBoolWord = LiteralNode(TrueBoolTokenLiteral());

class FalseBoolTokenLiteral extends RegexToken {
  const FalseBoolTokenLiteral() : super(r"^false");
}

const Rule falseBoolWord = LiteralNode(FalseBoolTokenLiteral());

class TextTokenLiteral extends RegexToken {
  const TextTokenLiteral() : super(r"^[a-zA-Z]+");
}

const Rule textTokenLiteral = LiteralNode(TextTokenLiteral());

/// Math symbols

class AddSymTokenLiteral extends RegexToken {
  const AddSymTokenLiteral() : super(r"^[+]");
}

const Rule addSymTokenLiteral = LiteralNode(AddSymTokenLiteral());

class EqualsTokenLiteral extends RegexToken {
  const EqualsTokenLiteral() : super(r"^[=]");
}

const Rule equals = LiteralNode(EqualsTokenLiteral());

class CommaSymTokenLiteral extends RegexToken {
  const CommaSymTokenLiteral() : super(r"^[,]");
}

const Rule commaSymTokenLiteral = LiteralNode(CommaSymTokenLiteral());

class MinusSymTokenLiteral extends RegexToken {
  const MinusSymTokenLiteral() : super(r"^[-]");
}

const Rule minusSymTokenLiteral = LiteralNode(MinusSymTokenLiteral());

class MulSymTokenLiteral extends RegexToken {
  const MulSymTokenLiteral() : super(r"^[*]");
}

const Rule mulSymTokenLiteral = LiteralNode(MulSymTokenLiteral());

class DivSymTokenLiteral extends RegexToken {
  const DivSymTokenLiteral() : super(r"^[/]");
}

const Rule divSymTokenLiteral = LiteralNode(DivSymTokenLiteral());

class LessSymTokenLiteral extends RegexToken {
  const LessSymTokenLiteral() : super(r"^[<]");
}

const Rule lessSymTokenLiteral = LiteralNode(LessSymTokenLiteral());

class BiggerSymTokenLiteral extends RegexToken {
  const BiggerSymTokenLiteral() : super(r"^[>]");
}

const Rule biggerSymTokenLiteral = LiteralNode(BiggerSymTokenLiteral());

/// Number Types

class IntTypeTokenLiteral extends RegexToken {
  const IntTypeTokenLiteral() : super(r"^int");
}

const Rule intType = LiteralNode(IntTypeTokenLiteral());

class StringTypeTokenLiteral extends RegexToken {
  const StringTypeTokenLiteral() : super(r"^String");
}

const Rule stringType = LiteralNode(StringTypeTokenLiteral());

/// Number literals

class IntTokenLiteral extends RegexToken {
  const IntTokenLiteral() : super(r"^\d+");
}

const Rule intTokenLiteral = LiteralNode(IntTokenLiteral());

class JsonNumberTokenLiteral extends RegexToken {
  const JsonNumberTokenLiteral()
      : super(r"^-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?");
}

const Rule jsonNumberTokenLiteral = LiteralNode(JsonNumberTokenLiteral());

class StringWith2QuotesTokenLiteral extends RegexToken {
  static const String regexx = '("([^"]*)")|(\'([^\']*)\')';

  const StringWith2QuotesTokenLiteral() : super("^$regexx");
}

const Rule stringW2QTokenLiteral = LiteralNode(StringWith2QuotesTokenLiteral());

/// TODO check this literal, unicode support might be missing
class JSONStringTokenLiteral extends RegexToken {
  /// "([^\\"]|\\")*"
  static const String regexx = r'"([^\\"]|\\|\\")*"';

  const JSONStringTokenLiteral() : super("^$regexx");
}

const Rule jsonStringTokenLiteral = LiteralNode(JSONStringTokenLiteral());

class PositiveNumberTokenLiteral extends RegexToken {
  const PositiveNumberTokenLiteral() : super(r"^[+]?([.]\d+|\d+[.]?\d*)");
}

const Rule positiveNumberTokenLiteral =
    LiteralNode(PositiveNumberTokenLiteral());

class SpacesLineTokenLiteral extends RegexToken {
  static const String regexx = r"(\f|\n|\r|\t|\v|\r\n| | )";

  const SpacesLineTokenLiteral() : super("^$regexx");
}

const Rule spacesLineTokenLiteral = LiteralNode(SpacesLineTokenLiteral());

/// Braces

class LeftParanTokenLiteral extends RegexToken {
  const LeftParanTokenLiteral() : super(r"^[(]");
}

const Rule leftParan = LiteralNode(LeftParanTokenLiteral());

class RightParanTokenLiteral extends RegexToken {
  const RightParanTokenLiteral() : super(r"^[)]");
}

const Rule rightParan = LiteralNode(RightParanTokenLiteral());

class LeftCurlyTokenLiteral extends RegexToken {
  const LeftCurlyTokenLiteral() : super(r"^[{]");
}

const Rule leftCurly = LiteralNode(LeftCurlyTokenLiteral());

class RightCurlyTokenLiteral extends RegexToken {
  const RightCurlyTokenLiteral() : super(r"^[}]");
}

const Rule rightCurly = LiteralNode(RightCurlyTokenLiteral());

class LeftBracketTokenLiteral extends RegexToken {
  const LeftBracketTokenLiteral() : super(r"^[[]");
}

const Rule leftBracket = LiteralNode(LeftBracketTokenLiteral());

class RightBracketTokenLiteral extends RegexToken {
  const RightBracketTokenLiteral() : super(r"^[\]]");
}

const Rule rightBracket = LiteralNode(RightBracketTokenLiteral());

/// Other

class SemicolonTokenLiteral extends RegexToken {
  const SemicolonTokenLiteral() : super(r"^[;]");
}

const Rule semicolon = LiteralNode(SemicolonTokenLiteral());

class ColonTokenLiteral extends RegexToken {
  const ColonTokenLiteral() : super(r"^[:]");
}

const Rule colon = LiteralNode(ColonTokenLiteral());

/// Fun
///
///
///
///
///

class ChickenEmojiTokenLiteral extends RegexToken {
  const ChickenEmojiTokenLiteral() : super(r"^☺️");
}

const Rule emojiLiteral = LiteralNode(ChickenEmojiTokenLiteral());

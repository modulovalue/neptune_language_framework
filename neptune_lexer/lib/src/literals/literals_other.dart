import '../../neptune_lexer.dart';

class SemicolonTokenLiteral extends RegexToken {
  const SemicolonTokenLiteral() : super(r"^[;]");
}

class ColonTokenLiteral extends RegexToken {
  const ColonTokenLiteral() : super(r"^[:]");
}

class ChickenEmojiTokenLiteral extends RegexToken {
  const ChickenEmojiTokenLiteral() : super(r"^☺️");
}

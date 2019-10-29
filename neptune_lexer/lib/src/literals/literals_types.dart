import '../../neptune_lexer.dart';

class IntTypeTokenLiteral extends RegexToken {
  const IntTypeTokenLiteral() : super(r"^int");
}

class StringTypeTokenLiteral extends RegexToken {
  const StringTypeTokenLiteral() : super(r"^String");
}
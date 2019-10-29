
import '../../neptune_lexer.dart';

class LeftParanTokenLiteral extends RegexToken {
  const LeftParanTokenLiteral() : super(r"^[(]");
}

class RightParanTokenLiteral extends RegexToken {
  const RightParanTokenLiteral() : super(r"^[)]");
}

class LeftCurlyTokenLiteral extends RegexToken {
  const LeftCurlyTokenLiteral() : super(r"^[{]");
}

class RightCurlyTokenLiteral extends RegexToken {
  const RightCurlyTokenLiteral() : super(r"^[}]");
}

class LeftBracketTokenLiteral extends RegexToken {
  const LeftBracketTokenLiteral() : super(r"^[[]");
}

class RightBracketTokenLiteral extends RegexToken {
  const RightBracketTokenLiteral() : super(r"^[\]]");
}

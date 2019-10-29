
import '../../neptune_lexer.dart';

class ReturnTokenLiteral extends RegexToken {
  const ReturnTokenLiteral() : super(r"^return");
}

class WhileTokenLiteral extends RegexToken {
  const WhileTokenLiteral() : super(r"^while");
}

class AndTokenLiteral extends RegexToken {
  const AndTokenLiteral() : super(r"^and");
}

class ThenTokenLiteral extends RegexToken {
  const ThenTokenLiteral() : super(r"^then");
}

class NullTokenLiteral extends RegexToken {
  const NullTokenLiteral() : super(r"^null");
}

class TrueBoolTokenLiteral extends RegexToken {
  const TrueBoolTokenLiteral() : super(r"^true");
}

class FalseBoolTokenLiteral extends RegexToken {
  const FalseBoolTokenLiteral() : super(r"^false");
}

class TextTokenLiteral extends RegexToken {
  const TextTokenLiteral() : super(r"^[a-zA-Z]+");
}

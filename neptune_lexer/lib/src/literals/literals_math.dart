import '../../neptune_lexer.dart';

class AddSymTokenLiteral extends RegexToken {
  const AddSymTokenLiteral() : super(r"^[+]");
}

class EqualsTokenLiteral extends RegexToken {
  const EqualsTokenLiteral() : super(r"^[=]");
}

class CommaSymTokenLiteral extends RegexToken {
  const CommaSymTokenLiteral() : super(r"^[,]");
}

class MinusSymTokenLiteral extends RegexToken {
  const MinusSymTokenLiteral() : super(r"^[-]");
}

class MulSymTokenLiteral extends RegexToken {
  const MulSymTokenLiteral() : super(r"^[*]");
}

class DivSymTokenLiteral extends RegexToken {
  const DivSymTokenLiteral() : super(r"^[/]");
}

class LessSymTokenLiteral extends RegexToken {
  const LessSymTokenLiteral() : super(r"^[<]");
}

class BiggerSymTokenLiteral extends RegexToken {
  const BiggerSymTokenLiteral() : super(r"^[>]");
}

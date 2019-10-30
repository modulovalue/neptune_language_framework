import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

/// Lexer -------------------------
class EnglishLexer extends Lexer {
  const EnglishLexer();
  @override
  List<NeptuneTokenLiteral> literals() => const [SingleGreetingTokenLiteral()];

  @override
  String delimiter() => " ";
}

/// Parser ------------------------
class EnglishParser extends Parser {
  const EnglishParser();

  @override
  NodeType root() {
    return EnglishNode();
  }
}

/// Literals -----------------------------------
class SingleGreetingTokenLiteral extends RegexToken {
  const SingleGreetingTokenLiteral()
      : super(r"^(hi|hellothere|hello|huhu|heya|hey|hay)");
}

const LiteralNode singleGreeting = LiteralNode(SingleGreetingTokenLiteral());

class PronomeTokenLiteral extends RegexToken {
  const PronomeTokenLiteral() : super(r"^(you)");
}

const LiteralNode pronomeGreeting = LiteralNode(PronomeTokenLiteral());

/// Nodes -----------------
class EnglishNode extends NodeType {
  @override
  ListOfRules rules() => singleGreeting + pronomeGreeting | singleGreeting;
}

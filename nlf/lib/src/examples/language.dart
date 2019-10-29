import '../../neptune_language_framework.dart';

/// Lexer -------------------------
class TestLexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return const [
            AddTokenLiteral(),
            AndTokenLiteral(),
            ThenTokenLiteral(),
            RemoveTokenLiteral(),
            OpenTokenLiteral(),
            ChartTokenLiteral(),
            PositiveNumberTokenLiteral(),
            IDTokenLiteral(),
        ];
    }

    @override
    String delimiter() => " ";
}


/// Parser ------------------------
class TestParser extends Parser {
    @override
    NodeType root() => TypeOfActionNode();
}

/// Literals -----------------------------------
class AddTokenLiteral extends RegexToken {
  const AddTokenLiteral() : super(r"^add");
}

const Rule addd = LiteralNode(AddTokenLiteral());

class RemoveTokenLiteral extends RegexToken {
  const RemoveTokenLiteral() : super(r"^((R|r)(emove)|no)");
}

const Rule removeTokenLiteral = LiteralNode(RemoveTokenLiteral());

class IDTokenLiteral extends RegexToken {
  const IDTokenLiteral() : super(r"^[a-zA-Z\d]+");
}

const Rule idTokenLiteral = LiteralNode(IDTokenLiteral());

class OpenTokenLiteral extends RegexToken {
  const OpenTokenLiteral() : super(r"^(Open|open)");
}

const Rule openTokenLiteral = LiteralNode(OpenTokenLiteral());

class ChartTokenLiteral extends RegexToken {
  const ChartTokenLiteral() : super(r"^(d|D|h|H|m|M)(C|c)(hart)");
}

const Rule chartTokenLiteral = LiteralNode(ChartTokenLiteral());

/// Nodes -----------------
class TypeOfActionNode extends NodeType {
    @override
    ListOfRules rules() =>
        addd + holding.list(andWord) + this.list(thenWord) |
        addd + holding.list(andWord) + thenWord + viewCommand.list(andWord) |
        addd + holding.list(andWord) |
        thenWord + viewCommand.list(andWord) |
        viewCommand.list(andWord);
}

class HoldingNode extends NodeType {
    @override
    ListOfRules rules() =>
        positiveNumberTokenLiteral + idTokenLiteral |
        idTokenLiteral + positiveNumberTokenLiteral;
}

NodeType holding = HoldingNode();

class ViewCommandNode extends NodeType {
    @override
    ListOfRules rules() =>
        openTokenLiteral + idTokenLiteral |
        chartTokenLiteral + idTokenLiteral;
}

NodeType viewCommand = ViewCommandNode();
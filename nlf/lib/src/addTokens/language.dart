import '../../neptune_language_framework.dart';


/// Lexer -------------------------
class TestLexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return [
            new AddTokenLiteral(),
            new AndTokenLiteral(),
            new ThenTokenLiteral(),
            new RemoveTokenLiteral(),
            new OpenTokenLiteral(),
            new ChartTokenLiteral(),
            new PositiveNumberTokenLiteral(),
            new IDTokenLiteral(),
        ];
    }

    @override
    String delimiter() => " ";
}


/// Parser ------------------------
class TestParser extends Parser {
    @override
    NodeType root() {
        return new TypeOfActionNode();
    }
}

/// TODO dynamic literals e.g. for entering a profile ?
/// TODO add preprocessor to find profiles with spaces ?
/// Literals -----------------------------------
class AddTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^add");
}

Rule addd = new LiteralNode(new AddTokenLiteral());


class RemoveTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^((R|r)(emove)|no)");
}

Rule removeTokenLiteral = new LiteralNode(new RemoveTokenLiteral());


class IDTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^[a-zA-Z\d]+");
}

Rule idTokenLiteral = new LiteralNode(new IDTokenLiteral());


class OpenTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^(Open|open)");
}

Rule openTokenLiteral = new LiteralNode(new OpenTokenLiteral());


class ChartTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^(d|D|h|H|m|M)(C|c)(hart)");
}

Rule chartTokenLiteral = new LiteralNode(new ChartTokenLiteral());


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

NodeType holding = new HoldingNode();

class ViewCommandNode extends NodeType {
    @override
    ListOfRules rules() =>
        openTokenLiteral + idTokenLiteral |
        chartTokenLiteral + idTokenLiteral;
}

NodeType viewCommand = new ViewCommandNode();
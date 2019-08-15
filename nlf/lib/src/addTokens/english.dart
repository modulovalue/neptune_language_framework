import '../../neptune_language_framework.dart';


/// Lexer -------------------------
class EnglishLexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return [
            new SingleGreetingTokenLiteral()
        ];
    }

    @override
    String delimiter() => " ";
}


/// Parser ------------------------
class EnglishParser extends Parser {
    @override
    NodeType root() {
        return new EnglishNode();
    }
}

/// Literals -----------------------------------
class SingleGreetingTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^(hi|hellothere|hello|huhu|heya|hey|hay)");
}

LiteralNode singleGreeting = new LiteralNode(new SingleGreetingTokenLiteral());


class PronomeTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => new RegexMatcher(regex: r"^(you)");
}

LiteralNode pronomeGreeting = new LiteralNode(new PronomeTokenLiteral());


/// Nodes -----------------
class EnglishNode extends NodeType {
    @override
    ListOfRules rules() =>
        singleGreeting + pronomeGreeting
        | singleGreeting
    ;
}
//
///// Nodes -----------------
//class PronomeNode extends NodeType {
//    @override
//    ListOfRules rules() =>
//        new GreetingNode().wrap();
//}
//
//class GreetingNode extends NodeType {
//    @override
//    ListOfRules rules() =>
//        singleGreeting.wrap()
//    ;
//}

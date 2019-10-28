import '../../neptune_language_framework.dart';


/// Lexer -------------------------
class EnglishLexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return [
            SingleGreetingTokenLiteral()
        ];
    }

    @override
    String delimiter() => " ";
}


/// Parser ------------------------
class EnglishParser extends Parser {
    @override
    NodeType root() {
        return EnglishNode();
    }
}

/// Literals -----------------------------------
class SingleGreetingTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^(hi|hellothere|hello|huhu|heya|hey|hay)");
}

LiteralNode singleGreeting = LiteralNode(SingleGreetingTokenLiteral());


class PronomeTokenLiteral extends NeptuneTokenLiteral {
    @override
    Matcher matcher() => RegexMatcher(regex: r"^(you)");
}

LiteralNode pronomeGreeting = LiteralNode(PronomeTokenLiteral());


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
//        GreetingNode().wrap();
//}
//
//class GreetingNode extends NodeType {
//    @override
//    ListOfRules rules() =>
//        singleGreeting.wrap()
//    ;
//}

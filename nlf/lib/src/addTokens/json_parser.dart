import '../../neptune_language_framework.dart';


/// a JSON parser
///
/// based on json grammar. Not completely ensured to be correct yet.
///
///
///

/// Lexer -------------------------
class JsonLexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return [
            new NullTokenLiteral(),
            new FalseBoolTokenLiteral(),
            new TrueBoolTokenLiteral(),

            new CommaSymTokenLiteral(),
            new ColonTokenLiteral(),

            new LeftBracketTokenLiteral(),
            new RightBracketTokenLiteral(),
            new LeftCurlyTokenLiteral(),
            new RightCurlyTokenLiteral(),

            new JsonNumberTokenLiteral(),
            new JSONStringTokenLiteral()
        ];
    }

    @override
    String delimiter() => SpacesLineTokenLiteral.regex;

    @override
    List<String> dontRemoveDelimiterInThisRegex() {
        return [
            JSONStringTokenLiteral.regex
        ];
    }
}

/// Parser ------------------------
class JsonParser extends Parser {
    @override
    NodeType root() {
        return new JSONValuee();
    }
}

/// Nodes -----------------
class JSONObject extends NodeType {
    @override
    ListOfRules rules() =>
        leftCurly + rightCurly
        | leftCurly + new JSONPair().list(commaSymTokenLiteral) + rightCurly;

}

class JSONPair extends NodeType {
    @override
    ListOfRules rules() =>
        (new JSONString() + colon + new JSONValuee()).wrap()
    ;
}


class JSONArray extends NodeType {
    @override
    ListOfRules rules() =>
        leftBracket + rightBracket
        | leftBracket + new JSONValuee().list(commaSymTokenLiteral) + rightBracket
    ;
}

class JSONValuee extends NodeType {
    @override
    ListOfRules rules() =>
        nullWord
        | falseBoolWord
        | trueBoolWord
        | new JSONArray()
        | new JSONObject()
        | new JSONNumber()
        | new JSONString()
    ;
}

class JSONString extends NodeType {
    @override
    ListOfRules rules() =>
        jsonStringTokenLiteral.wrap()
    ;
}

class JSONNumber extends NodeType {
    @override
    ListOfRules rules() =>
        jsonNumberTokenLiteral.wrap()
    ;
}
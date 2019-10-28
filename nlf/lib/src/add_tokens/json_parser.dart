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
        return const [
            NullTokenLiteral(),
            FalseBoolTokenLiteral(),
            TrueBoolTokenLiteral(),

            CommaSymTokenLiteral(),
            ColonTokenLiteral(),

            LeftBracketTokenLiteral(),
            RightBracketTokenLiteral(),
            LeftCurlyTokenLiteral(),
            RightCurlyTokenLiteral(),

            JsonNumberTokenLiteral(),
            JSONStringTokenLiteral()
        ];
    }

    @override
    String delimiter() => SpacesLineTokenLiteral.regexx;

    @override
    List<String> dontRemoveDelimiterInThisRegex() {
        return [
            JSONStringTokenLiteral.regexx
        ];
    }
}

/// Parser ------------------------
class JsonParser extends Parser {
    @override
    NodeType root() {
        return JSONValuee();
    }
}

/// Nodes -----------------
class JSONObject extends NodeType {
    @override
    ListOfRules rules() =>
        leftCurly + rightCurly
        | leftCurly + JSONPair().list(commaSymTokenLiteral) + rightCurly;

}

class JSONPair extends NodeType {
    @override
    ListOfRules rules() =>
        (JSONString() + colon + JSONValuee()).wrap()
    ;
}


class JSONArray extends NodeType {
    @override
    ListOfRules rules() =>
        leftBracket + rightBracket
        | leftBracket + JSONValuee().list(commaSymTokenLiteral) + rightBracket
    ;
}

class JSONValuee extends NodeType {
    @override
    ListOfRules rules() =>
        nullWord
        | falseBoolWord
        | trueBoolWord
        | JSONArray()
        | JSONObject()
        | JSONNumber()
        | JSONString()
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
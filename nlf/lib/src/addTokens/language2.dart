import '../../neptune_language_framework.dart';


/// Mathematical grammar as posted here but without variables
/// https://cs.stackexchange.com/questions/23738/grammar-for-parsing-simple-mathematical-expression?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
///
///
/// < expression > ::= < term > + < expression > | < term > - < expression > | < term >
///
/// < term > ::= < factor > * < term > | < factor > / < term > | < factor >
///
/// < factor > ::= (< expression >) | < float > | < var >
///
///
/// Lexer -------------------------
class Test2Lexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return [

            new LeftParanTokenLiteral(),
            new RightParanTokenLiteral(),

            new AddSymTokenLiteral(),
            new MinusSymTokenLiteral(),
            new MulSymTokenLiteral(),
            new DivSymTokenLiteral(),

            new IntTokenLiteral(),
            new TextTokenLiteral(),
            new ChickenEmojiTokenLiteral(),

        ];
    }

    @override
    String delimiter() => SpacesLineTokenLiteral.regex;
}

/// Parser ------------------------
class Test2Parser extends Parser {
    @override
    NodeType root() {
        return new TypeOfActionNode2();
    }
}

/// Nodes -----------------
class TypeOfActionNode2 extends NodeType {
    @override
    ListOfRules rules() =>
        expr.wrap()
    ;
}

class ExpressionNode extends NodeType {
    @override
    ListOfRules rules() =>
        term + addSymTokenLiteral + expr
        | term + minusSymTokenLiteral + expr
        | term
    ;
}

NodeType expr = new ExpressionNode();

class TermNode extends NodeType {
    @override
    ListOfRules rules() =>
        factor + mulSymTokenLiteral + term
        | factor + divSymTokenLiteral + term
        | factor
    ;
}

NodeType term = new TermNode();

class FactorNode extends NodeType {
    @override
    ListOfRules rules() =>
        leftParan + expr + rightParan
        | leftParan + rightParan
        | intTokenLiteral
        | textTokenLiteral
        | chickenEmojiLiteral
        ;
}

NodeType factor = new FactorNode();


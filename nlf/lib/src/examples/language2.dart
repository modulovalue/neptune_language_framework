import '../../neptune_language_framework.dart';

/// Mathematical grammar as posted here but without variables
/// https://cs.stackexchange.com/questions/23738/grammar-for-parsing-simple-mathematical-expression?utm_medium=organic&utm_source=google_rich_qa&utm_campaign=google_rich_qa
///
/// < expression > ::= < term > + < expression > | < term > - < expression > | < term >
///
/// < term > ::= < factor > * < term > | < factor > / < term > | < factor >
///
/// < factor > ::= (< expression >) | < float > | < var >
///
/// Lexer -------------------------
class Test2Lexer extends Lexer {
  @override
  List<NeptuneTokenLiteral> literals() {
    return const [
      LeftParanTokenLiteral(),
      RightParanTokenLiteral(),
//
      AddSymTokenLiteral(),
      MinusSymTokenLiteral(),
      MulSymTokenLiteral(),
      DivSymTokenLiteral(),
//
      IntTokenLiteral(),
      TextTokenLiteral(),
      ChickenEmojiTokenLiteral(),
    ];
  }

  @override
  String delimiter() => SpacesLineTokenLiteral.regexx;
}

/// Parser ------------------------
class Test2Parser extends Parser<Test2Node> {
  @override
  Test2Node root() => TypeOfActionNode2();
}

/// Nodes -----------------
abstract class Test2Node extends NodeType {
  T visit<T>(Test2Visitor<T> visitor);
}

class TypeOfActionNode2 extends Test2Node {
  @override
  ListOfRules rules() => expr.wrap();

  @override
  T visit<T>(Test2Visitor<T> visitor) => visitor.typeOfAction2(this);
}

class ExpressionNode extends Test2Node {
  @override
  ListOfRules rules() =>
      term + addSymTokenLiteral + expr |
      term + minusSymTokenLiteral + expr |
      term;

  @override
  T visit<T>(Test2Visitor<T> visitor) => visitor.expression(this);
}

NodeType expr = ExpressionNode();

class TermNode extends Test2Node {
  @override
  ListOfRules rules() =>
      factor + mulSymTokenLiteral + term |
      factor + divSymTokenLiteral + term |
      factor;

  @override
  T visit<T>(Test2Visitor<T> visitor) => visitor.term(this);
}

NodeType term = TermNode();

class FactorNode extends Test2Node {
  @override
  ListOfRules rules() =>
      leftParan + expr + rightParan |
      leftParan + rightParan |
      intTokenLiteral |
      textTokenLiteral |
      emojiLiteral;

  @override
  T visit<T>(Test2Visitor<T> visitor) => visitor.factor(this);
}

NodeType factor = FactorNode();

abstract class Test2Visitor<T> {
  T typeOfAction2(TypeOfActionNode2 node);

  T expression(ExpressionNode node);

  T term(TermNode node);

  T factor(FactorNode node);
}

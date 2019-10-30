import 'package:neptune_language_framework/src/preset_tokens.dart';
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

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
class MathLexer extends Lexer {
  const MathLexer();

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
    ];
  }

  @override
  String delimiter() => SpacesLineTokenLiteral.regexx;
}

/// Parser ------------------------
class MathParser extends Parser<MathNode> {
  const MathParser();

  @override
  MathNode root() => TypeOfActionNode2();
}

/// Nodes -----------------
abstract class MathNode extends NodeType {
  T visit<T>(MathVisitor<T> visitor);
}

class TypeOfActionNode2 extends MathNode {
  @override
  ListOfRules rules() => expr.wrap();

  @override
  T visit<T>(MathVisitor<T> visitor) => visitor.typeOfAction2(this);
}

class ExpressionNode extends MathNode {
  @override
  ListOfRules rules() =>
      term + addSymTokenLiteral + expr |
      term + minusSymTokenLiteral + expr |
      term;

  @override
  T visit<T>(MathVisitor<T> visitor) => visitor.expression(this);
}

NodeType expr = ExpressionNode();

class TermNode extends MathNode {
  @override
  ListOfRules rules() =>
      factor + mulSymTokenLiteral + term |
      factor + divSymTokenLiteral + term |
      factor;

  @override
  T visit<T>(MathVisitor<T> visitor) => visitor.term(this);
}

NodeType term = TermNode();

class FactorNode extends MathNode {
  @override
  ListOfRules rules() =>
      leftParan + expr + rightParan |
      leftParan + rightParan |
      intTokenLiteral |
      textTokenLiteral;

  @override
  T visit<T>(MathVisitor<T> visitor) => visitor.factor(this);
}

NodeType factor = FactorNode();

abstract class MathVisitor<T> {
  T typeOfAction2(TypeOfActionNode2 node);

  T expression(ExpressionNode node);

  T term(TermNode node);

  T factor(FactorNode node);
}

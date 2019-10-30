import 'package:neptune_language_framework/src/preset_tokens.dart';
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

class ListLexer extends Lexer {
  const ListLexer();

  @override
  List<NeptuneTokenLiteral> literals() {
    return const [
      LeftBracketTokenLiteral(),
      RightBracketTokenLiteral(),
      //
      CommaSymTokenLiteral(),
      //
      IntTokenLiteral(),
      TextTokenLiteral(),
    ];
  }

  @override
  String delimiter() => SpacesLineTokenLiteral.regexx;
}

/// Parser ------------------------
class ListParser extends Parser<ListNode> {
  const ListParser();

  @override
  ListNode root() => ListAction();
}

/// Nodes -----------------
abstract class ListNode extends NodeType {
  T visit<T>(ListVisitor<T> visitor);
}

class ListAction extends ListNode {
  @override
  ListOfRules rules() =>
      leftBracket + ListExpressionNode() + rightBracket |
      leftBracket + rightBracket
  ;

  @override
  T visit<T>(ListVisitor<T> visitor) => visitor.listAction(this);
}

class ListExpressionNode extends ListNode {
  @override
  ListOfRules rules() =>
      ValueNode() + commaSymTokenLiteral + ListExpressionNode() |
      ValueNode() + commaSymTokenLiteral |
      ValueNode() |
      commaSymTokenLiteral
  ;

  @override
  T visit<T>(ListVisitor<T> visitor) => visitor.expression(this);
}

class ValueNode extends ListNode {
  @override
  ListOfRules rules() => intTokenLiteral | textTokenLiteral;

  @override
  T visit<T>(ListVisitor<T> visitor) => visitor.value(this);
}

abstract class ListVisitor<T> {
  T listAction(ListAction node);

  T expression(ListExpressionNode node);

  T value(ValueNode node);
}

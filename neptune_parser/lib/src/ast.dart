import 'package:meta/meta.dart';
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

abstract class ASTNode<T extends NodeType> {
  const ASTNode();

  U visit<U>(ASTNodeVisitor<U, T> visitor);
}

class ASTNodeLiteral<T extends NodeType> implements ASTNode<T> {
  final LexerMatchResult matchResult;
  final T nodeType;

  const ASTNodeLiteral({
    @required this.nodeType,
    @required this.matchResult,
  });

  @override
  U visit<U>(ASTNodeVisitor<U, T> visitor) => visitor.literal(this);
}

class ASTNodeCommutativeNary<T extends NodeType> implements ASTNode<T> {
  final List<ASTNode<T>> nodes;
  final LexerMatchResult matchResult;
  final T nodeType;

  const ASTNodeCommutativeNary({
    @required this.nodes,
    @required this.nodeType,
    @required this.matchResult,
  });

  @override
  U visit<U>(ASTNodeVisitor<U, T> visitor) => visitor.nary(this);
}

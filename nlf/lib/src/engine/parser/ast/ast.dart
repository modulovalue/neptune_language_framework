import 'package:neptune_language_framework/neptune_language_framework.dart';

abstract class ASTNode<T extends NodeType> {
  final LexerMatchResult matchResult;
  final T nodeType;

  const ASTNode(this.nodeType, this.matchResult);

  U visit<U>(ASTNodeVisitor<U, T> visitor);
}

class ASTNodeLiteral<T extends NodeType> extends ASTNode<T> {
  const ASTNodeLiteral({
    @required T value,
    @required LexerMatchResult matchResult,
  }) : super(value, matchResult);

  @override
  U visit<U>(ASTNodeVisitor<U, T> visitor) => visitor.literal(this);
}

class ASTNodeCommutativeNary<T extends NodeType> extends ASTNode<T> {
  final List<ASTNode<T>> nodes;

  const ASTNodeCommutativeNary({
    @required this.nodes,
    @required T value,
    @required LexerMatchResult matchResult,
  }) : super(value, matchResult);

  @override
  U visit<U>(ASTNodeVisitor<U, T> visitor) => visitor.nary(this);
}

abstract class ASTNodeVisitor<T, U extends NodeType> {
  T literal(ASTNodeLiteral<U> node);

  T nary(ASTNodeCommutativeNary<U> node);
}

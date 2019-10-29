import 'package:neptune_language_framework/neptune_language_framework.dart';

class ASTNodeConsumeCount<T extends NodeType> implements ASTNodeVisitor<int, T> {

  const ASTNodeConsumeCount();

  @override
  int literal(ASTNodeLiteral<T> node) => 1;

  @override
  int nary(ASTNodeCommutativeNary<T> node) => node.nodes
      .map((a) => a?.visit?.call<int>(this) ?? 0)
      .fold(0, (prev, a) => prev += a);
}

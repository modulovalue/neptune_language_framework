import '../../../neptune_parser.dart';

class ToStringTreeVisitor<T extends NodeType> implements ASTNodeVisitor<String, T> {
  final bool pureForTestComparison;

  const ToStringTreeVisitor(this.pureForTestComparison);

  @override
  String literal(ASTNodeLiteral node) {
    if (pureForTestComparison) {
      return "${node.matchResult?.matchedString}";
    } else {
      return "${node.matchResult?.matchedString}";
    }
  }

  @override
  String nary(ASTNodeCommutativeNary node) {
    if (pureForTestComparison) {
      return "${node.nodes.map((f) => f.visit(ToStringTreeVisitor(pureForTestComparison))).join("")}";
    } else {
      if (node.nodes.length == 1) {
        return "${node.nodes.first.visit(ToStringTreeVisitor(pureForTestComparison))}";
      } else {
        return "[${node.nodes.map((f) => f.visit(ToStringTreeVisitor(pureForTestComparison))).join(" ")}]";
      }
    }
  }
}

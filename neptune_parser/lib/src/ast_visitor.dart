
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

abstract class ASTNodeVisitor<T, U extends NodeType> {
  T literal(ASTNodeLiteral<U> node);

  T nary(ASTNodeCommutativeNary<U> node);
}

class ASTNodeConsumeCount<T extends NodeType> implements ASTNodeVisitor<int, T> {
  const ASTNodeConsumeCount();

  @override
  int literal(ASTNodeLiteral<T> node) => 1;

  @override
  int nary(ASTNodeCommutativeNary<T> node) => node.nodes
      .map((a) => a?.visit?.call<int>(this) ?? 0)
      .fold(0, (prev, a) => prev += a);
}

class PrettyPrinterVisitor<T extends NodeType> implements ASTNodeVisitor<String, T> {
  static const bool html = false;

  final String indent;
  final bool last;

  const PrettyPrinterVisitor(this.indent, this.last);

  @override
  String literal(ASTNodeLiteral node) {
    var prin = indent;
    if (last) {
      prin += "\\ ";
    } else {
      prin += "|-";
    }
    if (html) {
      return "$prin ${node.matchResult.matchedString} $node{matchResult.token.runtimeType}\n";
    } else {
      return "$prin $redClr${node.matchResult.matchedString}$resetCode $yellowClr ${node.matchResult.token.runtimeType} $resetCode\n";
    }
  }

  @override
  String nary(ASTNodeCommutativeNary node) {
    var _indent = indent;
    var prin = indent;
    if (last) {
      prin += "\\ ";
      _indent += "  ";
    } else {
      prin += "|-";
      _indent += "| ";
    }

    if (html) {
      prin = "$prin ${node.nodeType.toString()}\n";
    } else {
      prin = "$prin $cyanClr${node.nodeType.toString()} $resetCode\n";
    }

    for (int i = 0; i < node.nodes.length; i++) {
      // ignore: use_string_buffers
      prin += node.nodes[i]
          .visit(PrettyPrinterVisitor(_indent, i == node.nodes.length - 1));
    }

    return prin;
  }
}

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

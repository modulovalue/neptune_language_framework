import 'package:neptune_lexer/neptune_lexer.dart';

import '../../../neptune_parser.dart';

class PrettyPrinterVisitor<T extends NodeType> implements ASTNodeVisitor<String, T> {
  static bool html = false;

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

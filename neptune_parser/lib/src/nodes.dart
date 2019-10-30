import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

abstract class NodeType extends Rule {
  const NodeType();

  ListOfRules rules();

  @override
  List<NodeType> nodes() => [this];

  int calcOffset(List<ASTNode> nodes) => nodes.fold<int>(
      0,
      (prev, node) =>
          prev += node?.visit?.call<int>(const ASTNodeConsumeCount()) ?? 0);

  ASTNode parse(List<LexerMatchResult> lookahead) {
    for (final rule in rules().rulesLists) {
      final nodes = <ASTNode>[];
      var offset = 0;
      for (final value in rule.asMap().entries) {
        offset = calcOffset(nodes);
        if (offset >= lookahead.length) {
          nodes.add(null);

          /// TODO Mark last rule and maybe give feedback on what was expected
          /// throw "No matching rule found '${lookahead[offset].matchedString}' at ${lookahead[offset].positionFrom}";
        } else {
          final node = value.value.parse(lookahead.sublist(offset).toList());
          if (node == null) {
            nodes.add(null);
            break;
          } else {
            nodes.add(node);
          }
        }
      }
      if (!nodes.contains(null)) {
        return ASTNodeCommutativeNary(
            nodes: nodes, nodeType: this, matchResult: null);
      } else {
//        throw Exception("Unexpected token '${lookahead[offset].matchedString}' at ${lookahead[offset].positionFrom}");
      }
    }
    return null;
  }

  Rule list(Rule e) => NestedNode("List+ of $this with ${e.toString()}",
      (self) => this + e + self | this + e | this);

  Rule directList() => NestedNode(
      "List+ of $this with no separator", (self) => this + self | this);
}

class NestedNode extends NodeType {
  final String description;

  ListOfRules listOfRules;

  NestedNode(this.description, ListOfRules Function(NodeType self) source) {
    listOfRules = source(this);
  }

  @override
  ListOfRules rules() => listOfRules;
}

class LiteralNode extends NodeType {
  final NeptuneTokenLiteral node;

  const LiteralNode(this.node) : assert(node != null);

  Type get literal => node.runtimeType;

  @override
  ListOfRules rules() => const ListOfRules([]);

  @override
  ASTNode parse(List<LexerMatchResult> lookahead) {
    if (lookahead.first.token.runtimeType == literal) {
      return ASTNodeLiteral(nodeType: this, matchResult: lookahead.first);
    } else {
      return null;
    }
  }
}

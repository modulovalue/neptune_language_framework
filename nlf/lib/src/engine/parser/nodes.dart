import 'package:neptune_language_framework/neptune_language_framework.dart';

abstract class NodeType extends Rule
    with PrettyPrinterTemplate
    implements PrettyPrinter {
  const NodeType();

  ListOfRules rules();

  @override
  List<NodeType> nodes() => [this];

  int calcOffset(List<ASTNode> nodes) =>
      nodes.fold<int>(0, (prev, node) => prev += node?.consumeCount() ?? 0);

  ASTNode parse(List<LexerMatchResult> lookahead) {
    for (final rule in rules().rulesLists) {
      final nodes = <ASTNode>[];
      var offset = 0;
      for (final value in rule.asMap().entries) {
        offset = calcOffset(nodes);
        if (offset >= lookahead.length) {
          nodes.add(null);

          /// TODO Mark last rule and maybe give feedback on what was expected
//                    throw "No matching rule found '${lookahead[offset].matchedString}' at ${lookahead[offset]
//                        .positionFrom}";
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
        return ASTNodeCommutativeBinary(
            nodes: nodes, value: this, matchResult: null);
      } else {
//        throw Exception(
//            "Unexpected token '${lookahead[offset].matchedString}' at ${lookahead[offset].positionFrom}");
      }
    }
    return null;
  }

  Rule list(Rule e) => DynamicNode("List+ of $this with ${e.toString()}",
      (self) => this + e + self | this + e | this);

  Rule directList() => DynamicNode(
      "List+ of $this with no separator", (self) => this + self | this);

  @override
  void prettyPrint({NodeTypePrinter printer = const BNFNodeTypePrinter()}) {
    printer.prettyPrint(this);
  }

  @override
  String toString() {
    return "$magentaClr" + runtimeType.toString() + "$resetCode";
  }
}

class DynamicNode extends NodeType {
  final String description;

  ListOfRules listOfRules;

  DynamicNode(this.description, ListOfRules Function(NodeType self) source) {
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
      return ASTNodeLiteral(
        value: this,
        matchResult: lookahead.first,
      );
    } else {
      return null;
    }
  }
}

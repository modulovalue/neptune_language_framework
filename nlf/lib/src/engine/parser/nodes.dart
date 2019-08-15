import '../../../neptune_language_framework.dart';


abstract class NodeType extends Rule with PrettyPrinterTemplate implements PrettyPrinter {

    ListOfRules rules();

    @override
    List<NodeType> get nodes {
        return [this];
    }

    int calcOffset(List<ASTNode> nodes) {
        return nodes.fold<int>(0, (prev, node) => prev += (node?.consumeCount() ?? 0));
    }

    ASTNode parse(List<LexerMatchResult> lookahead) {
        for (var rule in rules().rulesLists) {
            List<ASTNode> nodes = [];
            var offset = 0;
            for (MapEntry<int, NodeType> value in rule
                .asMap()
                .entries) {
                offset = calcOffset(nodes);
                if (offset >= lookahead.length) {
                    nodes.add(null);
                    /// TODO Mark last rule and maybe give feedback on what was expected
//                    throw "No matching rule found '${lookahead[offset].matchedString}' at ${lookahead[offset]
//                        .positionFrom}";
                } else {
                    var node = value.value.parse(lookahead.sublist(offset).toList());
                    if (node == null) {
                        nodes.add(null);
                        break;
                    } else {
                        nodes.add(node);
                    }
                }
            }
            if (!nodes.contains(null)) {
                return new ASTNodeCommutativeBinary(nodes: nodes, value: this, matchResult: null);
            } else {
//                throw "Unexpected token '${lookahead[offset].matchedString}' at ${lookahead[offset].positionFrom}";
            }
        }
        return null;
    }

    Rule list(Rule e) {
        return new DynamicNode("List+ of $this with ${e.toString()}",
                (self) =>
            this + e + self
            | this + e
            | this
        );
    }

    Rule directList() {
        return new DynamicNode("List+ of $this with no separator",
                (self) =>
            this + self
            | this
        );
    }

    @override
    void prettyPrint({NodeTypePrinter printer = const BNFNodeTypePrinter()}) {
        printer.prettyPrint(this);
    }

    @override
    String toString() {
        return "$magentaClr"+ runtimeType.toString() + "$resetCode";
    }
}

class DynamicNode extends NodeType {

    String description;

    ListOfRules listOfRules;

    DynamicNode(this.description, ListOfRules Function(NodeType self) source) {
        listOfRules = source(this);
    }

    @override
    ListOfRules rules() {
        return listOfRules;
    }

    @override
    String toString() {
        return "$magentaClr"+ "$description" + "$resetCode";
    }
}

class LiteralNode extends NodeType {

    LiteralNode(this.node) : assert(node != null);

    Type get literal {
        return node.runtimeType;
    }

    NeptuneTokenLiteral node;

    @override
    ListOfRules rules() {
        return new ListOfRules([
        ]);
    }

    @override
    ASTNode parse(List<LexerMatchResult> lookahead) {
        if (lookahead.first.token.runtimeType == literal) {
            return new ASTNodeLiteral(
                value: this,
                matchResult: lookahead.first,
            );
        } else {
            return null;
        }
    }

    @override
    String toString() {
        return "$blueClr"+ node.matcher().toString() + " $greenClr$literal$resetCode";
    }
}

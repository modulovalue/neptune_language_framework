import '../../../neptune_language_framework.dart';

abstract class ASTNode {

    static bool html = false;
    LexerMatchResult matchResult;

    NodeType nodeType;

    ASTNode(this.nodeType, this.matchResult);

    int consumeCount();

    String toStringTree(bool pureForTestComparison);

    String prettyPrint(String indent, bool last);
}

class ASTNodeLiteral extends ASTNode {

    ASTNodeLiteral({
        @required NodeType value,
        @required LexerMatchResult matchResult,
    }) : super(value, matchResult);

    @override
    int consumeCount() {
        return 1;
    }

    @override
    String toStringTree(bool pureForTestComparison) {
        if (pureForTestComparison) {
            return "${matchResult?.matchedString}";
        } else {
            return "${matchResult?.matchedString}";
        }
    }

    @override
    String prettyPrint(String indent, bool last) {
        var prin = indent;

        if (last) {
            prin += "\\ ";
            indent += "  ";
        }
        else {
            prin += "|-";
            indent += "| ";
        }
        if (ASTNode.html) {
            return "$prin ${matchResult.matchedString} ${matchResult.token.runtimeType}\n";

        } else {
            return "$prin $redClr${matchResult.matchedString}$resetCode $yellowClr ${matchResult.token
                .runtimeType} $resetCode\n";
        }
    }
}

class ASTNodeCommutativeBinary extends ASTNode {
    List<ASTNode> nodes;

    ASTNodeCommutativeBinary({
        @required this.nodes,
        @required NodeType value,
        @required LexerMatchResult matchResult,
    }) : super(value, matchResult);

    @override
    String toStringTree(bool pureForTestComparison) {
        if (pureForTestComparison) {
            return "${nodes.map((f) => f.toStringTree(pureForTestComparison)).join("")}";
        } else {
            if (nodes.length == 1) {
                return "${nodes.first.toStringTree(pureForTestComparison)}";
            } else {
                return "[${nodes.map((f) => f.toStringTree(pureForTestComparison)).join(" ")}]";
            }
        }
    }

    @override
    int consumeCount() {
        return nodes.fold<int>(0, (prev, node) => prev += (node?.consumeCount() ?? 0));
    }

    @override
    String prettyPrint(String indent, bool last) {
        var prin = indent;
        if (last) {
            prin += "\\ ";
            indent += "  ";
        }
        else {
            prin += "|-";
            indent += "| ";
        }

        if (ASTNode.html) {
            prin = "$prin ${nodeType.toString()}\n";
        } else {
            prin = "$prin $cyanClr${nodeType.toString()} $resetCode\n";
        }

        for (int i = 0; i < nodes.length; i++) {
            prin += nodes[i].prettyPrint(indent, i == nodes.length - 1);
        }

        return prin;
    }
}
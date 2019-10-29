import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

void simpleParserPrettyPrinter(Parser parser) {
  printTemplate(printHeader: () {
    paddedPrint(
        r"______                                     _                 ");
    paddedPrint(
        r"| ___ \                                   | |                ");
    paddedPrint(
        r"| |_/ /_ _ _ __ ___  ___ _ __  __   ____ _| |_   _  ___  ___ ");
    paddedPrint(
        r"|  __/ _` | '__/ __|/ _ \ '__| \ \ / / _` | | | | |/ _ \/ __|");
    paddedPrint(
        r"| | | (_| | |  \__ \  __/ |     \ V / (_| | | |_| |  __/\__ \");
    paddedPrint(
        r"\_|  \__,_|_|  |___/\___|_|      \_/ \__,_|_|\__,_|\___||___/");
  }, printBody: () {
    paddedPrint("Parser", parser.runtimeType.toString());
    paddedPrint("Root", parser.root().runtimeType.toString());
  });
  prettyPrintBNFNodeType(parser.root());
}

void prettyPrintBNFNodeType(NodeType root) {
  printTemplate(printHeader: () {
    paddedPrint(r"______ _____  _____ _____   ______ _   _ ______ ");
    paddedPrint(r"| ___ \  _  ||  _  |_   _|  | ___ \ \ | ||  ___|");
    paddedPrint(r"| |_/ / | | || | | | | |(_) | |_/ /  \| || |_   ");
    paddedPrint(r"|    /| | | || | | | | |    | ___ \ . ` ||  _|  ");
    paddedPrint(r"| |\ \\ \_/ /\ \_/ / | | _  | |_/ / |\  || |    ");
    paddedPrint(r"\_| \_|\___/  \___/  \_/(_) \____/\_| \_/\_|    ");
    paddedPrint("\n");
  }, printBody: () {
    paddedPrint("Root:", root.runtimeType.toString());
    _printNode(root);
  });
}

void _printNode(NodeType node) {
  final List<NodeType> nodes = [];
  final List<String> alreadyVisited = [];

  nodes.add(node);
  while (nodes.isNotEmpty) {
    final firstNode = nodes.first;

    String nodeBnf = "";

    nodeBnf = firstNode
        .rules()
        .rulesLists
        .map((List<NodeType> list) {
          return list.map((NodeType nodeType) {
            if (!alreadyVisited.contains(nodeType.toString()) &&
                !nodes.contains(nodeType)) {
              nodes.add(nodeType);
            }
            return nodeType.toString();
          }).join(", ");
        })
        .toList()
        .join("\n" + "".padLeft(29) + "| ");

    if (nodeBnf != "") {
      paddedPrint(
        firstNode.runtimeType.toString(),
        nodeBnf + "\n",
      );
    }

    alreadyVisited.add(nodes.removeAt(0).toString());
  }
}

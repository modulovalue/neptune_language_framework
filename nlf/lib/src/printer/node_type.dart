import '../../neptune_language_framework.dart';

abstract class NodeTypePrinter {
  const NodeTypePrinter();

  void prettyPrint(NodeType root);
}

class BNFNodeTypePrinter extends NodeTypePrinter {
  const BNFNodeTypePrinter();

  @override
  void prettyPrint(NodeType root) {
    PrettyPrinterTemplate.printTemplate(printHeader: () {
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
              return nodeType.toString() ;
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
}

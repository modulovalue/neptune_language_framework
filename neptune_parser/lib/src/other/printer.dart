import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

String simpleParserPrettyPrinterText(Parser parser, PaddedText pad) {
  String ret = "";
  ret += printTextTemplate(
      printHeader: () {
        String ret = "";
        ret += pad(
            r"______                                     _                 ");
        ret += pad(
            r"| ___ \                                   | |                ");
        ret += pad(
            r"| |_/ /_ _ _ __ ___  ___ _ __  __   ____ _| |_   _  ___  ___ ");
        ret += pad(
            r"|  __/ _` | '__/ __|/ _ \ '__| \ \ / / _` | | | | |/ _ \/ __|");
        ret += pad(
            r"| | | (_| | |  \__ \  __/ |     \ V / (_| | | |_| |  __/\__ \");
        ret += pad(
            r"\_|  \__,_|_|  |___/\___|_|      \_/ \__,_|_|\__,_|\___||___/");
        return ret;
      },
      printBody: () {
        String ret = "";
        ret += pad("Parser", second: parser.runtimeType.toString());
        ret += pad("Root", second: parser.root().runtimeType.toString());
        return ret;
      },
      pad: pad);
  ret += prettyPrintBNFNodeTypeText(parser.root(), pad);
  return ret;
}

String prettyPrintBNFNodeTypeText(NodeType root, PaddedText pad) {
  return printTextTemplate(
      printHeader: () {
        String ret = "";
        ret += pad(r"______ _____  _____ _____   ______ _   _ ______ ");
        ret += pad(r"| ___ \  _  ||  _  |_   _|  | ___ \ \ | ||  ___|");
        ret += pad(r"| |_/ / | | || | | | | |(_) | |_/ /  \| || |_   ");
        ret += pad(r"|    /| | | || | | | | |    | ___ \ . ` ||  _|  ");
        ret += pad(r"| |\ \\ \_/ /\ \_/ / | | _  | |_/ / |\  || |    ");
        ret += pad(r"\_| \_|\___/  \___/  \_/(_) \____/\_| \_/\_|    ");
        ret += pad("\n");
        return ret;
      },
      printBody: () {
        String ret = "";
        ret += pad("Root:", second: root.runtimeType.toString());
        ret += _printNode(root, pad);
        return ret;
      },
      pad: pad);
}

String _printNode(NodeType node, PaddedText pad) {
  final List<NodeType> nodes = [];
  final List<String> alreadyVisited = [];

  String ret = "";
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
      ret += pad(
        firstNode.runtimeType.toString(),
        second: nodeBnf,
      );
    }

    alreadyVisited.add(nodes.removeAt(0).toString());
  }
  return ret;
}

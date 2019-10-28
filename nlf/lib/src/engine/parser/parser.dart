import 'package:neptune_language_framework/neptune_language_framework.dart';

abstract class Parser extends Object
    with PrettyPrinterTemplate
    implements PrettyPrinter {
  const Parser();

  NodeType root();

  ParserResult run(List<LexerMatchResult> expressions) {
    ParserResponse response;
    ASTNode rootNode;

    final timeElapsed = stopwatch(() {
      try {
        rootNode = root().parse(expressions);
      } catch (e, f) {
        response =
            ParserResponseUnknownError(e.toString() + "\n" + f.toString());
        rethrow;
      }
    });

    return ParserResult(
      rootNode: rootNode,
      respone: response ?? const ParserResponseSuccessful(),
      executionInfo: ParserExecutionInfo(durationToExecute: timeElapsed),
    );
  }

  @override
  void prettyPrint(
      {ParserPrinter printer = const SimpleParserPrinter(),
      bool prettyPrintRoot = true,
      NodeTypePrinter nodeTypePrinter = const BNFNodeTypePrinter()}) {
    printer.prettyPrint(this);
    if (prettyPrintRoot) {
      root().prettyPrint(printer: nodeTypePrinter);
    }
  }
}

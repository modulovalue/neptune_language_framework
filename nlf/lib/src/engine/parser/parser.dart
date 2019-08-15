import '../../../neptune_language_framework.dart';

abstract class Parser extends Object with PrettyPrinterTemplate implements PrettyPrinter {

    NodeType root();

    ParserResult run(List<LexerMatchResult> expressions) {
        ParserResponse response;
        ASTNode rootNode;

        var timeElapsed = stopwatch(() {
            try {
                rootNode = root().parse(expressions);
            } catch (e, f) {
                response = new ParserResponseUnknownError(e.toString() + "\n" + f.toString());
                rethrow;
            }
        });

        return new ParserResult(
            rootNode: rootNode,
            respone: response ?? new ParserResponseSuccessful(),
            executionInfo: new ParserExecutionInfo(durationToExecute: timeElapsed),
        );
    }

    @override
    void prettyPrint({ParserPrinter printer = const SimpleParserPrinter(), bool prettyPrintRoot = true, NodeTypePrinter nodeTypePrinter = const BNFNodeTypePrinter()}) {
        printer.prettyPrint(this);
        if (prettyPrintRoot) {
            root().prettyPrint(printer: nodeTypePrinter);
        }
    }

    List<NodeType> nodes() {
        return null;
    }
}

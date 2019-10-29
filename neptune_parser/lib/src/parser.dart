import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

abstract class Parser<T extends NodeType> {
  const Parser();

  T root();

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
      response: response ?? const ParserResponseSuccessful(),
      executionInfo: ParserExecutionInfo(durationToExecute: timeElapsed),
    );
  }
}

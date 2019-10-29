import 'package:meta/meta.dart';
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

abstract class ParserResponse {
  final String shortDescription;

  const ParserResponse(this.shortDescription);

  @override
  String toString() =>
      "${runtimeType.toString()}: ${shortDescription.toString()}";
}

class ParserResponseSuccessful extends ParserResponse {
  const ParserResponseSuccessful() : super("success");
}

class ParserResponseUnknownError extends ParserResponse {
  const ParserResponseUnknownError(String description) : super(description);
}

class ParserExecutionInfo {
  final Duration durationToExecute;

  const ParserExecutionInfo({@required this.durationToExecute});
}

class ParserResult {
  final ASTNode rootNode;
  final ParserResponse response;
  final ParserExecutionInfo executionInfo;

  const ParserResult({
    @required this.rootNode,
    @required this.response,
    @required this.executionInfo,
  });
}

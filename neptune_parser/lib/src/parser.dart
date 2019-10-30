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
      durationToExecute: timeElapsed,
    );
  }
}

class ParserResult {
  final ASTNode rootNode;
  final ParserResponse response;
  final Duration durationToExecute;

  const ParserResult({
    @required this.rootNode,
    @required this.response,
    @required this.durationToExecute,
  });
}

abstract class ParserResponse {
  final String shortDescription;

  const ParserResponse._(this.shortDescription);

  @override
  String toString() =>
      "${runtimeType.toString()}: ${shortDescription.toString()}";
}

class ParserResponseSuccessful extends ParserResponse {
  const ParserResponseSuccessful() : super._("success");
}

class ParserResponseUnknownError extends ParserResponse {
  const ParserResponseUnknownError(String description) : super._(description);
}

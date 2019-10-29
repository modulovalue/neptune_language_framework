import 'package:meta/meta.dart';
import 'package:neptune_parser/neptune_parser.dart';

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

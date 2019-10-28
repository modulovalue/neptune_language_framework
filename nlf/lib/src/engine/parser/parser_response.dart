import 'package:meta/meta.dart';
import 'package:neptune_language_framework/neptune_language_framework.dart';

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
  final ParserResponse respone;
  final ParserExecutionInfo executionInfo;

  const ParserResult({
    @required this.rootNode,
    @required this.respone,
    @required this.executionInfo,
  });
}

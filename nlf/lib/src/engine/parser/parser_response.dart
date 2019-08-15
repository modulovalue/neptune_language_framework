import '../../../neptune_language_framework.dart';

abstract class ParserResponse {
    String shortDescription;

    ParserResponse(this.shortDescription);

    @override
    String toString() {
        return "${runtimeType.toString()}: ${shortDescription.toString()}";
    }
}

class ParserResponseSuccessful extends ParserResponse {
    ParserResponseSuccessful() : super("success");
}

class ParserResponseUnknownError extends ParserResponse {
    ParserResponseUnknownError(String description) : super(description);
}

class ParserExecutionInfo {
    Duration durationToExecute;

    ParserExecutionInfo({@required this.durationToExecute});
}

class ParserResult {
    ASTNode rootNode;
    ParserResponse respone;
    ParserExecutionInfo executionInfo;

    ParserResult({
        @required this.rootNode,
        @required this.respone,
        @required this.executionInfo,
    });
}
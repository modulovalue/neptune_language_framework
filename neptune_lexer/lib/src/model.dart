
import 'package:meta/meta.dart';
import 'package:neptune_lexer/neptune_lexer.dart';

abstract class LexerResponse {
  final String shortDescription;

  const LexerResponse(this.shortDescription);

  @override
  String toString() {
    return "${runtimeType.toString()}: ${shortDescription.toString()}";
  }
}

class LexerResponseSuccessful extends LexerResponse {
  const LexerResponseSuccessful() : super("success");
}

class LexerResponseUnknownError extends LexerResponse {
  const LexerResponseUnknownError(String description) : super(description);
}

class LexerResponseUnknownToken extends LexerResponse {
  const LexerResponseUnknownToken(String description) : super(description);
}

class LexerExecutionInfo {
  final Duration durationToExecute;

  const LexerExecutionInfo({@required this.durationToExecute});
}

class LexerResult {
  final List<LexerMatchResult> successfulResult;
  final LexerResponse respone;
  final LexerExecutionInfo executionInfo;

  const LexerResult({
    @required this.successfulResult,
    @required this.respone,
    @required this.executionInfo,
  });
}

class LexerMatchResult {
  final MatchingStatus status;
  final NeptuneTokenLiteral token;
  final String matchedString;
  final int positionFrom;
  final String left;

  const LexerMatchResult({
    @required this.status,
    @required this.token,
    @required this.matchedString,
    @required this.positionFrom,
    @required this.left,
  });

  int get positionTo {
    if (matchedString?.length != null) {
      return positionFrom + (matchedString.length);
    } else {
      return positionFrom;
    }
  }

  @override
  String toString() =>
      'LexerMatchResult{status: $status, token: $token, matchedString: $matchedString, positionFrom: $positionFrom, left: $left}';
}

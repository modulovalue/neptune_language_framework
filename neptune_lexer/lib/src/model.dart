import 'package:meta/meta.dart';
import 'package:neptune_lexer/neptune_lexer.dart';

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

abstract class LexerResponse {
  final String shortDescription;

  const LexerResponse._(this.shortDescription);

  @override
  String toString() {
    return "${runtimeType.toString()}: ${shortDescription.toString()}";
  }
}

class LexerResponseSuccessful extends LexerResponse {
  const LexerResponseSuccessful() : super._("success");
}

class LexerResponseUnknownError extends LexerResponse {
  const LexerResponseUnknownError(String description) : super._(description);
}

class LexerResponseUnknownToken extends LexerResponse {
  const LexerResponseUnknownToken(String description) : super._(description);
}

class LexerResult {
  final List<LexerMatchResult> successfulResult;
  final LexerResponse respone;
  final Duration durationToExecute;

  const LexerResult({
    @required this.successfulResult,
    @required this.respone,
    @required this.durationToExecute,
  });
}

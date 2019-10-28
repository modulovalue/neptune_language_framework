
import 'package:meta/meta.dart';

class ParserException implements Exception {
  final String cause;

  const ParserException(this.cause);

  @override
  String toString() => '$runtimeType: $cause';
}

class ParserStackEmptyException extends ParserException {
  const ParserStackEmptyException({@required String cause}) : super(cause);
}

class ParserNoRuleException extends ParserException {
  const ParserNoRuleException({@required String cause}) : super(cause);
}

class ParserNoNodeForTokenException extends ParserException {
  const ParserNoNodeForTokenException({@required String cause}) : super(cause);
}

class ParserConflictException extends ParserException {
  const ParserConflictException({@required String cause}) : super(cause);
}

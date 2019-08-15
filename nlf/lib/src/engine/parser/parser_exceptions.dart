import '../../../neptune_language_framework.dart';

class ParserException implements Exception {
    String cause;

    @override
    String toString() => '$runtimeType: $cause';
}

class ParserStackEmptyException extends ParserException {
    @override
    String cause;

    ParserStackEmptyException({@required this.cause});
}

class ParserNoRuleException extends ParserException {
    @override
    String cause;

    ParserNoRuleException({@required this.cause});
}

class ParserNoNodeForTokenException extends ParserException {
    @override
    String cause;

    ParserNoNodeForTokenException({@required this.cause});
}

class ParserConflictException extends ParserException {
    @override
    String cause;

    ParserConflictException({@required this.cause});
}

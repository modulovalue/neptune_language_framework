import '../../neptune_lexer.dart';

class IntTokenLiteral extends RegexToken {
  const IntTokenLiteral() : super(r"^\d+");
}

class JsonNumberTokenLiteral extends RegexToken {
  const JsonNumberTokenLiteral()
      : super(r"^-?(?:0|[1-9]\d*)(?:\.\d+)?(?:[eE][+-]?\d+)?");
}

class StringWith2QuotesTokenLiteral extends RegexToken {
  static const String regexx = '("([^"]*)")|(\'([^\']*)\')';

  const StringWith2QuotesTokenLiteral() : super("^$regexx");
}

/// TODO check this literal, unicode support might be missing
class JSONStringTokenLiteral extends RegexToken {
  /// "([^\\"]|\\")*"
  static const String regexx = r'"([^\\"]|\\|\\")*"';

  const JSONStringTokenLiteral() : super("^$regexx");
}

class PositiveNumberTokenLiteral extends RegexToken {
  const PositiveNumberTokenLiteral() : super(r"^[+]?([.]\d+|\d+[.]?\d*)");
}

class SpacesLineTokenLiteral extends RegexToken {
  static const String regexx = r"(\f|\n|\r|\t|\v|\r\n| | )";

  const SpacesLineTokenLiteral() : super("^$regexx");
}

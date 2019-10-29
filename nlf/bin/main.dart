import 'package:neptune_language_framework/neptune_language_framework.dart';
import 'package:neptune_language_framework/src/examples/list.dart';

void main() {
  final lexer = ListLexer();
  final parser = ListParser();
  const input = "[qweqwe, 234,  134, 34, 34]";

  final lexerResult = lexer.lex(input);
  ParserResult parserResult;

  if (lexerResult.respone is LexerResponseSuccessful) {
    parserResult = parser.run(lexerResult.successfulResult);
    if (parserResult.response is! ParserResponseSuccessful) {
      print(parserResult.response.toString());
    }
  } else {
    print(lexerResult.respone.toString());
  }
  print(parserResult.response);
  print(parserResult.rootNode.runtimeType);
  print("-");
  print((parserResult.rootNode).visit(const ToStringTreeVisitor(false)));
}

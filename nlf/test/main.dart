import 'dart:async';

import 'package:neptune_language_framework/neptune_language_framework.dart';
import 'package:neptune_parser/neptune_parser.dart';
import 'package:neptune_lexer/neptune_lexer.dart';

Future main() async {
  print('Neptune Language Framework Evaluator');
  print('C-- Evaluator:');
  print('Enter code and press Enter:');

  jsonParseTest(
    '''
    {
              "lh좈T_믝Y伨\u001cꔌG爔겕ꫳ晚踍⿻읐T䯎]~e#฽燇5hٔ嶰`泯r;ᗜ쮪Q):/t筑,榄&5懶뎫狝(": [
                {
                  "2ፁⓛ]r3C攟וּ9賵s⛔6'ஂ|ⵈ鶆䐹禝3痰ࢤ霏䵩옆䌀?栕r7O簂Isd?K᫜`^讶}z8?z얰T:X倫⨎ꑹ": -6731128077618252000,
                  "|︦僰~m漿햭Y1'Vvخ굇ቍ챢c趖": [
                    null
                  ]
                }
              ],
              "虌魿閆5⛔煊뎰㞤ᗴꥰF䮥蘦䂪樳-K᝷-(^⃝_": 211318679791770600
            }
            ''',
    printTree: false,
  );
}

void neptuneplus(String input, {bool printTree = false}) =>
    executePipeline(input, TestLexer(), TestParser());

void mathexprs(String input, {bool printTree = false}) =>
    executePipeline(input, Test2Lexer(), Test2Parser());

void cminusminus(String input, {bool printTree = false}) =>
    executePipeline(input, CMinusMinusLexer(), CMinusMinusParser(),
        printTree: printTree);

void jsonParseTest(String input, {bool printTree = false}) =>
    executePipeline(input, JsonLexer(), JsonParser(), printTree: printTree);

void englishTest(String input, {bool printTree = false}) =>
    executePipeline(input, EnglishLexer(), EnglishParser(),
        printTree: printTree);

void executePipeline(
  String input,
  Lexer lexer,
  Parser parser, {
  bool printTree = false,
  Function(String) prettyPrintCallback,
}) {
  NLFController(lexer: lexer, parser: parser)
    ..run(
      input,
      parserResultCallback: (ParserResult result) {
        if (prettyPrintCallback != null) {
          prettyPrintCallback(
              result.rootNode.visit(const PrettyPrinterVisitor("", true)));
        }
      },
    )
    ..printInfoToConsole();
}

class NLFController {
  final Lexer lexer;
  final Parser parser;

  const NLFController({@required this.lexer, @required this.parser});

  factory NLFController.json() =>
      NLFController(lexer: JsonLexer(), parser: JsonParser());

  void run(String input,
      {Function(ParserResult) parserResultCallback,
      bool printExecutionTime = true}) {
    final lexerResult = lexer.lex(input);
    ParserResult parserResult;

    if (lexerResult.respone is LexerResponseSuccessful) {
      parserResult = parser.run(lexerResult.successfulResult);
      if (parserResult.response is! ParserResponseSuccessful) {
        print(parserResult.response.toString());
      }

      if (printExecutionTime) {
        print("Execution: "
            "${(parserResult.executionInfo.durationToExecute + lexerResult.executionInfo.durationToExecute).inMicroseconds / 1000000.0} s "
            "(L: ${lexerResult.executionInfo.durationToExecute.inMicroseconds / Duration.microsecondsPerSecond} s, "
            "P: ${parserResult.executionInfo.durationToExecute.inMicroseconds / Duration.microsecondsPerSecond} s)");
      }
    } else {
      print(lexerResult.respone.toString());
    }

    if (parserResultCallback != null) {
      parserResultCallback(parserResult);
    }

    print("\n");
  }

  void printInfoToConsole() {
    simpleLexerPrettyPrinter(JsonLexer());
    simpleParserPrettyPrinter(JsonParser());
  }
}

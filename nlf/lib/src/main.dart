import 'dart:async';

import '../neptune_language_framework.dart';
import '../neptune_plus_add_tokens.dart';

Future main() async {
    print('Neptune Language Framework Evaluator');
    print('C-- Evaluator:');
    print('Enter code and press Enter:');

//    File f = File("./test/json_test_files/draft6/maxLength.json");
//                  String json = f.readAsStringSync();
//                  jsonParseTest(json, printTree: false);
//    await Directory("./test/json_test_files/draft6").list().forEach((FileSystemEntity action) async {
//        if (FileSystemEntity.typeSync(action.path) != FileSystemEntityType.notFound) {
//            try {
//                print(action.path);
//                File f = File.fromUri(action.uri);
//                String json = f.readAsStringSync();
//                jsonParseTest(json, printTree: false);
//                print(json);
//                await Future.delayed(Duration(milliseconds: 3000), () {});
//            } catch (e) {
//
//            }
//        }
//    });

    jsonParseTest('''
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

//    var line = stdin.readLineSync(encoding: convert.utf8);
//    while (line != "exit") {
//        try {
//            englishTest(line, printTree: true);
//        } catch (e, s) {
//            print("$e $s");
//        }
//        line = stdin.readLineSync(encoding: convert.utf8);
//    }

}

void neptuneplus(String input, {bool printTree = false}) {
    executePipeline(input, TestLexer(), TestParser());
}

void mathexprs(String input, {bool printTree = false}) {
    executePipeline(input, Test2Lexer(), Test2Parser());
}

void cminusminus(String input, {bool printTree = false}) {
    executePipeline(input, CMinusMinusLexer(), CMinusMinusParser(), printTree: printTree);
}

void jsonParseTest(String input, {bool printTree = false}) {
    executePipeline(input, JsonLexer(), JsonParser(), printTree: printTree);
}

void englishTest(String input, {bool printTree = false}) {
    executePipeline(input, EnglishLexer(), EnglishParser(), printTree: printTree);
}

void executePipeline(String input,
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
                    prettyPrintCallback(result.rootNode.prettyPrint("", true));
                }
            },
        )
        ..printInfoToConsole();
}

class NLFController {

    Lexer lexer;
    Parser parser;

    NLFController({@required this.lexer, @required this.parser});

    factory NLFController.json() {
        return NLFController(lexer: JsonLexer(), parser: JsonParser());
    }

    void run(String input, {Function(ParserResult) parserResultCallback, bool printExecutionTime = true}) {
        final lexerResult = lexer.lex(input);
        ParserResult parserResult;

        if (lexerResult.respone is LexerResponseSuccessful) {
            parserResult = parser.run(lexerResult.successfulResult);
            if (parserResult.respone is! ParserResponseSuccessful) {
                print(parserResult.respone.toString());
            }

            if (printExecutionTime) {
                print("Execution: "
                    "${(parserResult.executionInfo.durationToExecute
                    + lexerResult.executionInfo.durationToExecute)
                    .inMicroseconds / 1000000.0} s "
                    "(L: ${lexerResult.executionInfo.durationToExecute.inMicroseconds /
                    Duration.microsecondsPerSecond} s, "
                    "P: ${parserResult.executionInfo.durationToExecute.inMicroseconds /
                    Duration.microsecondsPerSecond} s)");
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
        JsonLexer().prettyPrint();
        JsonParser().prettyPrint(prettyPrintRoot: true);
    }
}
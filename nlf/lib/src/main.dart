import 'dart:async';

import '../neptune_language_framework.dart';
import '../neptune_plus_addTokens.dart';

Future main() async {
    print('Neptune Language Framework Evaluator');
    print('C-- Evaluator:');
    print('Enter code and press Enter:');

//    File f = new File("./test/json_test_files/draft6/maxLength.json");
//                  String json = f.readAsStringSync();
//                  jsonParseTest(json, printTree: false);
//    await new Directory("./test/json_test_files/draft6").list().forEach((FileSystemEntity action) async {
//        if (FileSystemEntity.typeSync(action.path) != FileSystemEntityType.notFound) {
//            try {
//                print(action.path);
//                File f = new File.fromUri(action.uri);
//                String json = f.readAsStringSync();
//                jsonParseTest(json, printTree: false);
//                print(json);
//                await new Future.delayed(new Duration(milliseconds: 3000), () {});
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
    executePipeline(input, new TestLexer(), new TestParser());
}

void mathexprs(String input, {bool printTree = false}) {
    executePipeline(input, new Test2Lexer(), new Test2Parser());
}

void cminusminus(String input, {bool printTree = false}) {
    executePipeline(input, new CMinusMinusLexer(), new CMinusMinusParser(), printTree: printTree);
}

void jsonParseTest(String input, {bool printTree = false}) {
    executePipeline(input, new JsonLexer(), new JsonParser(), printTree: printTree);
}

void englishTest(String input, {bool printTree = false}) {
    executePipeline(input, new EnglishLexer(), new EnglishParser(), printTree: printTree);
}

void executePipeline(String input,
    Lexer lexer,
    Parser parser, {
        bool printTree = false,
        Function(String) prettyPrintCallback,
    }) {
    new NLFController(lexer: lexer, parser: parser)
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

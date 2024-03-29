import 'package:neptune_language_framework/neptune_language_framework.dart';
import 'package:test/test.dart';
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

void main() {
//    JsonLexer().prettyPrint();
//    JsonParser().prettyPrint();
    test('lone', () {
//        var printTree = false;
        parseTest("hi", true);
    });
}

void parseTest(String input, bool succeed, {bool printTree = false}) {
    executePipeline(input, EnglishLexer(), EnglishParser(), succeed, printTree: printTree);
}


void executePipeline(String input, Lexer lexer, Parser parser, bool succeed, {bool printTree = false}) {
    final lexerResult = lexer.lex(input);
    ParserResult parserResult;

//    print("Input: " + input);

    if (lexerResult.respone is LexerResponseSuccessful) {
        parserResult = parser.run(lexerResult.successfulResult);
        if (!(parserResult.response is ParserResponseSuccessful)) {
            print(parserResult.response.toString());
        }

        print("Execution: "
            "${(parserResult.durationToExecute
            + lexerResult.durationToExecute)
            .inMicroseconds / 1000000.0} s "
            "(L: ${lexerResult.durationToExecute.inMicroseconds / Duration.microsecondsPerSecond} s, "
            "P: ${parserResult.durationToExecute.inMicroseconds / Duration.microsecondsPerSecond} s)");

//        print(parserResult.rootNode.toStringTree(true));

    } else {
        print(lexerResult.respone.toString());
    }

//    print(lexerResult.successfulResult.map((f) => f.matchedString).join(""));
//    print(parserResult.rootNode.toStringTree(false));

    String a;
    String b = "-1";

    try {
        a = parserResult.rootNode?.visit(const ToStringTreeVisitor(true));
        b = lexerResult.successfulResult.map((f) => f.matchedString).join("");
    } catch (e, f) {
        print(e.toString() + " " + f.toString());
        if (succeed) {
            expect(true, false);
        } else {

        }
    }
    if (succeed) {
        print("$a $b");
        expect(a, b);
//        print(parserResult.rootNode.prettyPrint("", true));
    } else {
        print("$a $b");
        expect(a, isNot(b));
    }

//    if (printTree) {
//        print(input);
//    }

    print("\n");
}

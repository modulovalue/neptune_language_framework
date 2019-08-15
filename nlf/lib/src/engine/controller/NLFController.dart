import 'package:meta/meta.dart';

import '../../../neptune_language_framework.dart';
import '../../../neptune_plus_addTokens.dart';

class NLFController {

    Lexer lexer;
    Parser parser;

    NLFController({@required this.lexer, @required this.parser});

    factory NLFController.json() {
        return new NLFController(lexer: JsonLexer(), parser: JsonParser());
    }

    void run(String input, {Function(ParserResult) parserResultCallback, bool printExecutionTime = true}) {
        LexerResult lexerResult = lexer.lex(input);
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
        new JsonLexer().prettyPrint();
        new JsonParser().prettyPrint(prettyPrintRoot: true);
    }
}
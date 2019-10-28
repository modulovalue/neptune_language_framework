import 'package:neptune_language_framework/neptune_language_framework.dart';
import 'package:neptune_language_framework/neptune_plus_addTokens.dart';
import 'package:test/test.dart';

void main() {
     JsonLexer().prettyPrint();
     JsonParser().prettyPrint();
    test('lone', () {
        jsonParseTest("8239348 {}", false);
        var printTree = false;
        jsonParseTest('{"":', false, printTree: printTree);
        jsonParseTest('{}}', false, printTree: printTree);
        jsonParseTest('{', false, printTree: printTree);
        jsonParseTest('}]:', false, printTree: printTree);
        jsonParseTest('"   "', true, printTree: printTree);
        jsonParseTest('''
            {"widget": {
                "debug": "on"
            }}
     
        ''', true);

        jsonParseTest('''
        {
                "description": "the description of the test case",
                "schema": {"the schema that should" : "be validated against"},
                "tests": [
                    {
                        "description": "a specific test of a valid instance",
                        "data": "the instance",
                        "valid": true
                    },
                    {
                        "description": "another specific test this time, invalid",
                        "data": 15,
                        "valid": false
                    }
                ]
            }
            ''', true);
        jsonParseTest('''[[[[[[[[[[["Too deep"]]]]]]]]]]]''', true);
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
        ''', true);
//        jsonParseTest('''{"lh좈T_믝Y\"伨\u001cꔌG爔겕ꫳ晚踍⿻읐T䯎]~e#฽燇\"5hٔ嶰`泯r;ᗜ쮪Q):/t筑,榄&5懶뎫狝(":[{"2ፁⓛ]r3C攟וּ9賵s⛔6'ஂ|\"ⵈ鶆䐹禝3\"痰ࢤ霏䵩옆䌀?栕r7O簂Isd?K᫜`^讶}z8?z얰T:X倫⨎ꑹ":-6731128077618252000,"|︦僰~m漿햭\\Y1'Vvخ굇ቍ챢c趖":[null]}],"虌魿閆5⛔煊뎰㞤ᗴꥰF䮥蘦䂪樳-K᝷-(^⃝_":211318679791770600}''', true);
        jsonParseTest("[0E0]", true);
        jsonParseTest("[0e+1]", true);
        jsonParseTest("[1.0e+]", false);
        jsonParseTest("[0E]", false);
        jsonParseTest("[0E+]", false);
        jsonParseTest("["": 1]", false);
        jsonParseTest("[1,0A10A,1", false);
        jsonParseTest("[1,\n\n,1", false);
        jsonParseTest("[.2e-3]", false);
        jsonParseTest(r'{"":0}', true);
        jsonParseTest('{"a":"b","a":"b"}', true);
        jsonParseTest('{"x"::"b"}', false);
        jsonParseTest('{\'x"::"b"}', false);
        jsonParseTest("{key: 'value'}", false);
        jsonParseTest('{:"b"}', false);
        jsonParseTest("{1:1}", false);
        jsonParseTest("[123.456e-789]", true);
        jsonParseTest("[,1]", false);
        jsonParseTest("[-Infinity]", false);
        jsonParseTest("[0x42]", false);
        jsonParseTest('null', true, printTree: printTree);
        jsonParseTest('90242.424e+23', true, printTree: printTree);
        jsonParseTest('{"wefewf":"Ijio"}', true, printTree: printTree);
        jsonParseTest('[]', true, printTree: printTree);
        jsonParseTest('[232]', true, printTree: printTree);
    });
}

void jsonParseTest(String input, bool succeed, {bool printTree = false}) {
    executePipeline(input,  JsonLexer(),  JsonParser(), succeed, printTree: printTree);
}


void executePipeline(String input, Lexer lexer, Parser parser, bool succeed, {bool printTree = false}) {
    LexerResult lexerResult = lexer.lex(input);
    ParserResult parserResult;

//    print("Input: " + input);

    if (lexerResult.respone is LexerResponseSuccessful) {
        parserResult = parser.run(lexerResult.successfulResult);
        if (!(parserResult.respone is ParserResponseSuccessful)) {
            print(parserResult.respone.toString());
        }

        print("Execution: "
            "${(parserResult.executionInfo.durationToExecute
            + lexerResult.executionInfo.durationToExecute)
            .inMicroseconds / 1000000.0} s "
            "(L: ${lexerResult.executionInfo.durationToExecute.inMicroseconds / Duration.microsecondsPerSecond} s, "
            "P: ${parserResult.executionInfo.durationToExecute.inMicroseconds / Duration.microsecondsPerSecond} s)");

//        print(parserResult.rootNode.toStringTree(true));

    } else {
        print(lexerResult.respone.toString());
    }

//    print(lexerResult.successfulResult.map((f) => f.matchedString).join(""));
//    print(parserResult.rootNode.toStringTree(false));

    String a;
    String b = "-1";

    try {
        a = parserResult?.rootNode?.toStringTree(true);
        b = lexerResult.successfulResult.map((f) => f.matchedString).join("");
    } catch (e, f) {
        print(e.toString() + " " + f.toString());
        if (succeed) {
            expect(true, false);
        } else {

        }
    }
    if (succeed) {
        print("a");
        expect(a, b);
//        print(parserResult.rootNode.prettyPrint("", true));
    } else {
        print("b");
        expect(a, isNot(b));
    }

//    if (printTree) {
//        print(input);
//    }

    print("\n");
}

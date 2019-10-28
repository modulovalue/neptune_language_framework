import 'package:neptune_language_framework/neptune_language_framework.dart';
import 'package:test/test.dart';

void main() {
    test("1", () {
        final String delimiter = SpacesLineTokenLiteral.regexx;
        List<String> short(String str) {
            return Lexer.splitWithDelimiter(
                str,
                delimiter,
                [
                    StringWith2QuotesTokenLiteral.regexx
                ],
            );
        }

        const List<NeptuneTokenLiteral> literals = [
            TextTokenLiteral(),
            StringWith2QuotesTokenLiteral(),
            RightParanTokenLiteral(),
            LeftParanTokenLiteral(),
            SemicolonTokenLiteral(),
        ];

//        var a22 = short(r'    ok');
//        expect(a22, [
//            ' ', ' ', ' ', ' ', "ok"
//        ], reason: "a");
//        var aa22 = Lexer.collectMatches(a22, literals, delimiter);
//        var aa22first = aa22.successfulResult.first;
//        expect(aa22first.matchedString, "ok", reason: "a1");
//        expect(aa22first.positionFrom, 4, reason: "a2");
//        expect(aa22first.positionTo, 6, reason: "a3");
//
//        var a2 = short(r'ok    ');
//        expect(a2, [
//            "ok", ' ', ' ', ' ', ' '
//        ], reason: "b");
//        var aa2 = Lexer.collectMatches(a2, literals, delimiter);
//        var aa2first = aa2.successfulResult.first;
//        expect(aa2first.matchedString, "ok", reason: "b1");
//        expect(aa2first.positionFrom, 0, reason: "b2");
//        expect(aa2first.positionTo, 2, reason: "b3");
//

        final a222 = short(r' ok( "iug" ok   ok    ');
        expect(a222, [
            ' ', "ok(", " ", '"iug"', ' ', 'ok', ' ', ' ', ' ', 'ok', ' ', ' ', ' ', ' '
        ], reason: "c");
        final aa222 = Lexer.collectMatches(a222, literals, delimiter);
        final c11 = aa222.successfulResult[0];
        expect(c11.matchedString, "ok", reason: "c1");
        expect(c11.positionFrom, 1, reason: "c2");
        expect(c11.positionTo, 3, reason: "c3");
        final c22 = aa222.successfulResult[1];
        expect(c22.matchedString, "(", reason: "c4");
        expect(c22.positionFrom, 3, reason: "c5");
        expect(c22.positionTo, 4, reason: "c6");
        final c33 = aa222.successfulResult[2];
        expect(c33.matchedString, '"iug"', reason: "c7");
        expect(c33.positionFrom, 5, reason: "c8");
        expect(c33.positionTo, 10, reason: "c9");
        final c44 = aa222.successfulResult[3];
        expect(c44.matchedString, "ok", reason: "c10");
        expect(c44.positionFrom, 11, reason: "c11");
        expect(c44.positionTo, 13, reason: "c12");
        final c55 = aa222.successfulResult[4];
        expect(c55.matchedString, "ok", reason: "c13");
        expect(c55.positionFrom, 16, reason: "c14");
        expect(c55.positionTo, 18, reason: "c15");


        final a3 = short('''ok ok
\tok''');
        expect(a3, [
            "ok", ' ', "ok", '\n', '\t', 'ok',
        ], reason: "d");
        final d333 = Lexer.collectMatches(a3, literals, delimiter);
        final d33 = d333.successfulResult[0];
        expect(d33.matchedString, "ok", reason: "d1");
        expect(d33.positionFrom, 0, reason: "d2");
        expect(d33.positionTo, 2, reason: "d3");
        final d34 = d333.successfulResult[1];
        expect(d34.matchedString, "ok", reason: "d4");
        expect(d34.positionFrom, 3, reason: "d5");
        expect(d34.positionTo, 5, reason: "d6");
        final d3333 = d333.successfulResult[2];
        expect(d3333.matchedString, "ok", reason: "d10");
        expect(d3333.positionFrom, 7, reason: "d20");
        expect(d3333.positionTo, 9, reason: "d30");
        final a4 = short(r'ok ok  ');
        expect(a4, [
            "ok", ' ', "ok", ' ', ' '
        ], reason: "e");
//        var aa4 = Lexer.collectMatches(a4, literals, delimiter);


        final a = short(r'(ok "ok ok")  ok');
        expect(a, [
            "(ok", ' ', '"ok ok"', ")", " ", " ", "ok",
        ], reason: "f");
//        var aa = Lexer.collectMatches(a, literals, delimiter);


        final b = short(r'ok "ok ok" ok ');
        expect(b, [
            "ok", " ", '"ok ok"', " ", "ok", " ",
        ], reason: "g");
//        var bb = Lexer.collectMatches(b, literals, delimiter);


        final c = short(r'ok "ok ok"));; ok ok    ');
        expect(c, [
            "ok", " ", '"ok ok"', "));;", " ", "ok", " ", "ok", " ", " ", " ", " ",
        ], reason: "y");
//        var cc = Lexer.collectMatches(c, literals, delimiter);


        final d = short(r'  ok "ok ok" ok  ');
        expect(d, [
            " ", " ", "ok", " ", '"ok ok"', " ", "ok", " ", " ",
        ], reason: "x");
//        var dd = Lexer.collectMatches(d, literals, delimiter);


//        print("ok " + aa.toString());
    });
}
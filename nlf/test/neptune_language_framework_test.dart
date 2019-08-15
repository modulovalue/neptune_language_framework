import 'package:test/test.dart';

import '../lib/neptune_plus_addTokens.dart';
import '../lib/src/main.dart';

void main() {
    test('-', () {
        neptuneplus(
            "add BTC .0 and ETH 43902.0 and BTC 14 then open BTC and "
                "open XRP and open XRP and open XRP then open "
                "BTC and open XRP and open XRP and open XRP");
        neptuneplus("add BTC .0 and ETH 1");
        neptuneplus("open BTC and open XRP");
    });

    test('Basis operations', () {
        mathexprs("2 * 2");
        mathexprs("2 + 2");
        mathexprs("2 + 2 + 2 + 2 + 2");
        mathexprs("2 * 2");
        mathexprs("2 * 2 * 10 * 10");
        mathexprs("23 + 4 * 70");
        mathexprs("( )");
    });
    test('Basis parentheses', () {
        mathexprs("()");
        mathexprs("(2+2)");
        mathexprs("(2*2)");
    });
    test('multiple parenthesis', () {
        mathexprs("((2+2))*2");
        mathexprs("(2+2)*(2+2)");
        mathexprs("(2+(2*2))*(2+2)");
    });
    test('variables', () {
        mathexprs("ca * cc");
        mathexprs("( 2 + 2 ) * ok");
        mathexprs("( 2 + 2 ) * a * ( b * c )");
    });
    test('Emoji', () {
        mathexprs("ca * ☺️");
        mathexprs("( 2 + 2 ) * ok");
        mathexprs("( 2 + 2 ) * a * ( b * c )");
    });
    test('CMM', () {
        new CMinusMinusLexer().prettyPrint();
        new CMinusMinusParser().prettyPrint();
        cminusminus('   int  main ( ) {print("hu i");}');
        cminusminus("int main() { }");
        cminusminus('int mx ( ) {print();}');
        cminusminus("int mx ( ) { } int main ( ) { }");
        cminusminus("int mx ( int hallo , int hallo ) { }");
        cminusminus("int mx ( int hallo , int hallo ) { return 5000000 ; }");
        cminusminus(
            "int mx ( int hallo , int hallo ) { return 5000000 ; } int mx ( int hallo , int hallo ) { return 5000000 ; }");
////
        cminusminus('''
            int mx ( ) { 
                return 5000000 ; 
            } 
            
            int main ( ) { 
                int lo ; 
                int hi ; 
                lo = 1 ; 
                hi = lo ; 
                printf ( "%d" , hi ) ; 
                while ( hi < mx ( ) ) { 
                    printf ( "%d" , hi ) ; 
                    hi = lo + hi ; 
                    lo = hi - lo ; 
                    lo = hi * lo ; 
                } 
                return 0 ; 
            }
        ''');
        cminusminus('''
    int main() { 
        print("Hello World");
    }
        ''');
    });


//    new JsonLexer().prettyPrint();
//    new JsonParser().prettyPrint();
    test('JSON Parse test', () {
        jsonParseTest('{"widget":{"debug":"on"}}', printTree: true);
    });
}

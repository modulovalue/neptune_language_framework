import '../../neptune_language_framework.dart';

/// a subset of C
///
/// http://www.cse.chalmers.se/edu/year/2015/course/DAT150/lectures/bnfc-tutorial.html
///
/// No doubles present the the EXP expressions were changed to have
/// the next higher expression on the right of the operation symbol
///
///    ----------------- BNFC ----------------
///   comment "//" ;
///   comment "/*" "*/" ;
///
///   Prog. Program  ::= [Function] ;
///   Fun.  Function ::= Type Ident "(" [Decl] ")" "{" [Stm] "}" ;
///   Dec.  Decl     ::= Type [Ident] ;
///
///   terminator Function "" ;
///   terminator Stm "" ;
///   separator  Decl "," ;
///   separator  nonempty Ident "," ;
///
///   SDecl.   Stm ::= Decl ";"  ;
///   SExp.    Stm ::= Exp ";" ;
///   SBlock.  Stm ::= "{" [Stm] "}" ;
///   SWhile.  Stm ::= "while" "(" Exp ")" Stm ;
///   SReturn. Stm ::= "return" Exp  ";" ;
///
///   EAss.    Exp  ::= Ident "=" Exp ;
///   ELt.     Exp1 ::= Exp2 "<" Exp2 ;
///   EAdd.    Exp2 ::= Exp2 "+" Exp3 ;
///   ESub.    Exp2 ::= Exp2 "-" Exp3 ;
///   EMul.    Exp3 ::= Exp3 "*" Exp4 ;
///   Call.    Exp4 ::= Ident "(" [Exp] ")" ;
///   EVar.    Exp4 ::= Ident ;
///   EStr.    Exp4 ::= String ;
///   EInt.    Exp4 ::= Integer ;
///   EDouble. Exp4 ::= Double ;
///
///   coercions Exp 4 ;
///
///   separator Exp "," ;
///
///   TInt.    Type ::= "int" ;
///   TDouble. Type ::= "double" ;
///
///
///
///  ----------- Example Program -----------------
///
/// // a fibonacci function showing most features of the CMM language
///     int mx ()
///     {
///       return 5000000 ;
///     }
///
///     int main ()
///     {
///       int lo ;
///       int hi ;
///       lo = 1 ;
///       hi = lo ;
///       printf("%d",lo) ;
///       while (hi < mx()) {
///         printf("%d",hi) ;
///         hi = lo + hi ;
///         lo = hi - lo ;
///       }
///     return 0 ;
///     }


/// Lexer -------------------------
class CMinusMinusLexer extends Lexer {
    @override
    List<NeptuneTokenLiteral> literals() {
        return [
//
//            /// Braces
//            ///
            new RightCurlyTokenLiteral(),
            new LeftCurlyTokenLiteral(),
            new RightParanTokenLiteral(),
            new LeftParanTokenLiteral(),

            /// Math symbols
            ///
            new EqualsTokenLiteral(),
            new LessSymTokenLiteral(),
            new AddSymTokenLiteral(),
            new MinusSymTokenLiteral(),
            new MulSymTokenLiteral(),

            /// Separate
            ///
            new SemicolonTokenLiteral(),
            new CommaSymTokenLiteral(),

            /// Keywords
            ///
            new WhileTokenLiteral(),
            new ReturnTokenLiteral(),

            /// Type Names
            ///
            new IntTypeTokenLiteral(),
            new StringTypeTokenLiteral(),
            new TextTokenLiteral(),

            /// Type Literals
            ///
            new IntTokenLiteral(),
            new StringWith2QuotesTokenLiteral(),
        ];
    }

    @override
    String delimiter() => SpacesLineTokenLiteral.regex;

    @override
    List<String> dontRemoveDelimiterInThisRegex() {
        return [
            StringWith2QuotesTokenLiteral.regex
        ];
    }
}

/// Parser ------------------------
class CMinusMinusParser extends Parser {
    @override
    NodeType root() {
        return new Programm();
    }
}

/// Nodes -----------------
class Programm extends NodeType {
    @override
    ListOfRules rules() =>
        function.directList().wrap()
    ;
}

class Functionn extends NodeType {
    @override
    ListOfRules rules() =>
        type + textTokenLiteral + leftParan + decl.list(commaSymTokenLiteral) + rightParan + leftCurly + rightCurly
        | type + textTokenLiteral + leftParan + rightParan + leftCurly + rightCurly
        | type + textTokenLiteral + leftParan + rightParan + leftCurly + stm.directList() + rightCurly
        | type + textTokenLiteral + leftParan + decl.list(commaSymTokenLiteral) + rightParan + leftCurly +
            stm.directList() +
            rightCurly
    ;
}

NodeType function = new Functionn();

class Declaration extends NodeType {
    @override
    ListOfRules rules() =>
        (type + textTokenLiteral).wrap()
    ;
}

NodeType decl = new Declaration();

class Statement extends NodeType {
    @override
    ListOfRules rules() =>
        decl + semicolon
        | exp + semicolon
        | leftCurly + stm.directList() + rightCurly
        | leftCurly + rightCurly
        | whilee + leftParan + exp + rightParan + stm
        | returnn + exp + semicolon
    ;
}

NodeType stm = new Statement();


class Expression extends NodeType {
    @override
    ListOfRules rules() =>
        textTokenLiteral + equals + exp
        | exp1 // coersion 0
        ;
}

NodeType exp = new Expression();


class Expression1 extends NodeType {
    @override
    ListOfRules rules() {
        return exp2 + lessSymTokenLiteral + exp2
        | exp2 // coersion 1
            ;
    }
}

NodeType exp1 = new Expression1();

class Expression2 extends NodeType {
    @override
    ListOfRules rules() =>
        exp3 + addSymTokenLiteral + exp2
        | exp3 + minusSymTokenLiteral + exp2
        | exp3 // coersion 2
        ;
}

NodeType exp2 = new Expression2();

class Expression3 extends NodeType {
    @override
    ListOfRules rules() =>
        exp4 + mulSymTokenLiteral + exp3
        | exp4 // coersion 3
        ;
}

NodeType exp3 = new Expression3();

class Expression4 extends NodeType {
    @override
    ListOfRules rules() =>
        textTokenLiteral + leftParan + exp.list(commaSymTokenLiteral) + rightParan
        | textTokenLiteral + leftParan + rightParan
        | textTokenLiteral
        | stringW2QTokenLiteral
        | intTokenLiteral
        | leftParan + exp + rightParan // coersion 4
        ;
}

NodeType exp4 = new Expression4();


class Typee extends NodeType {
    @override
    ListOfRules rules() =>
        intType
        | stringType

    /// TODO add double
    ;
}

NodeType type = new Typee();



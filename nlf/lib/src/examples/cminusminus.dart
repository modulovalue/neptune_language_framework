import 'package:neptune_language_framework/src/preset_tokens.dart';
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

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

  const CMinusMinusLexer();

  @override
  List<NeptuneTokenLiteral> literals() {
    return const [
      /// Braces
      ///
      RightCurlyTokenLiteral(),
      LeftCurlyTokenLiteral(),
      RightParanTokenLiteral(),
      LeftParanTokenLiteral(),

      /// Math symbols
      ///
      EqualsTokenLiteral(),
      LessSymTokenLiteral(),
      AddSymTokenLiteral(),
      MinusSymTokenLiteral(),
      MulSymTokenLiteral(),

      /// Separate
      ///
      SemicolonTokenLiteral(),
      CommaSymTokenLiteral(),

      /// Keywords
      ///
      WhileTokenLiteral(),
      ReturnTokenLiteral(),

      /// Type Names
      ///
      IntTypeTokenLiteral(),
      StringTypeTokenLiteral(),
      TextTokenLiteral(),

      /// Type Literals
      ///
      IntTokenLiteral(),
      StringWith2QuotesTokenLiteral(),
    ];
  }

  @override
  String delimiter() => SpacesLineTokenLiteral.regexx;

  @override
  List<String> dontRemoveDelimiterInThisRegex() => [StringWith2QuotesTokenLiteral.regexx];
}

/// Parser ------------------------
class CMinusMinusParser extends Parser<CMMNode> {
  const CMinusMinusParser();

  @override
  CMMNode root() => Programm();
}

/// Nodes -----------------
abstract class CMMNode extends NodeType {
  T visit<T>(CMMVisitor<T> visitor);
}

class Programm extends CMMNode {
  @override
  ListOfRules rules() => function.directList().wrap();

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.program(this);
}

class Functionn extends CMMNode {
  @override
  ListOfRules rules() =>
      type +
          textTokenLiteral +
          leftParan +
          decl.list(commaSymTokenLiteral) +
          rightParan +
          leftCurly +
          rightCurly |
      type +
          textTokenLiteral +
          leftParan +
          rightParan +
          leftCurly +
          rightCurly |
      type +
          textTokenLiteral +
          leftParan +
          rightParan +
          leftCurly +
          stm.directList() +
          rightCurly |
      type +
          textTokenLiteral +
          leftParan +
          decl.list(commaSymTokenLiteral) +
          rightParan +
          leftCurly +
          stm.directList() +
          rightCurly;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.function(this);
}

NodeType function = Functionn();

class Declaration extends CMMNode {
  @override
  ListOfRules rules() => (type + textTokenLiteral).wrap();

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.declaration(this);
}

NodeType decl = Declaration();

class Statement extends CMMNode {
  @override
  ListOfRules rules() =>
      decl + semicolon |
      exp + semicolon |
      leftCurly + stm.directList() + rightCurly |
      leftCurly + rightCurly |
      whilee + leftParan + exp + rightParan + stm |
      returnn + exp + semicolon;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.statement(this);
}

NodeType stm = Statement();

class Expression extends CMMNode {
  @override
  ListOfRules rules() => textTokenLiteral + equals + exp | exp1 // coersion 0
      ;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.expression(this);
}

NodeType exp = Expression();

class Expression1 extends CMMNode {
  @override
  ListOfRules rules() {
    return exp2 + lessSymTokenLiteral + exp2 | exp2 // coersion 1
        ;
  }

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.expression1(this);
}

NodeType exp1 = Expression1();

class Expression2 extends CMMNode {
  @override
  ListOfRules rules() =>
      exp3 + addSymTokenLiteral + exp2 |
      exp3 + minusSymTokenLiteral + exp2 |
      exp3 // coersion 2
      ;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.expression2(this);
}

NodeType exp2 = Expression2();

class Expression3 extends CMMNode {
  @override
  ListOfRules rules() => exp4 + mulSymTokenLiteral + exp3 | exp4 // coersion 3
      ;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.expression3(this);
}

NodeType exp3 = Expression3();

class Expression4 extends CMMNode {
  @override
  ListOfRules rules() =>
      textTokenLiteral +
          leftParan +
          exp.list(commaSymTokenLiteral) +
          rightParan |
      textTokenLiteral + leftParan + rightParan |
      textTokenLiteral |
      stringW2QTokenLiteral |
      intTokenLiteral |
      leftParan + exp + rightParan // coersion 4
      ;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.expression4(this);
}

NodeType exp4 = Expression4();

class Typee extends CMMNode {
  @override
  ListOfRules rules() => intType | stringType /* TODO add double */;

  @override
  T visit<T>(CMMVisitor<T> visitor) => visitor.type(this);
}

NodeType type = Typee();

abstract class CMMVisitor<T> {
  T program(Programm node);

  T function(Functionn node);

  T declaration(Declaration node);

  T statement(Statement node);

  T expression(Expression node);

  T expression1(Expression1 node);

  T expression2(Expression2 node);

  T expression3(Expression3 node);

  T expression4(Expression4 node);

  T type(Typee node);
}

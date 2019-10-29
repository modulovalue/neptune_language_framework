import 'package:neptune_lexer/neptune_lexer.dart';

void simpleLexerPrettyPrinter(Lexer lexer) {
  printTemplate(printHeader: () {
    paddedPrint(r" _                                     _                 ");
    paddedPrint(r"| |                                   | |                ");
    paddedPrint(r"| |     _____  _____ _ __  __   ____ _| |_   _  ___  ___ ");
    paddedPrint(r"| |    / _ \ \/ / _ \ '__| \ \ / / _` | | | | |/ _ \/ __|");
    paddedPrint(r"| |___|  __/>  <  __/ |     \ V / (_| | | |_| |  __/\__ \");
    paddedPrint(r"\_____/\___/_/\_\___|_|      \_/ \__,_|_|\__,_|\___||___/");
  }, printBody: () {
    paddedPrint("Lexer", lexer.runtimeType.toString());
    paddedPrint("Delimiter", lexer.delimiter());
    paddedPrint(
        "Dont split this", lexer.dontRemoveDelimiterInThisRegex().join(", "));

    paddedPrint("");

    lexer.literals().asMap().forEach((int index, NeptuneTokenLiteral f) {
      paddedPrint("Literal " + index.toString() + ":",
          f.toString().padRight(27) + "$greenClr${f.runtimeType}$resetCode");
    });
  });
}

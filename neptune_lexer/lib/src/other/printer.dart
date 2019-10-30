import 'package:neptune_lexer/neptune_lexer.dart';

String simpleLexerPrettyPrinterText(Lexer lexer, PaddedText pad) {
  return printTextTemplate(
      printHeader: () {
        String ret = "";
        ret +=
            pad(r" _                                     _                 ");
        ret +=
            pad(r"| |                                   | |                ");
        ret +=
            pad(r"| |     _____  _____ _ __  __   ____ _| |_   _  ___  ___ ");
        ret +=
            pad(r"| |    / _ \ \/ / _ \ '__| \ \ / / _` | | | | |/ _ \/ __|");
        ret +=
            pad(r"| |___|  __/>  <  __/ |     \ V / (_| | | |_| |  __/\__ \");
        ret +=
            pad(r"\_____/\___/_/\_\___|_|      \_/ \__,_|_|\__,_|\___||___/");
        return ret;
      },
      printBody: () {
        String ret = "";
        ret += pad("Lexer", second: lexer.runtimeType.toString());
        ret += pad("Delimiter", second: lexer.delimiter());
        ret += pad("Dont split this",
            second: lexer.dontRemoveDelimiterInThisRegex().join(", "));

        ret += pad("");

        lexer.literals().asMap().forEach((int index, NeptuneTokenLiteral f) {
          ret += pad(
            "Literal " + index.toString() + ":",
            second: f.toString().padRight(27),
          );
        });
        return ret;
      },
      pad: pad);
}

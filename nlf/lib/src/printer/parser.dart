import '../../neptune_language_framework.dart';

abstract class ParserPrinter {
    const ParserPrinter();

    void prettyPrint(Parser lexer);
}

class SimpleParserPrinter extends ParserPrinter {

    const SimpleParserPrinter();

    @override
    void prettyPrint(Parser parser) {
        parser.printTemplate(printHeader: () {
            paddedPrint(r"______                                     _                 ");
            paddedPrint(r"| ___ \                                   | |                ");
            paddedPrint(r"| |_/ /_ _ _ __ ___  ___ _ __  __   ____ _| |_   _  ___  ___ ");
            paddedPrint(r"|  __/ _` | '__/ __|/ _ \ '__| \ \ / / _` | | | | |/ _ \/ __|");
            paddedPrint(r"| | | (_| | |  \__ \  __/ |     \ V / (_| | | |_| |  __/\__ \");
            paddedPrint(r"\_|  \__,_|_|  |___/\___|_|      \_/ \__,_|_|\__,_|\___||___/");
        }, printBody: () {
            paddedPrint("Parser", parser.runtimeType.toString());
            paddedPrint("Root", parser
                .root()
                .runtimeType
                .toString());
        });
    }
}

import 'package:meta/meta.dart';

import '../../neptune_language_framework.dart';


/// go to
/// http://patorjk.com/software/taag/#p=display&f=Doom&t=Parser%20values%0A
/// for 3d ascii
///
abstract class PrettyPrinter {
    void prettyPrint();
}

class PrettyPrinterTemplate {
    static void printTemplate({@required Function() printHeader, Function() printBody}) {
        printHeader();
        paddedPrint("\n");
        printBody();
        paddedPrint("");
        paddedPrint("-------------------------------------------------------\n");
    }
}
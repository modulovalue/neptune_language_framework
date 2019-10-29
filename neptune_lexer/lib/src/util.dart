import 'package:meta/meta.dart';

Duration stopwatch(Function() f) {
    final Stopwatch stopwatch = Stopwatch()
        ..start();
    f();
    stopwatch.stop();
    return stopwatch.elapsed;
}

const String blackClr = "\u001b[30m";
const String redClr = "\u001b[31m";
const String greenClr = "\u001b[32m";
const String yellowClr = "\u001b[33m";
const String blueClr = "\u001b[34m";
const String magentaClr = "\u001b[35m";
const String cyanClr = "\u001b[36m";
const String whiteClr = "\u001b[37m";
const String resetCode = "\u001B[0m";

void paddedPrint(String first, [String second, int padding = 25]) {
    print("$yellowClr ${first.padRight(padding, " ")}"
        "${second != null ? "$whiteClr::=$resetCode"
        : ""} $resetCode ${second ?? ""}");
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
import 'package:meta/meta.dart';

Duration stopwatch(Function() f) {
  final Stopwatch stopwatch = Stopwatch()..start();
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

typedef PaddedText = String Function(String first, {String second, int padding});

String paddedTextConsole(String first, {String second, int padding = 25}) {
  return "$yellowClr ${first.padRight(padding, " ")}"
      "${second != null ? "$whiteClr::=$resetCode" : ""} $resetCode ${second ?? ""}\n";
}

String paddedTextPure(String first, {String second, int padding = 25}) {
  return "${first.padRight(padding, " ")}${second != null ? "::=" : ""} ${second ?? ""} \n";
}

String printTextTemplate({
  @required PaddedText pad,
  @required String Function() printHeader,
  String Function() printBody,
}) {
  String ret = "";
  ret += printHeader();
  ret += pad("\n");
  ret += printBody();
  ret += pad("");
  ret += pad("-------------------------------------------------------\n");
  return ret;
}

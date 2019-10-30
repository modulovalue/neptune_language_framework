import 'package:flutter/material.dart';
import 'package:modulovalue_project_widgets/all.dart';
import 'package:neptune_language_framework/neptune_language_framework.dart';
import 'package:neptune_lexer/neptune_lexer.dart';
import 'package:neptune_parser/neptune_parser.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NLF',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Center(
          child: ListView(
            padding: const EdgeInsets.all(18.0),
            shrinkWrap: true,
            children: [
              LexerDemo(),
            ],
          ),
        ),
      ),
    );
  }
}

class LexerDemo extends StatefulWidget {
  @override
  _LexerDemoState createState() => _LexerDemoState();
}

class _LexerDemoState extends State<LexerDemo> {
  String text = "";

  MapEntry<Lexer, Parser> combo =
      const MapEntry(CMinusMinusLexer(), CMinusMinusParser());

  Widget viewInfo() {
    return Center(
      child: Wrap(
        spacing: 8.0,
        children: <Widget>[
          FlatButton(
            child: const Text("View Lexer Info"),
            onPressed: () {
              final text =
                  simpleLexerPrettyPrinterText(combo.key, paddedTextPure);
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Lexer"),
                    content: SingleChildScrollView(child: Text(text)),
                  );
                },
              );
            },
          ),
          FlatButton(
            child: const Text("View Parser Info"),
            onPressed: () {
              final text =
                  simpleParserPrettyPrinterText(combo.value, paddedTextPure);
              showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text("Parser"),
                    content: SingleChildScrollView(child: Text(text)),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }

  Widget selectCombo() {
    Widget _make(String str, MapEntry<Lexer, Parser> c) {
      return FlatButton(
        color: combo == c ? Colors.blue : null,
        child: Text(str,
            style: combo == c ? TextStyle(color: Colors.white) : null),
        onPressed: () => setState(() => combo = c),
      );
    }

    return Center(
      child: Wrap(
        spacing: 8.0,
        children: <Widget>[
          _make("C--", const MapEntry(CMinusMinusLexer(), CMinusMinusParser())),
          _make("JSON", const MapEntry(JsonLexer(), JsonParser())),
          _make("English", const MapEntry(EnglishLexer(), EnglishParser())),
          _make("Math", const MapEntry(MathLexer(), MathParser())),
          _make("List", const MapEntry(ListLexer(), ListParser())),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lexResult = combo.key.lex(text);
    final parseResult = combo.value.run(lexResult.successfulResult);

    return ListView(
      shrinkWrap: true,
      children: [
        ...modulovalueTitle("NLF Lexer Demo", "neptune_language_framework"),
        const SizedBox(height: 8.0),
        selectCombo(),
        const SizedBox(height: 8.0),
        viewInfo(),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextField(
              decoration: const InputDecoration(
                helperText: "Your Text",
              ),
              onChanged: (t) => setState(() => text = t),
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(height: 1.0, color: Colors.grey),
        ),
        Opacity(
          opacity: 0.4,
          child: Center(
            child: Text(
              "Execution in: ${lexResult.durationToExecute.inMicroseconds / 1000}ms \nResponse: ${lexResult.respone}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 18.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 4.0,
          children: [
            ...lexResult.successfulResult.map(
              (LexerMatchResult match) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.blue,
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: DefaultTextStyle(
                    style: TextStyle(color: Colors.white),
                    child: Column(
                      children: [
                        Text(match.matchedString),
                        Text(match.token.describe()),
                        if (match.left != null) Text(match.left),
                        Text("${match.status} " +
                            match.positionFrom.toString() +
                            "-" +
                            match.positionTo.toString()),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Container(height: 1.0, color: Colors.grey),
        ),
        Opacity(
          opacity: 0.4,
          child: Center(
            child: Text(
              "Execution in: ${parseResult.durationToExecute.inMicroseconds / 1000}ms \nResponse: ${parseResult.response}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Text(
            parseResult.rootNode?.visit(const ToStringTreeVisitor(true)) ?? "/",
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 8.0),
        Center(
          child: Text(
            parseResult.rootNode?.visit(const PrettyPrinterVisitor("  ", false, noColor: true)) ?? "/",
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 8.0),
        Wrap(
          spacing: 12.0,
          runSpacing: 4.0,
          children: [],
        ),
      ],
    );
  }
}

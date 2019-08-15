import '../../../neptune_language_framework.dart';

abstract class ParserAction {

    void actionMap(ASTNode type);

    void run(ASTNode node) {
        print("BEGIN ACTIONS --------------");
        if (node != null) {
            actionMap(node);
        } else {
            print("node was null");
        }
        print("STOP  ACTIONS --------------");
    }
}


import '../../../neptune_language_framework.dart';

class ListOfRules {

    List<Rule> rules = [];

    ListOfRules(this.rules);

    List<List<NodeType>> get rulesLists {
        return rules.map((Rule f) => f.nodes).toList();
    }

    ListOfRules operator |(Rule other) {
        return new ListOfRules(rules..add(other));
    }
}

abstract class Rule {

    List<NodeType> nodes;

    Rule operator +(Rule other) {
        return new RuleImpl()
            ..nodes = (nodes..addAll(other.nodes));
    }

    ListOfRules operator |(Rule other) {
        return new ListOfRules([this, other]);
    }

    ListOfRules wrap() {
        return new ListOfRules([this]);
    }
}

class RuleImpl extends Rule {
    @override
    List<NodeType> nodes;

    RuleImpl([this.nodes = const []]);
}
import '../../neptune_parser.dart';

abstract class Rule {
  List<NodeType> nodes();

  const Rule();

  Rule operator +(Rule other) => RuleImpl(nodes()..addAll(other.nodes()));

  ListOfRules operator |(Rule other) => ListOfRules([this, other]);

  ListOfRules wrap() => ListOfRules([this]);
}

class RuleImpl extends Rule {
  final List<NodeType> _nodes;

  const RuleImpl([this._nodes]) : super();

  @override
  List<NodeType> nodes() => _nodes;
}

class ListOfRules {
  final List<Rule> rules;

  const ListOfRules(this.rules);

  List<List<NodeType>> get rulesLists =>
      rules.map((Rule f) => f.nodes()).toList();

  ListOfRules operator |(Rule other) => ListOfRules(rules..add(other));
}

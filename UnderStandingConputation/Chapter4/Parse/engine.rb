require_relative '../../lib/lexical-analyzer.rb'
require_relative '../../lib/pda-rule.rb'
require_relative '../../lib/pda-configuration.rb'
require_relative '../../lib/npda-rulebook.rb'
require_relative '../../lib/npda-design.rb'
require_relative '../../lib/npda.rb'
require_relative '../../lib/stack.rb'

def start_rule
  PDARule.new(1, nil, 2, '$', ['S', '$'])
end

def symbol_rules
  [
    PDARule.new(2, nil, 2, 'S', ['W']),
    PDARule.new(2, nil, 2, 'S', ['A']),
    PDARule.new(2, nil, 2, 'W', ['w', '(', 'E', ')', '{', 'S', '}']),
    PDARule.new(2, nil, 2, 'A', ['v', '=', 'E']),
    PDARule.new(2, nil, 2, 'E', ['L']),
    PDARule.new(2, nil, 2, 'L', ['M', '<', 'L']),
    PDARule.new(2, nil, 2, 'L', ['M']),
    PDARule.new(2, nil, 2, 'M', ['T', '*', 'M']),
    PDARule.new(2, nil, 2, 'M', ['T']),
    PDARule.new(2, nil, 2, 'T', ['n']),
    PDARule.new(2, nil, 2, 'T', ['v'])
  ]
end

def token_rules
  LexicalAnalyzer::GRAMMAR.map do |rule|
    PDARule.new(2, rule[:token], 2, rule[:token], [])
  end
end

def stop_rule
  PDARule.new(2, nil, 3, '$', ['$'])
end

def rulebook
  NPDARulebook.new([start_rule, stop_rule] + symbol_rules + token_rules)
end

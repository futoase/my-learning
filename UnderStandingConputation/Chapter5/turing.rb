require_relative '../lib/tape.rb'
require_relative '../lib/turing-machine.rb'
require_relative '../lib/dtm-rulebook.rb'
require_relative '../lib/dtm.rb'

def tape
  Tape.new(['1', '0', '1'], '1', [], '_')
end

def rule
  TMRule.new(1, '0', 2, '1', :right)
end

def rulebook
  DTMRulebook.new([
    TMRule.new(1, '0', 2, '1', :right),
    TMRule.new(1, '1', 1, '0', :left),
    TMRule.new(1, '_', 2, '1', :right),
    TMRule.new(2, '0', 2, '0', :right),
    TMRule.new(2, '1', 2, '1', :right),
    TMRule.new(2, '_', 3, '_', :left)
  ])
end

def get_dtm
  DTM.new(TMConfiguration.new(1, tape), [3], rulebook)
end

def scan_string_rulebook
  DTMRulebook.new([
    TMRule.new(1, 'X', 1, 'X', :right),
    TMRule.new(1, 'a', 2, 'X', :right),
    TMRule.new(1, '_', 6, '_', :left),

    TMRule.new(2, 'a', 2, 'a', :right),
    TMRule.new(2, 'X', 2, 'X', :right),
    TMRule.new(2, 'b', 3, 'X', :right),

    TMRule.new(3, 'b', 3, 'b', :right),
    TMRule.new(3, 'X', 3, 'X', :right),
    TMRule.new(3, 'c', 4, 'X', :right),

    TMRule.new(4, 'c', 4, 'c', :right),
    TMRule.new(4, '_', 5, '_', :left),

    TMRule.new(5, 'a', 5, 'a', :left),
    TMRule.new(5, 'b', 5, 'b', :left),
    TMRule.new(5, 'c', 5, 'c', :left),
    TMRule.new(5, 'X', 5, 'X', :left),
    TMRule.new(5, '_', 1, '_', :right)
  ])
end

def copy_first
  DTMRulebook.new([
    TMRule.new(1, 'a', 2, 'a', :right),
    TMRule.new(1, 'b', 3, 'b', :right),
    TMRule.new(1, 'c', 4, 'c', :right),

    TMRule.new(2, 'a', 2, 'a', :right),
    TMRule.new(2, 'b', 2, 'b', :right),
    TMRule.new(2, 'c', 2, 'c', :right),
    TMRule.new(2, '_', 5, 'a', :right),

    TMRule.new(3, 'a', 3, 'a', :right),
    TMRule.new(3, 'b', 3, 'b', :right),
    TMRule.new(3, 'c', 3, 'c', :right),
    TMRule.new(3, '_', 5, 'b', :right),

    TMRule.new(4, 'a', 4, 'a', :right),
    TMRule.new(4, 'b', 4, 'b', :right),
    TMRule.new(4, 'c', 4, 'c', :right),
    TMRule.new(4, '_', 5, 'c', :right)
  ])
end

def increment_rules(start_state, return_state)
  incrementing = start_state
  finishing = Object.new
  finished = return_state

  [
    TMRule.new(incrementing, '0', finishing,    '1', :right),
    TMRule.new(incrementing, '1', incrementing, '0', :left),
    TMRule.new(incrementing, '_', finishing,    '1', :right),
    TMRule.new(finishing,    '0', finishing,    '0', :right),
    TMRule.new(finishing,    '1', finishing,    '1', :right),
    TMRule.new(finishing,    '_', finished,     '_', :left)
  ]
end

def increment_rulebook
  added_zero, added_one, added_two, added_three = 0, 1, 2, 3
  DTMRulebook.new(
    increment_rules(added_zero, added_one) +
    increment_rules(added_one, added_two) +
    increment_rules(added_two, added_three)
  )
end

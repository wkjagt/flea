Flea::StandardLibrary.add_native *[
  :-,
  Proc.new() do |arguments, interpreter|
    tmp = arguments.map {|item| interpreter.evaluate(item) }
    tmp.inject {|sum, n| sum - n }
  end
]

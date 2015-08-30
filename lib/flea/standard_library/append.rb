Flea::StandardLibrary.add_native *[
  :append,
  Proc.new() do |arguments, interpreter|

    arguments.map {|x| interpreter.evaluate(x) }.flatten
  end
]

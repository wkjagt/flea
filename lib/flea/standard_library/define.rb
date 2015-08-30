Flea::StandardLibrary.add_native *[
  :define,
  Proc.new() do |arguments, interpreter|
    interpreter.env.define(arguments[0], interpreter.evaluate(arguments[1]))
  end
]

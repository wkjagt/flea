Flea::StandardLibrary.add_native *[
  'string-to-num'.to_sym,
  Proc.new() do |arguments, interpreter|
    interpreter.evaluate(arguments[0]).to_i
  end
]

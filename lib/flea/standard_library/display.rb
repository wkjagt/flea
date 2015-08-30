Flea::StandardLibrary.add_native *[
  :display,
  Proc.new() do |arguments, interpreter|
    output = interpreter.evaluate(arguments[0])
    puts interpreter.parser.to_sexp(output)
    output
  end
]

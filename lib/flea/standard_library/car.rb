Flea::StandardLibrary.add_native *[
  :car,
  Proc.new() do |argument, interpreter|
    list = interpreter.evaluate(argument[0])
    list[0]
  end
]

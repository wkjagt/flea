[
  :rand,
  Proc.new() do |arguments, interpreter|
    rand(interpreter.evaluate(arguments[0]))
  end
]

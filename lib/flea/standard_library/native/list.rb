[
  :list,
  Proc.new() do |arguments, interpreter|
    arguments.map {|x|
      interpreter.evaluate(x)
    }
  end
]

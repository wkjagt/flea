[
  :list?,
  Proc.new() do |arguments, interpreter|
    interpreter.evaluate(arguments[0]).is_a? Array
  end
]

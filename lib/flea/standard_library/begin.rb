Flea::StandardLibrary.add_native *[
  :begin,
  Proc.new() do |arguments, interpreter|
    val = nil
    arguments.each do |i|
      val = interpreter.evaluate(i)
    end

    val
  end
]

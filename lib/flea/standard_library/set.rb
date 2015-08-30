Flea::StandardLibrary.add_native *[
  :set!,
  Proc.new() do |arguments, interpreter|
    if( interpreter.env.find(arguments[0]) == nil)
      raise 'Cannot set unbound variable ' + arguments[0].to_s
    end
    interpreter.env.define(arguments[0], arguments[1])
  end
]

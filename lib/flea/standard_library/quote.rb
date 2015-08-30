Flea::StandardLibrary.add_native *[
  :quote,
  Proc.new() do |arguments, interpreter|
    arguments[0]
  end
]

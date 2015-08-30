Flea::StandardLibrary.add_native *[
  :gets,
  Proc.new() do |arguments, interpreter|
    $stdin.gets
  end
]

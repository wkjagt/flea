[
  :read,
  Proc.new() do |arguments, interpreter|
    interpreter.parser.parse_string($stdin.gets)
  end
]

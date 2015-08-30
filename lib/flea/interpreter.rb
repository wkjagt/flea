module Flea
  class Interpreter
    attr_accessor :parser, :env

    def initialize(options = {}, env: Environment.new)
      @env = env
      StandardLibrary.new(self).load
    end

    def run(program)
      Parser.new(program).parse.map { |exp| evaluate(exp) }.last
    end

    def evaluate(expression)
      return @env.find(expression) if expression.is_a? Symbol
      return expression unless expression.is_a? Array

      call_function(*expression)
    end

    private

    def call_function(function_name, *arguments)
      function = evaluate(function_name)

      raise RuntimeError, "\n#{@parser.to_sexp(expression)}\n ^\n\n#{expression[0]} is not a function" unless function.is_a? Proc
      function.call(arguments, self)
    end
  end
end

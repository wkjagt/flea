module Flea
  class Interpreter

   attr_accessor :parser, :env

    def initialize(options = {}, env: Environment.new)
      @env = env
      @parser = Sexpistol.new
      @parser.ruby_keyword_literals = false
      @parser.scheme_compatability = true

      StandardLibrary.new(self).load
    end

    def run(program)
      @parser.parse_string(program).map { |exp| evaluate(exp) }.last
    end

    def evaluate(expression)
      return @env.find(expression) if expression.is_a? Symbol
      return expression unless expression.is_a? Array

      if expression[0] == :define
        @env.define(expression[1], evaluate(expression[2]))

      elsif expression[0] == :native_function
        eval expression[1]

      else # function call
        function_name, *arguments = expression
        function = evaluate(function_name)

        raise RuntimeError, "\n#{@parser.to_sexp(expression)}\n ^\n\n#{expression[0]} is not a function" unless function.is_a? Proc
        function.call(arguments, self)
      end
    end
  end
end

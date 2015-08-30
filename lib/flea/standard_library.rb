module Flea
  class StandardLibrary
    NATIVE_FUNCTIONS, FUNCTIONS = [], []

    def self.add(expression)
      FUNCTIONS << expression
    end

    def self.add_native(function, proc)
      NATIVE_FUNCTIONS << [function, proc]
    end

    Dir["#{File.dirname(__FILE__)}/standard_library/*.rb"].each do |file|
      require file
    end

    def initialize(interpreter)
      @interpreter = interpreter
    end

    def load
      NATIVE_FUNCTIONS.each { |function| @interpreter.env.define(*function) }
      FUNCTIONS.each { |function| @interpreter.run(function) }
    end
  end
end

module Flea
  class StandardLibrary
    def initialize(interpreter)
      @interpreter = interpreter
    end

    def load
      native_pattern = File.join(File.dirname(__FILE__), 'standard_library', 'native', '*.rb')
      library_pattern = File.join(File.dirname(__FILE__), 'standard_library', '*.scm')

      Dir[native_pattern].each do |item|
        File.open(item) do |file|
          expression = eval(file.read)
          @interpreter.env.define(*expression)
        end
      end

      Dir[library_pattern].each do |item|
        File.open(item) { |file| @interpreter.run(file.read) }
      end
    end
  end
end

require "readline"

class REPL
  def initialize
    @interpreter, @indent, @line = Flea::Interpreter.new, 0, 0
  end

  def start
    loop do
      program = multiline_buffer
      break if program == "quit"

      run_program(program) unless program.empty?
    end
  rescue SystemExit, Interrupt
    puts "\nbye"
  end

  private

  def multiline_buffer
    while (program ||= "") << Readline.readline(prompt, true) + " "
      @indent = program.count("(") - program.count(")")
      @line += 1
      break if @indent == 0
    end
    program.strip
  end

  def run_program(program)
    puts " => #{@interpreter.run(program).inspect}"
  rescue RuntimeError => e
    puts e
  end

  def prompt
    arrow = @indent == 0 ? ">" : "*"
    "flea:#{@line.to_s.rjust(3, '0')}#{arrow} " + (" " * @indent * 4)
  end
end

Flea::StandardLibrary.add_native *[
  :lambda,
  Proc.new do |arguments, interpreter|
    formals, *body = arguments

    # check for duplicate formals
    if formals.is_a?(Array) && formals.count != formals.uniq.count
      duplicates = formals.select{ |formal| formals.count(formal) > 1 }
      raise("Formal(s) #{duplicates.uniq.join(' ')} declared more than once")
    end

    body_proc = Proc.new do |body, env, interpreter|
      interpreter.env = env
      results = body.map { |exp| interpreter.evaluate(exp) }
      interpreter.env = env.parent
      results.last
    end

    case formals
    when Array
      if formals.include?(:'.')
        Proc.new do |arguments, interpreter|
          sub_env = Flea::Environment.new(interpreter.env)
          args = arguments.dup
          named_formals = formals.slice(0, formals.index(:'.'))
          list_formal = formals[formals.index(:'.') + 1]
          named_formals.each_index do |i|
            sub_env.define(named_formals[i], interpreter.evaluate(args.shift))
          end
          sub_env.define(list_formal, args)
          body_proc.call(body, sub_env, interpreter)
        end
      else
        Proc.new do |arguments, interpreter|
          sub_env = Flea::Environment.new(interpreter.env)
          formals.zip(arguments).each do |formal, argument|
            sub_env.define(formal, interpreter.evaluate(argument))
          end
          body_proc.call(body, sub_env, interpreter)
        end
      end
    when Symbol
      Proc.new do |arguments, interpreter|
        sub_env = Flea::Environment.new(interpreter.env)
        arguments = arguments.map {|x| interpreter.evaluate(x) }
        sub_env.define(formals, arguments)
        body_proc.call(body, sub_env, interpreter)
      end
    end
  end
]

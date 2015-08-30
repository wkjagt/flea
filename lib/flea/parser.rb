require 'strscan'

module Flea
  class Parser < StringScanner
    RULES = [
      [:open_paren,   /\(/,                                                 -> m { m }        ],
      [:close_paren,  /\)/,                                                 -> m { m }        ],
      [:string,       /"([^"\\]|\\.)*"/,                                    -> m { m[1..-2] } ],
      [:float,        /[\-\+]? [0-9]+ ((e[0-9]+) | (\.[0-9]+(e[0-9]+)?))/x, -> m { m.to_f }   ],
      [:integer,      /[\-\+]?[0-9]+/,                                      -> m { m.to_i }   ],
      [:quote,        /'/,                                                  -> m { m.to_sym } ],
      [:symbol,       /[^\(\)\s]+/,                                         -> m { m.to_sym } ],
      [:space,        /[\s\n]+/,                                            -> m { m }        ],
    ]

    def parse_string
      remove_comments
      parse
    end

    def parse
      exp = []
      while true
        type, token = fetch_token
        break if eos?

        case type
        when :open_paren then exp << parse
        when :close_paren then break
        when :quote
          type, _ = fetch_token
          case type
          when :open_paren then exp << [:quote, parse]
          else exp << [:quote, token]
          end
        when :space
        else exp << token
        end
      end
      exp
    end

    def fetch_token
      RULES.each do |type, pattern, proc|
        return type, proc.call(matched) if scan(pattern)
      end
      raise "Invalid character at position #{pos} near '#{scan(%r{.{0,20}})}'."
    end

    def remove_comments
      string.lines.map do |line|
        next line unless line.include?(';')
        line.slice(/.*;/)[0..-2]
      end
    end
  end
end

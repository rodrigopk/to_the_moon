require 'readline'

require_relative './to_the_moon'

def start_game
  prompt = "> "

  instance = ToTheMoon.new

  puts '(0, 0) ready for launch'
  while input = Readline.readline(prompt, true)  

    if input == 'exit'
      end_game
      break
    else
      result = instance.parse_input(input)
      position = result[:position]
      status = result[:status]

      puts "(#{position[:x]}, #{position[:y]}) #{message_from_status(status)}"
    end
  end
end

def end_game
  puts "Bye! Have a good day!"
end

def message_from_status(status)
  case status
  when :max_speed
    return "maximum speed"
  when :min_speed
    return "minimum speed"
  when :wrong_direction
    return "wrong direction"
  when :on_the_moon
    return "on the moon"
  when :contact_lost
    return "contact lost"
  end
end

start_game
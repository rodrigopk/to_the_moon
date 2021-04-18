require_relative './ship'

class ToTheMoon
  attr_reader :ship

  def initialize(ship: Ship.new)
    @ship = ship
  end

  def parse_input(input)
    status = :green

    case input
    when 'w'
      status = :max_speed if @ship.max_speed?
      @ship.accelerate
    when 's'
      status = :min_speed if @ship.min_speed?
      @ship.decelerate
    when 'a'
      @ship.strife(:left)
      status = :wrong_direction if @ship.wrong_direction?
    when 'd'
      @ship.strife(:right)
      status = :wrong_direction if @ship.wrong_direction?
    end

    status = :on_the_moon if @ship.on_the_moon?
    status = :contact_lost if @ship.went_over_the_moon?

    { position: @ship.position, status: status }
  end
end
require 'byebug'

class Ship
  attr_reader :position, :speed

  MAX_SPEED = 5
  MIN_SPEED = 1
  VALID_X_AXIS_DIRECTIONS = %i[left right].freeze

  def initialize(position: { x: 0, y: 0 }, speed: 0)
    @position = position
    @speed = speed
  end

  def accelerate
    increase_speed
    move_upwards_by_speed
  end

  def decelerate
    return if stopped?

    decrease_speed
    move_upwards_by_speed
  end

  def strife(direction)
    return unless VALID_X_AXIS_DIRECTIONS.include?(direction)

    direction == :left ? move_in_x_axis(-1) : move_in_x_axis(+1)

    move_upwards_by_speed
  end

  def stopped?
    @speed.zero?
  end

  def max_speed?
    @speed == MAX_SPEED
  end

  def min_speed?
    @speed == MIN_SPEED
  end

  def wrong_direction?
    @position[:x] < -5 || @position[:x] > 5
  end

  def on_the_moon?
    @position == { x: 0, y: 250 }
  end

  def went_over_the_moon?
    @position[:y] > 250
  end

  private

  def move_upwards_by_speed
    @position = { x: @position[:x], y: @position[:y] + @speed }
  end

  def decrease_speed
    @speed = @speed > MIN_SPEED ? @speed - 1 : MIN_SPEED
  end

  def increase_speed
    @speed = @speed < MAX_SPEED ? @speed + 1 : MAX_SPEED
  end

  def move_in_x_axis(amount)
    @position = { x: @position[:x] + amount, y: @position[:y] }  
  end
end

require 'rspec'

require_relative '../src/to_the_moon'

RSpec.describe ToTheMoon do
  it 'initializes' do
    ToTheMoon.new
  end

  describe 'parse_input' do
    instance = ToTheMoon.new

    context ':green status' do
      context "given the 'w' char" do
        it 'accelerates the ship' do
          result = instance.parse_input("w")

          expect(instance.ship.position).to eq({ x: 0, y: 1 })
          expect(instance.ship.speed).to eq(1)
          expect(result).to eq({
            position: { x: 0, y: 1 },
            status: :green
          })
        end
      end

      context "given the 's' char" do
        it 'decelerates the ship' do
          instance.parse_input("w")
          result = instance.parse_input("s")

          expect(instance.ship.position).to eq({ x: 0, y: 4 })
          expect(instance.ship.speed).to eq(1)
          expect(result).to eq({
            position: { x: 0, y: 4 },
            status: :green
          })
        end
      end

      context "given the 'a' char" do
        it 'strifes the ship to the left' do
          result = instance.parse_input("a")

          expect(instance.ship.position).to eq({ x: -1, y: 5 })
          expect(instance.ship.speed).to eq(1)
          expect(result).to eq({
            position: { x: -1, y: 5 },
            status: :green
          })
        end
      end

      context "given the 'd' char" do
        it 'strifes the ship to the right' do
          result = instance.parse_input("d")

          expect(instance.ship.position).to eq({ x: 0, y: 6 })
          expect(instance.ship.speed).to eq(1)
          expect(result).to eq({
            position: { x: 0, y: 6 },
            status: :green
          })
        end
      end
    end

    context 'given user accelerates after max speed has been reached' do
      it 'returns the correct status' do
        instance = ToTheMoon.new(
          ship: Ship.new(position: { x:0, y: 20 }, speed: 5)
        )

        result = instance.parse_input("w")

        expect(result).to eq({
          position: { x: 0, y: 25 },
          status: :max_speed
        })
      end
    end

    context 'given user decelerates after min speed has been reached' do
      it 'returns the correct status' do
        instance = ToTheMoon.new(
          ship: Ship.new(position: { x:0, y: 10 }, speed: 1)
        )

        result = instance.parse_input("s")

        expect(result).to eq({
          position: { x: 0, y: 11 },
          status: :min_speed
        })
      end
    end

    context 'given user goes more then 5 points to the left' do
      it 'returns the correct status' do
        instance = ToTheMoon.new(
          ship: Ship.new(position: { x: -5, y: 10 }, speed: 1)
        )

        result = instance.parse_input("a")

        expect(result).to eq({
          position: { x: -6, y: 11 },
          status: :wrong_direction
        })
      end
    end

    context 'given user goes more then 5 points to the right' do
      it 'returns the correct status' do
        instance = ToTheMoon.new(
          ship: Ship.new(position: { x: 5, y: 10 }, speed: 1)
        )

        result = instance.parse_input("d")

        expect(result).to eq({
          position: { x: 6, y: 11 },
          status: :wrong_direction
        })
      end
    end

    context 'given the user reaches the (0, 250) position' do
      it 'returns the correct status' do
        instance = ToTheMoon.new(
          ship: Ship.new(position: { x: 0, y: 249 }, speed: 1)
        )

        result = instance.parse_input("s")

        expect(result).to eq({
          position: { x: 0, y: 250 },
          status: :on_the_moon
        })
      end
    end

    context 'given the ship exceeds the y 250 position' do
      it 'returns the correct status' do
        instance = ToTheMoon.new(
          ship: Ship.new(position: { x: 0, y: 249 }, speed: 1)
        )

        result = instance.parse_input("w")

        expect(result).to eq({
          position: { x: 0, y: 251 },
          status: :contact_lost
        })
      end
    end
  end
end
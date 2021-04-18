require 'rspec'
require 'byebug'

require_relative '../src/ship'

RSpec.describe Ship do
  describe 'initialize' do
    subject(:ship) { Ship.new }

    it 'new ships start at position (0,0)' do
      expect(ship.position).to eq({ x: 0, y: 0 })
    end

    it 'new ships starts with speed 0' do
      expect(ship.speed).to be 0
    end
  end

  describe 'accelerate' do    
    context 'given a ship at the initial position' do
      ship = Ship.new

      before(:all) do
        ship.accelerate
      end

      it 'moves the ship position in the Y axis by 1' do
        expect(ship.position).to eq({ x: 0, y: 1 })
      end

      it 'increases the ship speed by 1' do
        expect(ship.speed).to eq(1)
      end
    end

    context 'given a ship that is mid flight' do
      ship = Ship.new

      before(:all) do
        ship.accelerate
        ship.accelerate
      end

      it 'moves the ship position in the Y axis by 3' do
        expect(ship.position).to eq({ x: 0, y: 3 })
      end

      it 'increases the ship speed by 2' do
        expect(ship.speed).to eq(2)
      end
    end

    context 'given the ship is at max speed' do
      ship = Ship.new

      before(:all) do
        ship.accelerate
        ship.accelerate
        ship.accelerate
        ship.accelerate
        ship.accelerate
        ship.accelerate
      end

      it 'does not exceeds the maximum speed' do
        expect(ship.speed).to be(5)
      end

      it 'does not exceeds the maximum speed' do
        expect(ship.position).to eq({ x: 0, y: 20 })
      end
    end
  end

  describe 'decelerate' do
    context 'given a ship that is stopped' do
      ship = Ship.new

      before(:all) do
        ship.decelerate
      end

      it 'does not updates the ship position' do
        expect(ship.position).to eq({ x: 0, y: 0 })
      end

      it 'does not updates the ship speed' do
        expect(ship.speed).to eq(0)
      end
    end

    context 'given the ship is moving at the speed of 1' do
      ship = Ship.new

      before(:all) do
        ship.accelerate
        ship.decelerate
      end

      it 'moves the ship forward by 1' do
        expect(ship.position).to eq({ x: 0, y: 2 })
      end

      it 'does not updates the ship speed' do
        expect(ship.speed).to be(1)
      end
    end

    context 'given the ship is at any other speed' do
      ship = Ship.new

      before(:all) do
        ship.accelerate
        ship.accelerate
        ship.accelerate
        ship.decelerate
      end

      it 'updates the ship speed' do
        expect(ship.speed).to be(2)
      end

      it 'updates the ship position correctly' do
        expect(ship.position).to eq({ x: 0, y:8 })
      end
    end
  end

  describe 'strife' do
    context 'given the ship is at initial position' do
      context 'given direction is left' do
        it 'moves the ship in the indicated direction' do
          ship = Ship.new

          ship.strife(:left)

          expect(ship.position).to eq({ x: -1, y: 0 })
        end
      end

      context 'given direction is right' do
        it 'moves the ship in the indicated direction' do
          ship = Ship.new

          ship.strife(:right)

          expect(ship.position).to eq({ x: 1, y: 0 })
        end
      end
    end

    context 'given the ship is flying' do
      it 'moves the ship in the indicated direction' do
        ship = Ship.new

        ship.accelerate
        ship.accelerate

        ship.strife(:left)

        expect(ship.position).to eq({ x: -1, y: 5 })
      end
    end

    context 'given unrecognized direction' do
      it 'does nothing' do
        ship = Ship.new

        ship.accelerate
        ship.strife('whatever')

        expect(ship.position).to eq({ x: 0, y: 1 })
      end
    end
  end
end
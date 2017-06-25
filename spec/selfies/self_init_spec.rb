require 'spec_helper'

RSpec.describe Selfies::SelfInit do
  describe '.generate' do
    subject { described_class.generate(my_car_class, accessor, *variable_names) }

    let(:accessor) { false }

    let(:my_car_class) do
      # Empty class that has an empty initializer by default
      class Car; end
      Car
    end

    let(:variable_names) { [] }

    context 'when passing no variable names' do
      it { is_expected.to be false }
    end

    context 'when passing one or more variable names' do
      let(:instance) { Car.new(:large, :blue) }
      let(:variable_names) { %i[type colour] }

      before { subject }

      it 'generates an initializer method for those attributes' do
        expect(instance).to be_a Car
      end

      it 'generates readers for the given attributes' do
        expect(instance.type).to eql :large
        expect(instance.colour).to eql :blue
      end

      context 'when accessor is set to true' do
        let(:accessor) { true }

        before do
          instance.type = :medium
          instance.colour = :red
        end

        it 'generates accessors for the given attributes' do
          expect(instance.type).to eql :medium
          expect(instance.colour).to eql :red
        end
      end
    end

    context 'when given arumnets do not match variable names' do
      let(:expected_message) do
        'wrong number of arguments (given 2, expected 3)'
      end
      let(:instance) { Car.new(:large, :blue) }
      let(:variable_names) { %i[type colour price] }

      before { subject }

      it 'raises an ArgumentError' do
        expect { instance }.to raise_error(ArgumentError, expected_message)
      end
    end
  end
end

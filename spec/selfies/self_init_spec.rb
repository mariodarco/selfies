require 'spec_helper'

RSpec.describe Selfies::SelfInit do
  describe '.generate' do
    subject { described_class.generate(my_car_class, *variable_names) }

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
    end

    context 'when given arumnets do not match variable names' do
      let(:expected_message) { 'wrong number of arguments (given 2, expected 3)' }
      let(:instance) { Car.new(:large, :blue) }
      let(:variable_names) { %i[type colour price] }

      before { subject }

      it 'raises an ArgumentError' do
        expect { instance }.to raise_error(ArgumentError, expected_message)
      end
    end
  end
end

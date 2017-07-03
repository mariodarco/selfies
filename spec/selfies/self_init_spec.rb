require 'spec_helper'

RSpec.describe Selfies::SelfInit do
  describe '.generate' do
    subject do
      described_class.generate(my_car_class, accessor, *variable_names)
    end

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

      context 'when given arguments do not match variable names' do
        let(:expected_message) do
          'wrong number of arguments (given 2, expected 3)'
        end
        let(:variable_names) { %i[type colour price] }

        before { subject }

        it 'raises an ArgumentError' do
          expect { instance }.to raise_error(ArgumentError, expected_message)
        end
      end
    end

    context 'when last variable name has a default' do
      let(:instance) { Car.new(:large, :red) }
      let(:variable_names) { [:type, { colour: :blue }] }

      before { subject }

      it 'generates an initializer method for those attributes' do
        expect(instance).to be_a Car
      end

      it 'generates readers for the given attributes' do
        expect(instance.type).to eql :large
        expect(instance.colour).to eql :red
      end

      context 'and the object is then initialised without that parameter' do
        let(:instance) { Car.new(:large) }

        it 'assign default to the last attribute' do
          expect(instance.colour).to eql :blue
        end
      end

      context 'when given arguments do not match variable names' do
        context 'by one more' do
          let(:expected_message) do
            'wrong number of arguments (given 3, expected 2)'
          end
          let(:instance) { Car.new(:large, :red, :expensive) }

          before { subject }

          it 'raises an ArgumentError' do
            expect { instance }.to raise_error(ArgumentError, expected_message)
          end
        end

        context 'by one less' do
          let(:instance) { Car.new(:large) }

          it 'does not raise error' do
            expect { instance }.to_not raise_error
          end
        end
      end
    end

    context 'when the only variable name has a default' do
      let(:instance) { Car.new(:red) }
      let(:variable_names) { [{ colour: :blue }] }

      before { subject }

      it 'generates an initializer method for those attributes' do
        expect(instance).to be_a Car
      end

      it 'generates readers for the given attributes' do
        expect(instance.colour).to eql :red
      end

      context 'and the object is then initialised without that parameter' do
        let(:instance) { Car.new }

        it 'assign default to the last attribute' do
          expect(instance.colour).to eql :blue
        end
      end
    end

    context 'when last variable is :args' do
      let(:instance) { Car.new(:large, :red, :expensive, :german) }
      let(:variable_names) { %i[type args] }

      before { subject }

      it 'generates an initializer method for those attributes' do
        expect(instance).to be_a Car
      end

      it 'generates readers for the given attributes' do
        expect(instance.type).to eql :large
        expect(instance.args).to eql %i[red expensive german]
      end

      context 'when given arguments do not match variable names' do
        context 'by one more' do
          before { subject }

          let(:instance) { Car.new(:large, :red, :expensive) }

          it 'does not raise error' do
            expect { instance }.to_not raise_error
          end
        end

        context 'by one less' do
          let(:instance) { Car.new(:large) }

          let(:expected_message) do
            'wrong number of arguments (given 1, expected 2)'
          end

          it 'raises an ArgumentError' do
            expect { instance }.to raise_error(ArgumentError, expected_message)
          end
        end
      end
    end

    context 'when the only variable name is args' do
      let(:instance) { Car.new(:small, :red) }
      let(:variable_names) { [:args] }

      before { subject }

      it 'generates an initializer method for those attributes' do
        expect(instance).to be_a Car
      end

      it 'generates readers for the given attributes' do
        expect(instance.args).to eql %i[small red]
      end
    end
  end
end

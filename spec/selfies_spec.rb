require 'spec_helper'

RSpec.describe Selfies do
  it 'has a version number' do
    expect(Selfies::VERSION).not_to be nil
  end

  describe '.generate_initializer' do
    subject do
      described_class.generate_initializer(my_car_class, *variable_names)
    end

    let(:my_car_class) do
      # Empty class that has an empty initializer by default
      class Car; end
    end
    let(:variable_names) { %i[type colour] }

    it 'delegates the generation to SelfInit' do
      expect(Selfies::SelfInit)
        .to receive(:generate)
        .with(my_car_class, *variable_names)
        .once

      subject
    end
  end
end

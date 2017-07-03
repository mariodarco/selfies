require 'spec_helper'

RSpec.describe Selfies do
  let(:my_car_class) do
    # Empty class that has an empty initializer by default
    class Car; end
  end

  it 'has a version number' do
    expect(Selfies::VERSION).not_to be nil
  end

  describe '.generate_initializer' do
    subject do
      described_class.generate_initializer(my_car_class, *variable_names)
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

  describe '.generate_class_methods' do
    subject do
      described_class.generate_class_methods(my_car_class, *method_names)
    end

    let(:method_names) { %i[start! stop!] }

    it 'delegates the generation to Selfie' do
      expect(Selfies::Selfie)
        .to receive(:generate)
        .with(my_car_class, *method_names)
        .once

      subject
    end
  end
end

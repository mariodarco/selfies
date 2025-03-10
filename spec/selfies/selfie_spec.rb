# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Selfies::Selfie do
  describe '.generate' do
    subject { described_class.generate(my_rectangle_class, *method_names) }

    let(:method_names) { %i[area perimeter] }
    let(:my_rectangle_class) do
      # Basic class with only instance methods
      class Rectangle
        attr_reader_init :width, :height

        def area
          width * height
        end

        def perimeter
          (width + height) * 2
        end
      end
      Rectangle
    end

    before { subject }

    it 'creates relevant class methods for area' do
      expect(
        my_rectangle_class.area(5, 8)
      ).to be 40
    end

    it 'creates relevant class methods for perimeter' do
      expect(
        my_rectangle_class.perimeter(5, 8)
      ).to be 26
    end
  end
end

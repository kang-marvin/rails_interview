require 'spec_helper'

RSpec.describe 'Birth Date Format - Helper Test' do
  describe '.call' do
    context 'given empty birth date string' do
      it 'returns nil' do
        expect(BirthDateFormat.new().call).to eql(nil)
      end
    end

    context 'given invalid date format' do
      it 'throws ArgumentError' do
        expect { BirthDateFormat.new('30/30/2022').call }.to raise_error(ArgumentError)
      end
    end

    context 'given date to format' do
      it 'returns the expected date format' do
        expect(BirthDateFormat.new('12-03-2022').call).to eql("3/12/2022")
      end
    end

    context 'given date in the expected format' do
      it 'returns the expected date format' do
        expect(BirthDateFormat.new('3/12/2022').call).to eql("12/3/2022")
      end
    end

    context 'given date with appended zeros to format' do
      it 'returns the expected date format' do
        expect(BirthDateFormat.new('03-03-0222').call).to eql("3/3/0222")
      end
    end
  end
end

require 'spec_helper'

RSpec.describe 'City - Data Test' do
  describe '.full_name' do

    context 'given empty name' do
      it 'returns the given name' do
        expect(CityData.new('').full_name).to eql('')
      end
    end

    context 'given nil' do
      it 'returns empty string' do
        expect(CityData.new(nil).full_name).to eql('')
      end
    end

    context 'given name that is not a short form' do
      it 'returns the name' do
        expect(CityData.new('Nairobi').full_name).to eql('Nairobi')
      end
    end

    context 'given name that is a short form and is in the list' do
      it 'returns the full name matching the given short form' do
        expect(CityData.new('LA').full_name).to eql('Los Angeles')
      end
    end

  end
end

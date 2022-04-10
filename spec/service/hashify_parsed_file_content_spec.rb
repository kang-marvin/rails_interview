require 'spec_helper'

RSpec.describe 'Hashify Parsed File Content - Service Object Test' do
  describe '.call' do

    context '' do
      it 'converts the first line to headers / keys' do
        fileContent = File.read('spec/fixtures/people_by_dollar.txt')
        obj = HashifyParsedFileContent.new({file_content: fileContent}).call
        expect(obj.first.keys).to match_array(['city', 'first_name', 'last_name', 'birthdate'])
      end
    end

    context 'given file with a uniq separator' do
      it 'converts the first line to headers / keys with separator provided' do
        fileContent = File.read('spec/fixtures/people_by_percent_and_dollar.txt')
        obj = HashifyParsedFileContent.new({file_content: fileContent, separator: '%$'}).call
        expect(obj.first.keys).to match_array(['city', 'first_name', 'birthdate'])
      end
    end

    context 'given file with a uniq separator' do
      it 'returns data that matches one in the file in object format' do
        fileContent = File.read('spec/fixtures/people_by_percent.txt')
        obj = HashifyParsedFileContent.new({file_content: fileContent, separator: '%'}).call

        expectedObject = {
          'city' => 'New York City',
          'first_name' => 'Elliot',
          'birthdate' => '5/4/1947'
        }
        expect(obj.last).to eql(expectedObject)
      end
    end

    context 'given empty file content' do
      it 'returns empty array of object' do
        fileContent = ''
        obj = HashifyParsedFileContent.new({file_content: fileContent}).call
        expect(obj).to eql([])
      end
    end

  end
end

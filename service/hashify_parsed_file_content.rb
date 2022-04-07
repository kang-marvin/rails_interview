require 'date'

class HashifyParsedFileContent
  attr_reader :file_content, :separator

  DEFAULT_FILE_CONTENT = ""
  DEFAULT_SEPARATOR = "$"

  def initialize(file_content: DEFAULT_FILE_CONTENT, separator: DEFAULT_SEPARATOR)
    @file_content = file_content.to_s
    @separator = separator.to_s
  end

  def call
    return [] if @file_content.empty?

    file_content_as_array = @file_content.split("\n")
    file_content_headers = headers(file_content_as_array.first)

    file_content_as_hash(
      content: file_content_as_array[1..file_content_as_array.length],
      headers: file_content_headers
    )
  end

  def headers(content)
    cleanup(content.split(@separator))
  end

  def file_content_as_hash(content: DEFAULT_FILE_CONTENT, headers: [])
    result = []

    content.each do |line|
      line_content_as_array = cleanup(line.split(@separator))
      merged_array =
        headers.zip(line_content_as_array).map { |header, data| [header, data]}

      result << data_modification(merged_array.to_h)
    end

    result
  end

  private

  def cleanup(content)
    content.map(&:strip!) rescue []
  end

  def data_modification(data)
    data.merge({
      "city" => CityData.new(data["city"]).full_name,
      "birthdate" => BirthDateFormat.new(data["birthdate"]).call,
    })
  end

end

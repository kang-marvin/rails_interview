class PeopleController
  def initialize(params)
    @params = params
    @wanted_values = [ 'first_name', 'city', 'birthdate' ]
  end

  def normalize
    arrayed_hash_content = [
      data({ file_content: @params[:dollar_format] }),
      data({ file_content: @params[:percent_format], separator: "%" }),
    ]

    ::StringifyArrayedHashContent.new({
      order_by: @params[:order],
      wanted_values: @wanted_values
    }).call(arrayed_hash_content)
  end

  private

  def data(options = {})
    return [] if options.values.any?(&:nil?)
    ::HashifyParsedFileContent.new(options).call
  end

  attr_reader :params
end

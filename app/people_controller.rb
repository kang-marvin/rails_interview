class PeopleController
  def initialize(params)
    @params = params
  end

  def normalize
    wanted_values = [ 'first_name', 'city', 'birthdate' ]
    merged_hash_content = [
      data({ file_content: @params[:dollar_format] }),
      data({ file_content: @params[:percent_format], separator: "%" }),
    ]

    merged_hash_content.flatten.sort_by!{ |obj| obj[@params[:order].to_s] }.map do |obj|
      obj.values_at(*wanted_values).join(", ")
    end
  end

  private

  def data(options = {})
    return [] if options.values.any?(&:nil?)
    ::HashifyParsedFileContent.new(options).call
  end

  attr_reader :params
end

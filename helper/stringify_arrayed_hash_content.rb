class StringifyArrayedHashContent
  def initialize(order_by: nil, wanted_values: [])
    @order_by = order_by
    @wanted_values = wanted_values
  end

  def call(array_of_hashed_content = [])
    sorted_array =
      sort_content(array_of_hashed_content.flatten)

    sorted_array.map do |obj|
      obj.values_at(*@wanted_values).join(", ")
    end
  end

  private

  attr_reader :order_by, :wanted_values

  def present?(str)
    !str.to_s.empty?
  end

  def sort_content(array_content)
    return array_content unless present?(@order_by)
    array_content.sort_by! { |obj| obj[@order_by.to_s] }
  end

end
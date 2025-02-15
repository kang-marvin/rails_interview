require 'date'

class BirthDateFormat

  # The minus (-) is used to remove appending zero
  FORMAT_TO_USE = "%-m/%-d/%Y"

  def initialize(birth_date = '')
    @birth_date = birth_date
  end

  def call
    return nil unless present?(@birth_date)
    format_birth_date
  end

  private

  attr_reader :birth_date

  def format_birth_date
    Date.parse(@birth_date).strftime(FORMAT_TO_USE)
  end

  def present?(str)
    !str.to_s.empty?
  end

end

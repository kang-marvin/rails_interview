require 'date'

class BirthDateFormat

  attr_reader :birth_date

  # The minus (-) is used to remove appending zero
  FORMAT_TO_USE = "%-m/%-d/%Y"

  def initialize(birth_date)
    @birth_date = birth_date
  end

  def call
    format_birth_date
  end

  private

  def format_birth_date
    Date.parse(@birth_date).strftime(FORMAT_TO_USE)
  end

end

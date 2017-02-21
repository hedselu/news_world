require 'csv'

class ConfigLoader
  def initialize
    @rows = CSV.read('config/config.csv')
  end

  def data
    @rows.each_with_object([]) { |row, data| data << { source: row[0], url: row[1], category: row[2] } }
  end
end

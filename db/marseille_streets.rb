require 'open-uri'
require 'csv'


MARSEILLE_STREETS = []

csv_file = File.join(File.dirname(__FILE__), 'marseille_A_streets.csv')
CSV.foreach(csv_file) do |row| # Array
  MARSEILLE_STREETS << row[0]
end

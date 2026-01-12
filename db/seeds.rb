# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

["Check", "Credit card", "Purchase order"].each do |pay_type_name|
  PayType.find_or_create_by!(
    name: pay_type_name,
    code: pay_type_name.parameterize.underscore
  )
end
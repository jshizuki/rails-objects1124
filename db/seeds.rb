# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# INVOICE instances

# def random_date(start_date, end_date)
#   rand(start_date..end_date)
# end

# start_date = Date.new(2023, 1, 1)
# end_date = Date.today

# clients = %w[Andrew Anne Connor Dave Joyce Jun Rashon Taylor]

# puts 'Creating invoices...'

# 5.times do
#   random_date = random_date(start_date, end_date)
#   invoice = Invoice.create(
#     order_date: random_date,
#     billed_to: clients.sample
#   )
#   puts "Invoice #{invoice.id} has been created."
# end

# puts "Created #{Invoice.count} invoices successfully."

# PRODUCT instances

puts 'Creating products...'

products = [
  { sku: 'OBJ001', name: 'The Chill', unit_price: 850 },
  { sku: 'OBJ002', name: 'The Laid-back', unit_price: 650 },
  { sku: 'OBJ003', name: 'The Beat', unit_price: 750 },
  { sku: 'OBJ004', name: 'The One', unit_price: 850 },
  { sku: 'OBJ005', name: 'The Ballad', unit_price: 650 },
  { sku: 'OBJ006', name: 'The Rap', unit_price: 650 },
  { sku: 'OBJ007', name: 'The Classy-fused', unit_price: 1050 },
  { sku: 'OBJ008', name: 'The R&B', unit_price: 750 },
  { sku: 'OBJ009', name: 'The Pop', unit_price: 750 },
  { sku: 'OBJ010', name: 'The Groovy', unit_price: 850 },
  { sku: 'OBJ011', name: 'The Funky', unit_price: 550 },
  { sku: 'OBJ012', name: 'The Funky', unit_price: 550 },
  { sku: 'OBJ013', name: 'The Funky', unit_price: 550 },
  { sku: 'OBJ014', name: 'The Funky', unit_price: 550 },
  { sku: 'OBJ015', name: 'The Funky', unit_price: 550 }
]

products.each do |product|
  item = Product.create(
    sku: product[:sku],
    name: product[:name],
    unit_price: product[:unit_price]
  )
  puts "Product #{item.id} has been created."
end

puts "Created #{Product.count} products successfully."

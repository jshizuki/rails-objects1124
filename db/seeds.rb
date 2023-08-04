# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Cleaning database...'
ObjectsProduct.destroy_all
ObjectsInvoice.destroy_all

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

# puts "Successfully created #{Invoice.count} invoices."

# PRODUCT instances

puts 'Creating products...'

products = [
  { sku: 'OBJ001', name: 'The Chill', quantity: 1, unit_price: 1500 },
  { sku: 'OBJ002', name: 'The Laid-back', quantity: 1, unit_price: 1050 },
  { sku: 'OBJ003', name: 'The Beat', quantity: 1, unit_price: 1500 },
  { sku: 'OBJ004', name: 'The One', quantity: 1, unit_price: 1500 },
  { sku: 'OBJ005', name: 'The Ballad', quantity: 1, unit_price: 1050 },
  { sku: 'OBJ006', name: 'The Rap', quantity: 1, unit_price: 1050 },
  { sku: 'OBJ007', name: 'The Classy-fused', quantity: 1, unit_price: 1800 },
  { sku: 'OBJ008', name: 'The R&B', quantity: 1, unit_price: 1150 },
  { sku: 'OBJ009', name: 'The Pop', quantity: 1, unit_price: 1150 },
  { sku: 'OBJ010', name: 'The Groovy', quantity: 1, unit_price: 1500 },
  { sku: 'OBJ011', name: 'The Funky', quantity: 1, unit_price: 850 },
  { sku: 'OBJ012', name: 'The Funky', quantity: 1, unit_price: 850 },
  { sku: 'OBJ013', name: 'The Funky', quantity: 1, unit_price: 850 },
  { sku: 'OBJ014', name: 'The Funky', quantity: 1, unit_price: 850 },
  { sku: 'OBJ015', name: 'The Funky', quantity: 1, unit_price: 850 },
  { sku: 'OBJ016', name: 'The Chawan', quantity: 1, unit_price: 450 },
  { sku: 'OBJ017', name: 'The Chawan', quantity: 1, unit_price: 450 }
]

products.each do |product|
  item = ObjectsProduct.create(
    sku: product[:sku],
    name: product[:name],
    quantity: product[:quantity],
    unit_price: product[:unit_price]
  )
  puts "Product #{item.id} has been created."
end

puts "Successfully created #{ObjectsProduct.count} products."

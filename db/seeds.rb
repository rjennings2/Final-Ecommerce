# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Admin.create(username: 'admin', password: 'password')

sports_bras = Category.create(category_name: "Sports Bras")
leggings = Category.create(category_name: "Leggings")
shorts = Category.create(category_name: "Shorts")
shirts = Category.create(category_name: "Shirts")
shoes = Category.create(category_name: "Shoes")

# Create Products for Sports Bras
Product.create(category: sports_bras, product_name: "Athletic Support Bra", description: "Perfect for high-intensity workouts.", price: 29.99, size: "M", colour: "Black", on_sale: true, is_new: false)
Product.create(category: sports_bras, product_name: "Compression Sports Bra", description: "Provides extra support during intense training.", price: 34.99, size: "L", colour: "Grey", on_sale: false, is_new: true)

# Create Products for Leggings
Product.create(category: leggings, product_name: "Yoga Leggings", description: "Stretchy and comfortable for yoga or casual wear.", price: 39.99, size: "S", colour: "Navy Blue", on_sale: false, is_new: true)
Product.create(category: leggings, product_name: "Running Leggings", description: "Breathable and moisture-wicking, perfect for running.", price: 44.99, size: "M", colour: "Black", on_sale: true, is_new: false)

# Create Products for Shorts
Product.create(category: shorts, product_name: "Athletic Shorts", description: "Lightweight and breathable for running or gym workouts.", price: 19.99, size: "L", colour: "Grey", on_sale: false, is_new: true)
Product.create(category: shorts, product_name: "Compression Shorts", description: "Ideal for sports and physical activities.", price: 22.99, size: "M", colour: "Black", on_sale: true, is_new: false)

# Create Products for Shirts
Product.create(category: shirts, product_name: "Performance T-Shirt", description: "Sweat-wicking fabric to keep you cool during exercise.", price: 24.99, size: "M", colour: "White", on_sale: true, is_new: true)
Product.create(category: shirts, product_name: "Compression Shirt", description: "Boosts muscle performance during high-intensity activities.", price: 29.99, size: "L", colour: "Blue", on_sale: false, is_new: false)

# Create Products for Shoes
Product.create(category: shoes, product_name: "Running Shoes", description: "Lightweight and supportive for runners.", price: 59.99, size: "10", colour: "Red", on_sale: true, is_new: false)
Product.create(category: shoes, product_name: "Cross-training Shoes", description: "Perfect for a mix of workouts and sports.", price: 69.99, size: "9", colour: "Black", on_sale: false, is_new: true)
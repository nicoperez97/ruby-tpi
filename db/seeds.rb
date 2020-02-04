# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.create!(codigo:1,descripcion:"Primer producto",detalle:"detaller del producto",montoU:"10")
Client.create!(nombre:"Nicolas",condicion:"soltero",tel:"40458821",email:"nikop.1997.np@gmail.com",cuil:"20404588215")
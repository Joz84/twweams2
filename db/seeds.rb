# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Subscription.destroy_all
Channel.destroy_all
User.destroy_all
u1 =  User.create(email: "a@gmail.com", password: "azerty", alias: "Alice")
u2 =  User.create(email: "b@gmail.com", password: "azerty", alias: "Bob")

c1 = Channel.create(name: "test")
s11 = Subscription.create(user: u1, channel: c1)
s21 = Subscription.create(user: u2, channel: c1)

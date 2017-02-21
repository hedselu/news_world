# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(login: 'adminadmin',
             email: 'admin@admin.com',
             password: 'password123',
             password_confirmation: 'password123',
             role: 'admin')
User.create!(login: 'hipppo',
             email: 'hipppo@hipppo.com',
             password: 'password123',
             password_confirmation: 'password123')

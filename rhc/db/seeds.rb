# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Location.delete_all

Location.create(title: "Triangle Park", latitude: 42.825102, longitude: -75.548332)
Location.create(title: "Harry Lang Cross Country and Fitness Trails", description: "Hiking area", latitude: 42.812770, longitude: -75.537740)
Location.create(title: "Cazenovia Recreation Center", latitude: 42.932394, longitude: -75.844110)
Location.create(title: "Chittenango Falls State Park", description: "Winding gorge trails & a footbridge offer views of a 167-ft. waterfall, with areas for picnics.", latitude: 42.977701, longitude: -75.842604)

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

Event.delete_all

Event.create(title: "5k christmas charity run",
            datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
            description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
            address: "Trudy Fitness Center, Hamilton")
Event.create(title: "Slide down the hill",
            datetime: DateTime.iso8601('2018-01-01T04:05:06-05:00'),  # require 'date'
            description: "Rolling down the hill since 1819",
            address: "Colgate University")
Event.create(title: "10k around campus",
            datetime: DateTime.iso8601('2018-02-28T04:05:06-05:00'),  # require 'date'
            description: "Come run with us!",
            address: "Colgate University")

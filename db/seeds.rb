# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.delete_all

User.create(email: 'qvu@colgate.edu', password: 'rhc123', admin: true)
User.create(email: 'vudinhquan124@gmail.com', password: '123rhc')

Location.delete_all

Location.create(title: "Triangle Park",
                address: "Triangle Park, Hamilton NY")
Location.create(title: "Harry Lang Cross Country and Fitness Trails",
                description: "Hiking area",
                address: "Harry Lang Cross Country and Fitness Trails, 13 Oak Drive, Hamilton NY")
Location.create(title: "Cazenovia Recreation Center",
                address: "22 Burton St, Cazenovia, NY 13035")
Location.create(title: "Chittenango Falls State Park",
                description: "Winding gorge trails & a footbridge offer views of a 167-ft. waterfall, with areas for picnics.",
                address: "Chittenango Falls State Park, Cazenovia, NY 13035")

Event.delete_all

user_id_1 = User.first.id
user_id_2 = User.last.id

Event.create(user_id: user_id_1,
            title: "5k christmas charity run",
            datetime: DateTime.iso8601('2017-12-25T04:05:06-05:00'),  # require 'date'
            description: "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council",
            address: "Trudy Fitness Center, Hamilton")
Event.create(user_id: user_id_1,
            title: "Slide down the hill",
            datetime: DateTime.iso8601('2018-01-01T04:05:06-05:00'),  # require 'date'
            description: "Rolling down the hill since 1819",
            address: "Colgate University")
Event.create(user_id: user_id_2,
            title: "Slide down the other hill",
            datetime: DateTime.iso8601('2018-01-01T04:10:06-05:00'),  # same date, different time as above.
            description: "Rolling down the hill since 1819",
            address: "Colgate University")
Event.create(user_id: user_id_1,
            title: "10k around campus",
            datetime: DateTime.iso8601('2018-02-28T04:05:06-05:00'),  # require 'date'
            description: "Come run with us!",
            address: "Colgate University")

Recap.delete_all

Event.first.recap = Recap.new(attendance: 500, description: "It was hugely successful!")
Event.last.recap = Recap.new(attendance: 10, description: "It was fun!")

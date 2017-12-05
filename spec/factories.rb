FactoryBot.define do
  factory :user, :class => 'User' do
    email 'test@test.com'
    password '12345678'
    password_confirmation '12345678'
    trait :admin do
      admin true
    end
    trait :wrong_user do
      email 'qvu@colgate.edu'
      password '12345678'
      password_confirmation '12345678'
    end
  end

  factory :event, :class => 'Event' do
    id 1
    user_id 1
    title "5k christmas charity run"
    datetime DateTime.iso8601('2017-12-25T04:05:06-05:00')
    description "Come and run the christmas 5K to raise money for the Madison Country Rural Health Council"
    address "Trudy Fitness Center, Hamilton"
  end

  factory :recap, :class => 'Recap' do
    id 1
    event_id 1
    attendance 100
    description 'It was a huge party!'
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

20.times do |i|
  User.create!(
    line_user_id: "abcde#{i+1}"
  )
end

20.times do |i|
  Schedule.create!(
    start_planned_day_at: Time.zone.now.since((10+i).days).since(3.hours),
    finish_planned_day_at: Time.zone.now.since((10+i).days).since(8.hours),
    place: "東京",
    other: "お買い物",
    token: "abcde#{i+1}",
    inviter_id: i+1,
    answer: 1
  )
end

10.times do |i|
  MakePlan.create!(
    inviter_id: i+1,
    partner_id: i+2,
    schedule_id: i+1
  )
end

20.times do |i|
  Mission.create!(
    body: "ミッション #{i+1}"
  )
end
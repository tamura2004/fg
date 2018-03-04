User.delete_all

User.seed do |u|
  u.id = 1
  u.uid = "a100101"
  u.password = "a1001010"
  u.name = "浅野　巧"
  u.start_date = Date.today
end

User.seed do |u|
  u.id = 2
  u.uid = "a100202"
  u.password = "a1002020"
  u.name = "石川　五郎"
  u.start_date = Date.today
end

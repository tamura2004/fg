Zone.delete_all

Zone.seed do |u|
  u.id = 1
  u.name = "社外ネットワーク"
end

Zone.seed do |u|
  u.id = 2
  u.name = "社内ネットワーク"
end

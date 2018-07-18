name 'base'
default_source :supermarket
default_source :chef_repo, '../' do |s|
  s.preferred_for 'base'
  s.preferred_for 'resource_bowl'
end

run_list 'base'

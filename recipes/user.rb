include_recipe 'chef-vault::default'

chef_vault_item('group', node.policy_group)['groups'].each do |g|
  group g['name'] do
    gid g['id']
    action :create
  end
end


chef_vault_item('user', node.policy_group)['users'].each do |u|
  case u['state']
  when 'enable'
    group u['name'] do
      action :create
      gid u['id']
    end

    user u['name'] do
      action :create
      comment u['comment']
      uid u['id']
      gid u['id']
      manage_home true
      shell u['shell']
      password u['password']
    end

    u['groups'].each do |grp|
      group grp do
        action :modify
        members u['name']
        append true
      end
    end

    directory "/home/#{u['name']}/.ssh" do
      action :create
      owner u['name']
      group u['name']
      mode '0700'
    end

    file "/home/#{u['name']}/.ssh/authorized_keys" do
      action :create
      owner u['name']
      group u['name']
      mode '0600'
      content u['ssh_keys']['public']
    end

    file "/home/#{u['name']}/.ssh/id_rsa.pub" do
      action :create
      owner u['name']
      group u['name']
      mode '0644'
      content u['ssh_keys']['public']
    end

    file "/home/#{u['name']}/.ssh/id_rsa" do
      action :create
      owner u['name']
      group u['name']
      mode '0600'
      content u['ssh_keys']['private']
    end

    sudo u['name'] do
      user u['name']
      commands ['ALL']
      runas 'ALL'
      nopasswd true
    end

  when 'disable'
    user u['name'] do
      action :remove
    end
  end
end

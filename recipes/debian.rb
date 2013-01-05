package "fontconfig"

#--------
# enable multiverse
#--------
# from http://askubuntu.com/a/173562
execute "enable multiverse" do
  command "sed -i '/^# deb.*multiverse/ s/^# //' /etc/apt/sources.list"
  not_if "egrep '^deb.*multiverse' /etc/apt/sources.list"
  # notify "apt-get update" resource found in apt cookbook
  notifies :run, resources(:execute => "apt-get update"), :immediately
end

#--------
# install mscorefonts
#--------
# from http://askubuntu.com/questions/16225/how-can-i-accept-microsoft-eula-agreement-for-ttf-mscorefonts-installer
bash "run ttf-mscorefonts-installer" do
  user "root"
  code <<-EOS
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  apt-get install -y ttf-mscorefonts-installer >/dev/null
  EOS
  not_if "test -e /usr/share/fonts/truetype/msttcorefonts/arial.ttf"
  notifies :run, "execute[regenerate fontcache]"
end

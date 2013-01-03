#--------
# enable multiverse
#--------
# from http://askubuntu.com/a/173562
execute "enable multiverse" do
  command "sed -i '/^# deb.*multiverse/ s|^# ||' /etc/apt/sources.list"
end

#--------
# runs apt-get update
#--------
include_recipe "apt"

package "fontconfig"

# from http://askubuntu.com/questions/16225/how-can-i-accept-microsoft-eula-agreement-for-ttf-mscorefonts-installer
bash "run ttf-mscorefonts-installer" do
  user "root"
  code <<-EOS
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  apt-get install -y ttf-mscorefonts-installer
  EOS
end

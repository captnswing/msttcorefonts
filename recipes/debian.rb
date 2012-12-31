package "fontconfig"

# from http://askubuntu.com/questions/16225/how-can-i-accept-microsoft-eula-agreement-for-ttf-mscorefonts-installer
bash "run ttf-mscorefonts-installer" do
  user "root"
  code <<-EOS
  echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
  apt-get install -y ttf-mscorefonts-installer
  EOS
end

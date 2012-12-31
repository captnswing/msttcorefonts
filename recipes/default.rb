#
# Cookbook Name:: chef-msttcorefonts
# Recipe:: default
#

# rhel 6 http://oimon.wordpress.com/2011/09/05/msttcorefonts-on-rhel6-centos-6-sl6/

include_recipe "yum::epel"

["cabextract", "ttmkfdir", "xorg-x11-font-utils"].each do |pkg|
  package pkg
end

remote_file "#{Chef::Config["file_cache_path"]}/msttcorefonts.spec" do
  source "http://corefonts.sourceforge.net/msttcorefonts-#{node["msttcorefonts"]["version"]}.spec"
  action :create_if_missing
  mode "0644"
end

execute "rpmbuild msttcorefonts.spec" do
  cwd Chef::Config["file_cache_path"]
  # increase the timeout in the spec file before running rpmbuild
  command "sed -i s/timeout=5/timeout=15/g msttcorefonts.spec; rpmbuild -bb msttcorefonts.spec"
end

#---------------
# install local.conf
#---------------
# from https://wiki.ubuntu.com/Fonts
cookbook_file "/etc/fonts/local.conf" do
  source "localfonts.conf"
  mode 0644
end

#---------------
# regenerate font chache
#---------------
bash "regenerate fontchache" do
  code "fc-cache -fv"
end

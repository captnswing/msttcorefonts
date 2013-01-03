#
# Cookbook Name:: chef-msttcorefonts
# Recipe:: default
#

#---------------
# install msttcorefonts
#---------------
case node["platform"]
  when "centos", "redhat", "scientific", "fedora"
    include_recipe "chef-msttcorefonts::rhel"
  when "ubuntu"
    include_recipe "chef-msttcorefonts::debian"
end

#---------------
# install improved local.conf
#---------------
# from https://wiki.ubuntu.com/Fonts
cookbook_file "/etc/fonts/local.conf" do
  source "localfonts.conf"
  mode 0644
end

#---------------
# regenerate font cache
#---------------
bash "regenerate fontchache" do
  code "fc-cache -fv >/dev/null"
end

name             "chef-msttcorefonts"
maintainer       "Frank Hoffsümmer"
maintainer_email "frank.hoffsummer@gmail.com"
license          "Apache 2.0"
description      "Installs Microsoft corefonts on linux boxes"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"

depends "yum"

supports "scientific", ">= 6.0"
supports "ubuntu", ">= 10.04"

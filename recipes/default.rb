#
# Cookbook Name:: paco
# Recipe:: default
#
# Copyright 2011, kamimoo
#
# All rights reserved - Do Not Redistribute
#

include_recipe "build-essential"

paco_version = node[:paco][:version]
configure_flags = "--disable-gpaco"

remote_file "#{Chef::Config[:file_cache_path]}/paco-#{paco_version}.tar.gz" do
  source "http://jaist.dl.sourceforge.net/project/paco/paco/#{paco_version}/paco-#{paco_version}.tar.gz"
  action :create_if_missing
end

bash "compile_paco_source" do
  cwd Chef::Config[:file_cache_path]
  code <<-EOH
    tar zxf paco-#{paco_version}.tar.gz
    cd paco-#{paco_version} && ./configure #{configure_flags}
    make && make install
    make logme
  EOH
  not_if "which paco"
end

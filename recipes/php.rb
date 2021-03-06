#
# Cookbook Name:: oracle-instantclient
# Recipe:: php
#
# Copyright 2011, Joshua Buysse, (C) Regents of the University of Minnesota
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# installs from remote files
# requires the default recipe

include_recipe "oracle-instantclient::sdk"

if node[:kernel][:machine] == "x86_64" then
  arch_flag = ".x64"
else
  arch_flag = ""
end

# we need expect to build the pecl module
pkg_list = value_for_platform(
    ["centos","redhat","fedora", "scientific"] =>
        {"default" => %w{ expect expect-devel }},
    [ "debian", "ubuntu" ] =>
        {"default" => %w{ expect expect-dev }},
    "default" => %w{ expect expect-dev }
  )

pkg_list.each do |pkg| 
  package pkg
end

template "/var/tmp/install_pecl_oci8.exp" do
  source "install_pecl_oci8.exp.erb"
  mode "0755"
  owner "root"
end

php_conf_dir = value_for_platform(
	["centos","redhat","fedora", "scientific"] => 
		{"default" => "/etc/php.d"},
	"default" => "/etc/php5/conf.d"
  )

template "#{php_conf_dir}/oci8.ini" do 
  source "oci8.ini.erb"
  mode "0755"
end

php_lib_dir = value_for_platform(
	["centos","redhat","fedora", "scientific"] => 
		{"default" => "/usr/lib/php/modules"},
	"default" => "/usr/lib/php5/20090626"
  )
execute "build_php_oci8_mod" do
  command "/usr/bin/expect /var/tmp/install_pecl_oci8.exp"
  not_if "test -f #{php_lib_dir}/oci8.so"
end

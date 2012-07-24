#
# Cookbook Name:: cla_tsfarm
# Recipe:: default
#
# Copyright 2012, Adam Mielke, (C) Regents of the University of Minnesota
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

# Install the following roles:
# AppServer - Remote Desktop Session Host
# AppServer-UI - Remote Desktop Session Host Configuration Tools
# FailoverCluster-FullServer - Failover Clustering
# SessionDirectory - Remote Desktop Connection Broker
# SBMgr-UI - Remote Desktop Connection Broker Configuration Tools

%w{AppServer AppServer-UI FailoverCluster-FullServer SessionDirectory SBMgr-UI}.each do |feature|
  windows_feature feature do
   action :install
  end
end

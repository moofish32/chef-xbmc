#
# Cookbook Name:: xbmc
# Recipe:: live
#
# Copyright 2010, Fletcher Nichol
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

include_recipe "users::sysadmins"
include_recipe "xbmc::apt_repository"
include_recipe "xbmc::core"

user "xbmc" do
  comment   "XBMC User"
  shell     "/bin/bash"
  supports  :manage_home => true
  home      "/home/xbmc"
end

# add xbmc user to required groups
%w{audio video fuse cdrom plugdev sysadmin}.each do |grp|
  group grp do
    append true
    members ["xbmc"]
  end
end

%w{xbmc-live}.each do |pkg|
  package pkg
end

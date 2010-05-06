
require 'rubygems'
require 'sinatra'
require File.dirname(__FILE__) + '/../lib/ec2'
require 'index'

get '/' do
     ec2.list.each do |inst|
      printf "%-50s %-12s %s\n", inst[:hostname], inst[:instance_id], inst[:status]
    end
end

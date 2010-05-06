
require 'rubygems'
require File.dirname(__FILE__) + '/../lib/ec2'
require 'thor'

class CLI < Thor
  desc "list", "list all instances"
  def list
    puts "All instances"
     ec2.list.each do |inst|
      printf "%-50s %-12s %s\n", inst[:hostname], inst[:instance_id], inst[:status]
    end
  end

  desc "resources", "list by hostname or instance ID"
  def resources(id=nil)
    inst = ec2.find_instance(id) || ec2.running.first || abort("No running instances")
    hostname = inst[:hostname] || wait_for_hostname(inst[:instance_id])
    #display_resources(inst[:hostname])
    printf "\n---------------------------------------------------------------------- \n"
    printf "%-50s %-12s %s\n", inst[:hostname], inst[:instance_id], inst[:status]
    printf "-----------------------------------------------------------------------\n"
  end

  no_tasks do
    def ec2
      @ec2 ||= Ec2cloud.new
    end
  end


end

CLI.start



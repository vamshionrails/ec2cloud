require 'AWS'
require 'yaml'
require 'socket'

class Ec2cloud

  #list all instances
  def list
    result = ec2.describe_instances
    return [] unless result.reservationSet
    instances = []
    result.reservationSet.item.each do |r|
      r.instancesSet.item.each do |item|
        instances << {
          :instance_id => item.instanceId,
          :status => item.instanceState.name,
          :hostname => item.dnsName
        }
      end
    end
    instances
  end

  def find_instance(instance_id_or_hostname)
    return unless instance_id_or_hostname
    instance_id_or_hostname = instance_id_or_hostname.strip.downcase
    list.detect do |inst|
        inst[:hostname] == instance_id_or_hostname or
        inst[:instance_id] == instance_id_or_hostname or
        inst[:instance_id].gsub(/^i-/,'') == instance_id_or_hostname
    end
    end




  def config
    @config ||= default_config.merge read_config
  end

  def default_config
    {
      'user' => 'root',
      'ami' => 'ami-ed46a78',
      'availability_zone' => 'us-east-1b'
    }
  end

  def ec2_dir
    "#{ENV['HOME']}/.ec2"
  end

  def read_config
     YAML.load File.read("#{ec2_dir}/config.yml")
   rescue Errno::ENOENT
     raise "Ec2  is not configured, please fill in ~/.ec2/config.yml"
   end

   def ssh(hostname, cmds)
     IO.popen("ssh -i #{keypair_file} #{config['user']}@#{hostname} > ~/.ec2/ssh.log 2>&1", "w") do |pipe|
      pipe.puts cmds.join(' && ')
    end
     unless $?.success?
       abort "failed\nCheck ~/.ec2/ssh.log for the output"
     end
   end

   def ec2
     @ec2 ||= AWS::EC2::Base.new(
                                 :access_key_id =>'01B2B8F8QAVMKZ02TK02',
                                 :secret_access_key => 'E+eqc9YKFi9qBKGSm8rVRFaeJaODIseMlF0IRG1Y',
                                 #:server => server
                                 )
   end

  def server
    zone = config['availability_zone']
    host = zone.slice(0, zone.length - 1)
    "#{host}.ec2.amazonaws.com"
  end




end

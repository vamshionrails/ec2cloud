 #!/usr/bin/env ruby

  require 'rubygems'
  require 'AWS'

  ACCESS_KEY_ID = '01B2B8F8QAVMKZ02TK0'
  SECRET_ACCESS_KEY = 'E+eqc9YKFi9qBKGSm8rVRFaeJaODIseMlF0IRG1Y'

  ec2 = AWS::EC2::Base.new(:access_key_id => ACCESS_KEY_ID, :secret_access_key => SECRET_ACCESS_KEY)

  puts "----- listing images owned by 'amazon' -----"
  ec2.describe_images(:owner_id => "418548355021").imagesSet.item.each do |image|
    # OpenStruct objects have members!
    image.members.each do |member|
      puts "#{member} => #{image[member]}"
    end
  end


require 'ownlan/application'
require 'ownlan/config.rb'
require 'ownlan/cli'
require 'ownlan/attack/base.rb'
require 'ownlan/attack/client.rb'
require 'ownlan/attack/fake_ip_conflict.rb'
require 'ownlan/attack/gateway.rb'
require 'ownlan/attack/ntoa.rb'
require 'ownlan/manual/capture.rb'
require 'ownlan/manual/broadcast.rb'
require 'ownlan/protect/freeze.rb'
require 'ownlan/protect/resynchronize.rb'
require 'ownlan/protect/static.rb'
require 'ownlan/protect/stealth.rb'
require 'ownlan/service_objects/craft_arp_packets'
require 'ownlan/service_objects/send_arp_packets'
require 'thread'
require 'trollop'

module Ownlan

  def self.load(opts)
    Ownlan::Application.new(opts).call
  end

end

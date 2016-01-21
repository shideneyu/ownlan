module Ownlan
  class Cli

    def self.options
      Trollop::options do

        version "OwnLan (c) 2016 Sidney Sissaoui, published under the MIT Licence"
        banner <<-EOS

-- Ownlan is a simple, useful yet awesome pentesting LAN poisoning suite. --

Usage:
      ownlan --[options] [sub-options] --[other-option]

Example:
      ownlan --attack client --target-ip 192.168.0.1 --interface eth0 --delay 0

where [options] are either:
EOS

  opt :attack, "Set an attack on a device on the network",  short: 'a', type: :string
  opt :protect, "Protect a device from lan attacks",        short: 'p', type: :string
  opt :broadcast, "Inject ARP crafted packets in the wire", short: 'b', type: :string
  opt :capture, "Sniffing ARP packets on the network",      short: 'c', type: :string

# Attack part
banner <<-EOS

where [sub-options] are either:

Attacks sub-options   :
  client              Set a First-Duplex disconnection attack (the client is targeted). If no source mac argument, yours will be given (useful for MITM Attacks).
                      * Required options: victim_ip
  gateway             Set a Second-Duplex disconnection attack (the gateway is targeted). If no source mac argument, yours will be given (useful for MITM Attacks).
                      * Required options: victim_ip
  ntoa                The client is targeted to get disconnected, using a neighbour table overflow attack. Requires a victim ip.
                      * Required options: victim_ip
                      * Falcultative options: random_source_mac
  fake-ip-conflict    Generate a fake ip conflict to the victim. Can be used along all the others attacks, or alone.
                      * Required options: victim_ip
  EOS


# Protect part
banner <<-EOS

Protect sub-options:
  stealth          Becomes invisible from network scanners, preventing you from getting targeted.
  static           Set a static ARP Cache for the current session. Good against first-duplex ARP Cache Poisoning.
  freeze           Reset and Freeze your ARP Cache. Good against NTOAs.
  resynchronize    Resynchronize the Gateway ARP Cache by sending to it continuous healthy correspondancies packets to protect someone or yourself from gateway attack. (reveive IP or MAC argument)

  EOS

# Broadcast part
banner <<-EOS

Send sub-options:

  EOS

# Capture part
banner <<-EOS
Capture sub-options:

  EOS

# Other options part
banner <<-EOS
Other Options:

  EOS

  opt :delay,              "Set the time lapse delay between each packet", default: 0.5
  opt :interface,          "Set the network interface which will be used", short: 'i', default: 'wlan0'
  opt :random_source_mac,  "If setted, the used origin addresses will be randomly generated. If not specified, the mac of your given interface will be used #{mac=ServiceObjects::NetworkInformation.self_mac('wlan0') ; ', in your case ' + mac + ' for wlan0' if !mac.empty?}"
  opt :victim_ip,          "Set the ip of the target ip address.", short: 't', type: :string
  opt :source_mac,         "Set the mac of the source mac address.", short: 's', type: :string

      end
    end
  end
end

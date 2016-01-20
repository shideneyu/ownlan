module Ownlan
  class Cli

    def self.options
      Trollop::options do

        version "OwnLan (c) 2016 Sidney Sissaoui, published under the MIT Licence"
        banner <<-EOS

-- Ownlan is a simple, useful yet awesome pentesting LAN poisoning suite. --

Usage:
      ownlan [options] [sub-options] -i [interface]

where [options] are either:
EOS

  opt :attack, "Set an attack on a device on the network",  short: 'a'
  opt :protect, "Protect a device from lan attacks",        short: 'p'
  opt :broadcast, "Inject ARP crafted packets in the wire", short: 's'
  opt :capture, "Sniffing ARP packets on the network",      short: 'c'

# Attack part
banner <<-EOS

Attacks sub-options. --attack [suboption] [targetIP] [sourceIP]   :

  EOS

  opt :client,  "Set a First-Duplex disconnection attack (the client is targeted). If no source IP argument, yours will be given (useful for MITM Attacks).",    type: :string
  opt :gateway, "Set a Second-Duplex disconnection attack (the gateway is targeted). If no source IP argument, yours will be given (useful for MITM Attacks).", type: :string
 
  opt :ntoa,              "The client is targeted to get disconnected, using a neighbour table overflow attack.", type: :string
  opt :fake_ip_conflict, "Generate a fake ip conflict to the victim. Can be used along all the others attacks, or alone."

# Protect part
banner <<-EOS

Protect sub-options:

  EOS
  
  opt :stealth,       "Becomes invisible from network scanners, preventing you from getting targeted."
  opt :static,        "Set a static ARP Cache for the current session. Good against first-duplex ARP Cache Poisoning."
  opt :freeze,        "Reset and Freeze your ARP Cache. Good against NTOAs."
  opt :resynchronize, "Resynchronize the Gateway ARP Cache by sending to it continuous healthy correspondancies packets to protect someone or yourself from gateway attack. (reveive IP or MAC argument)"

# Broadcast part
banner <<-EOS

Send sub-options:

  EOS

# Capture part
banner <<-EOS
Capture sub-options:

  EOS

# Common part
banner <<-EOS
Common Options:

  EOS

  opt :delay,     "Set the time lapse delay between each packet", default: 0.5
  opt :interface, "Set the network interface which will be used", short: 'i', default: 'wlan0'
  opt :random_mac, "If setted, the used origin addresses will be randomly generated. If not specified, the corresponding mac of your given interface will be used #{mac=ServiceObjects::NetworkInformation.self_mac('wlan0') ; ', in this case ' + mac + ' for wlan0' if !mac.empty?}"

      end
    end
  end
end

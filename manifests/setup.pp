# Puppet manifest for setting up my mt-daapd server
class daap_server::setup($music_dir = '/srv/music', $collection_name = 'Secondary DAAP Server')  {
   include 'avahi'

   package { 'mt-daapd':
     ensure => latest,
     require => Service['avahi_dbus'],
   }

   file { '/etc/mt-daapd.conf':
     ensure  => present,
     content => template('daap_server/mt-daapd.conf.erb'),
     owner   => 'root',
     mode    => '640',
     require => Package['mt-daapd'],
     notify  => Service['mt-daapd']
   }

   service { 'mt-daapd':
     ensure     => running,
     enable     => true,
     hasrestart => true,
     require    => [ File['/etc/mt-daapd.conf'], Package['mt-daapd'], Exec["mkdir $music_dir"] ]
   }

  exec { "mkdir $music_dir":
     path    => [ '/usr/bin', '/bin' ],
     command => "mkdir -p $music_dir",
     unless  => "[ -d $music_dir ]",
     notify  => Service['mt-daapd'],
     require => Service['avahi_dbus']
  }
}

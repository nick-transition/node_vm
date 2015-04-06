
file { '/etc/motd':
    content => "- OS: Ubuntu 14.04 \"trusty\" server-amd64
- iojs: stable (1.6.x) 
- Packer: stable (0.7.x)
- Docker: stable (1.4.x)
\n"
}

# class loadEnv {
  # Exec { path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'], }
# }

# class {loadEnv: }



# exec { "deps.sh":
#   command => "sh deps.sh",
#   owner => "root",
#   group => "root",
#   logoutput => true,
#   require =>Exec["update.sh"],
# }

# Make all the magic happen by instantiating the nodejs class
# class { nodejs: }

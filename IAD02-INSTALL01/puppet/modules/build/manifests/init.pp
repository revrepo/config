class build::basic_packages {

    package { "git": 
        ensure => installed 
    }

    package { "openjdk-7-jre-headless:amd64": 
        ensure => installed 
    }

#    include nodejs

#    package { "npm":
#        ensure => installed
#    }

#    package { 'forever':
#        ensure   => installed,
#        provider => 'npm',
#    }

#    package { 'mocha':
#        ensure   => installed,
#        provider => 'npm',
#    }

#    package { "nodejs-legacy":
#        ensure => installed
#    }
}

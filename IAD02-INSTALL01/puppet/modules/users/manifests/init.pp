

define add_user ( $name, $uid, $password, $shell, $groups, $sshkeytype, $sshkey) {

 $homedir = $kernel ? {
  'SunOS' => '/export/home',
  default   => '/home'
 }
 
 $username = $title
 user { $username:
  comment => "$name",
  home    => "$homedir/$username",
  shell   => "$shell",
  uid     => $uid,
  gid => $uid,
  managehome => 'true',
  password  => "$password",
  groups => $groups
 }

 group { $username:
  gid => "$uid"
 }

 ssh_authorized_key{ $username: 
  user => "$username",
  ensure => present, 
  type => "$sshkeytype", 
  key => "$sshkey", 
  name => "$username" 
 } 
}


class users::default_admins {

	group { "sysadmin":
		gid => 999 
	}

	add_user { victor:
		name    => "Victor Gartvich",
	  	uid      => "1001",	
	 	password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
	  	shell => "/bin/bash",
		groups => ['sudo', 'victor', 'sysadmin'],
		sshkeytype => "ssh-rsa",
		sshkey => "AAAAB3NzaC1yc2EAAAABIwAAAQEAz2DA26A13z5Dyp3Jx2LWczHb1/u81RuAELxOCEAHS1RkiqjshlZw8NAitIQEBvclhSTtgnRWCPGLV1cQ0XCONe4nn5XYJWAj4m1gjW+Lf7H/Yj9JsGqURqLf6uEZ8pGZieS+gygtqEpcqCzA0zMGVrWbufm4iHrS8tBvWj6D3eiqPQc2Uyz0RQjJohLDW1nFM6MmkhczG3hLM5IbHGyncuE1tIWF3h0JntzxEeccuMUKKMCyqr3ic2i8uKzogoSOMJSZ2lTVlarAWgUofC2+YzIZjn+tO6PUH7o6+cbJmZvMQf6TbeGnhzcMGqYGwZUugZAionLvknBdlCyyaisZEQ=="
 	}

        add_user { jon:
                name    => "Jon Bosanac",
                uid      => "1002",
                password => '$1$abcedfghijklkmnopqrstuvwxyz',
                shell => "/bin/bash",
                groups => ['sudo', 'jon', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAACAQCzF1LmDKvouJOoO1m3+W5J4uw+Z/LEU+OXHNj49VCOsk4nMrZxpRV9u5aQFabb2dThL3Utriu0b3FxbtzalfxeQ2WU9e7nZyApilXVoJrff9fYHzzvCXkU2kvMzqV7vP4P4wsl6S0u0+Lq14mkeX4St44uwcHiwYCnv+BaEenCSM/5y+haGmOy2QkKyniEzcbxr/tL2iawGz0DCqqJo+eRp8w8EK/TAAEIAxJHN07hjLI4P5GsPpZiFR/Z+hT3WQc+GPpIM4NjI8i7hP0JlPihesluk6Wibw+mRYIlG6kxdOP9SdnyUEFY4aD2AHBzLa7yUZNwg6oC7G7CfK0ifsosypuVUjCE80AhSf1HjqQwEQpFxBXzPTk7w+p976CzKY4VPO8CbhykoBVNBaOndang3OQ3moyaWIriww6YjxJNzprDJO+i6iH/VwQ/MSr+b5GZxasSk4YT7Ti3DBuL2A1T6nUSlvoNszHd6tx5EKiMgq1S7HUypyU/+mNWYwUQjyXrEdKXyZR7QKjCbrYBT2NqZa4m9w3DZHwYJv9HU1vAW2FvXatrXTTJq1zf7+Crz3oQDwSQ92ichshajtw25RyNvLDXukD4s6fpShLBnBFpcQy4bCnJqYyrGehXGUL7itWI/cbZ04FDo+btFtKHLIKiMGwD/+DOAs86rkbd9hD2Dw=="
        }


        user { ajit:
		ensure => absent,
 		home => '/home/ajit'
        }

       user {'sreeni':
               ensure => absent,
       }

       user {'tom':
               ensure => absent,
       }

       user {'sorin':
               ensure => absent,
       }

       user {'sidde':
               ensure => absent,
       }

       user {'prashant':
               ensure => absent,
       }

       user {'akhil':
               ensure => absent,
       }

       user {'stephen':
               ensure => absent,
       }

       user {'moty':
               ensure => absent,
       }

	user {'mark':
		ensure => absent,
		home => '/home/mark'
	}

       user {'vbrunko':
               ensure => absent,
       }

        add_user { igor:
                name    => "Igor Kukushkin",
                uid      => "1055",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'igor', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC6NRQDzVHcLanbpsFSxdVULXQyYSbQ4ggMevPV0IU6wdUHgjYlduqcxDwabadQtIBCyBgDtTOHgjuJetIWa6rWyDMtC1IGhL75AqTFPI88CENlwo9JJW4D3bUNg9iL2zvkTqP0q1Q7P6wWykM1RiJx/j54nd7G3E1heOPLvUEZd91AFWsVBpmKizwby45aFFEKkk2PzmVioDmPnwGK4fNhwVzlr2e6zCKqw/eRY2Jkyjl9ZLdRH7/OJMDxK/hh2FFI2YxZ6f56J1qeOw1pALKEQAmvRaYtoB+qoeorfa7s2ZmePT0pCLzXz2afKSubcKR+bOBXk4hUU7EX9bsm4tgN"
        }

        add_user { dmitry:
                name    => "Dmitry Mamas",
                uid      => "1057",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'dmitry', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDGD7FSYs4gb9qMHpcFMKaw9xH2fWHglEwNl36KnW5CBKHKq/QXRuqchj5umOag3Afuo/U2ZbeTZc/IlOPufsuDF69VeBBuSCM7foYrlw1v4mFzNTmnCq4k5BiH6ain6qCbHYlVTQU+jQTQNUXa1eohZ6Zmwn9aJoTWj4ZVPVPE4+595DZTpxl0uFHVEjXiCg83LUDc07sFScs+XsbPRg12s5teJwiV4iyO+ex7PjYupBbrk9hUxLq4oYKP2IL9FhWfmkZSmMpWel1G9YXtY8nBKQt42Qykqj12WbxgmgFt0MzosHPUU29qe6y7/K7TsiRIQxNRzyN0iP4Yhs9bLyYx"
        }

       user {'vlad':
               ensure => absent,
       }

       user {'alex':
               ensure => absent,
       }

       user {'peter':
               ensure => absent,
       }

        add_user { yuri2:
                name    => "Yuri Kobrynyuk",
                uid      => "1067",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'yuri2', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDtlZ97TNc1yTJFmqIbFJtW8aYldhCNU0croeacBG5roJjffhsXdCFhR2NZMbZUf2e5BDoJBaAa3/WhNvfbQJhEZM9hHbe673vgp16PkqenFEc2CDAVBOlosngHlnVyrK/Djdj1T7Ce+F0g5c7JuBHWP+2vy8otsz9d41/33UTbYPTbvsLokiz36anOtNBRrw1dq/3euWYMGKMxNhIMxrLNdIkbtZhG7SR4p+XROZOXUsfmqAua4x3LwFtv987P2WegV84EGnWfHdkGdgbFW0+48YDiLyylml1VZ15KQHU0t6BB0v3UgymIdKzVRm/TJqDBEJU+4ae8oRbpjBJLlbdh"
        }

        add_user { yegor:
                name    => "Yegor Betin",
                uid      => "1066",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'yegor', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAABJQAAAQEAkBomTVaU0BWNgxCmV05KYt55/yY+6U7j019dZhaggVNGTDCxLKQmUWFzkm4enBO0fssQWu7wblesXi1arM4W9L1L0+GNSZ8vht3o2zh4f//Hr9xfKoeQSfcNOL9qIBKh7YEVla4b4v9ErcqoYl+zdYeaG4xKXYEhTlVg4+5/ZcGkkznLBFWqfr5Gm0TX/DYUeb7SVgEIQkmeI+r/HpMjb4JBZBc4vH68SgmxAIJyrEQzOdg9Tws0UXz9kPfFbm21IChm1ut/ZnxKmYaDmJB38O1/1EVqScNOPupDImI4dangZu2N6L8H0ZmuonnyxCu98JFcD1WREgCOh+Vj6YyiMQ=="
        }

        add_user { nikolay:
                name    => "Nikolay Gerzhan",
                uid      => "1070",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'nikolay', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDK21zpHrkVgSSYYTOMnsRCZCvGapPNxdZb4Jf6EDqn203/TXdIeeExm+Q+57wK4HcXtOpdOZSHu78DKtFuBnEfoxvFxE33BbXNBqFX/G3L7VR4ZCLPNCWM+mYUKCKIm9Y2xep/KLeU0KXnPqHi67fl1u12LXHRXoWbymAd4Luf/j4xeZsoJyB3qlON/Fy6nTJIVF/bhvWTaASuT1xTBQ8/I9VkH6yU6fAWIvbpeBkqeukSAlNcXUpdNI44y6tZuZ9Y10wakwYgindPzC097Q3sHspCze8udT0jNoCc2c6fbtAL1z4PtmK1pIbhWyZxcdzj0M5Dl0rMKYN7OxU5Rl7l"
        }

        user { tim:
                ensure => absent,
                home => '/home/tim'
        }

        add_user { alexus:
                name    => "Alexus Petrov",
                uid      => "1075",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'alexus', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAABJQAAAQEAs8eAayEExvDovIYOhKDmB7KLrs9ya6nqcIMgc/XWJNK9TfW7dzt/5e6rgeF7tSjfj2q+hv8FUwdiLA+XMgsQJSsIrFbYW0EXxW8oRJEs0Qr+N+BYR2JdVd53QY8hPBJ3v7Jnpd77mnOU9klkcwdDk99TOxZHXJcMPpYwKeUn8JddP3TTj/Yr1DCQ3dM8nteSBfmTQLH81md936tumCoj/96kP0Uv2/9fGLANO1fpZZ17kMVF/NLnJEH9GQEtFwjsRW6V8oJ/mQOKiuutSob8leyXrLuPnbt4ZGPIE/uHt8nXOfFlvi7g48KTXxQo/x36dUJPu8b8M8hdoxNldQvyqQ=="
        }

        add_user { sergey:
                name    => "Sergey Drobot",
                uid      => "1076",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'sergey', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDGkI2h8Wt3Qasy0//r45h/dLnEFwz7tFkNfgKiqAt+fxOY5QSzGO4RtU64b6jfrMqf51C9iYcn7bLGJt3Gd9omxI2hTVc5AX6nDTXpZZbvX9Ds0x6szg+wItmc7YS9DjN/+lGZ6tYGBQ2LiIbwBjOJQ4ZO1ghDh6Bn4w9xTXoMJgxMrUYDzAfePtRB/aL4fGhvn+BsRnvBbdRidQDHYr8dsFh2UQHqigp4aP+Ruc+J6wf2aTwIgvIAjrZeF5M/vr5RzwLlez6O/xVDoDdebVcsGRhG7T7bZGdwNUxdImz9Ervofwl1dz2RjRlEbgqvzQUPXhKwrWFVaUHlhBIVUtbf"
        }

}



class users::robot {

        add_user { robot:
                name    => "System user for robots",
                uid      => "1050",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'robot', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDBDZy2VOoE0AoRN870mZyYC1O3vRRO0Uzk9QHExde3bHC9JSqSquK+82EKlKZnPkBoglKefurIkKFboWQaQG9M+qLtYtYSugAjpmQjxTsiztacvshBjTScaXSgGmhTp4gXFgkbB4iA4Z/fWbA7MV00vi6S7q1G7FS1hj76wpeUpr43bdhusbwDMgo3XV+p+jmz16czyQGzL1KgJnaHB+/OOfuFcQdmZtKTGpUDBAcNLGYy5Rh4RVuBi/uY0IFjsqXS8TjNUSWV0VoqylNq9oi5y3Z7dKeCPFsaIHigqQ71m0E2rttc1uN8W1lzymP43eis5T7Y26bcFiL7iB7InY+P"
        }
}


class users::qa_users {

       user {'konstantin':
               ensure => absent,
       }

        user { 'minor':
                ensure => absent,
		home => '/home/minor'
        }

       user {'efedotov':
               ensure => absent,
       }

       user {'yuri':
               ensure => absent,
       }

       user {'david':
               ensure => absent,
       }

       user {'strajan':
               ensure => absent,
       }

       user {'jovan':
               ensure => absent,
       }

        add_user { leo:
                name    => "Leo Flores",
                uid      => "1061",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'leo', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAACAQDRZ6X90+iH96MauxaSj8l/lAohvZ29uHMAosE0F1UoxSl3iz9HT2OAUn7jJloW6t8afxVcc13CUcPEuPYFyKVRyf5+qJnwonBzGHSm7iTVZiMVEeZOqmVug++4/q2IJ0KK5m8epvQ+4XScIoLs6TQU+UaNOoq+yIqFet6hSUArQGr/B5W0WRayEWHw1fwco6Gb/EiZrjYn0yqtebkTsfjI73Lbi7QwxMeToNWiYYmJ9UfQ+i9oJOMkyRJhLYXG1YwJoec3+GUBHu8MRsoBcgqY8N0T/gJRC9TTUPjlsrf2536TSv6qOX4SNiB5NNLgGjE2JmayJqSuhJo8k86Wf9E0d01k4SwgtdSrdEqTCTUmYvneI8/fU0S/C25R0MWvJusU81mIkHiclAMm2h3/U42N/LNH0i/H4Zd5roAWxjtwQ2yKasLBLFxobJ84oSYw52xXYVkxhpt19jpNhV2BbXX8c0rojU6jSgYWCJYwVAqI/97fNQfdxyYB7gGgfsrA9ntBIngdEgJlAOPf70O2YDagxzzf+wiQrTpvSRAhOGYrCKXQOkTfgnyciQGt5irh+PGo294UXB5d7KTgctyW5qdWfnc175cK+ngZ/4J86Wk/5NEa6FGMfHBDQHFBMY+s8RZwe6aNJHy4UZsU7OHsvYtlzQBXCz2GscNgXyGY947zyw=="
        }

       user {'denis':
               ensure => absent,
       }

       user {'andrey':
               ensure => absent,
       }

       user {'ivan':
               ensure => absent,
       }

       user {'viktor':
               ensure => absent,
       }

       user {'dmitry2':
               ensure => absent,
       }

        add_user { arayik:
                name    => "Arayik Chaparyan",
                uid      => "1073",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'arayik', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQC6Ha3bl+7Wli3iCFS7tanuZjw12ve++tmdtvYesbctZ1AXrpNtwbAH0N6NvLXxfDfYOvhjyr0g0/paAQ+XBswz5xX3/c5qe3puREU4XrviXgh9UGnct9atgcGkjkWkGXPawzDwBjp0Vi77QzvyffXEpMBo8LxjjQgDO490Q8Yx0R3610UCOGDqRQ1FizdXzuLnqY4Jpr6HCMzsjfYgs5NHcJdg7dM4XOx+A4FJmX3ye1sZSA4+vTpQ87YydlIXPGf/M9vVmJKcXPH1KRLRDggPlCCVKHg+ECGj5MRMV6nq0BtSV1xAnm/eR6kcTnAl4YDCnbuwGTKtSlEIS4Pj+isr"
        }

        add_user { konst2:
                name    => "Konstantin Tutulnikov",
                uid      => "1077",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'konst2', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAACAQCQXxQI4VgeGMcrJ7O5TePuKQspNDI21dXVYK8RBBmk6SUm6nYPU6Ymrjc/PvBsT7rc/PaZo6zHvmHsfv51+hUPICZlH2ULRymQ/tukilQHpgYBBBMJo/5Q7hdZ3QqrT3ik0nKCTz8oq3YV88ZekRDv568x2XFKhf4EZoS9YTFXMf1tjsCk3C+6UYC1/qHD8FFiaoYlZGTJBFLFXZml0S/qDEXwZRS3mSbhG+HscH9mW1mOWOcgbuyAG01fVzLd3EoXLObjIqUJZw3DWSRAjIMDgKNmb/O2K4EYXz8cT9PWN04qArSmCV/j1OvaOvMTXTe98G52iwTxfB0VyAnRDRjfsEmCWaml/oxGmlXWtyzD/5EcrKWuzz6T5O9EuUVK5e6Wbg7NQbbRS3cejTpoNQCAuALzSjUb2qM9mohmIDJ3Ekph5p63dxTHi512BIkE8otrDtZxMjQ+Lu+wfVSCQlYWLnVg5+mjngUcXjeYeSxLSisvKguyubttexPXKhnHT+eCMEDctXU9cquS2jyNE+wqncs1HKgKxpyGALAa6FExmvcT4xSbESP0EPfymuTOlwm7PIfzGSKY+3lm231yG5yzXcsNZmsGo+L7ozAL3Yzn3PgMy9lTyM1jk3cbqo4fyAXatyIbEfDMRvvDJLYoJV69S9Y9RgS+OsHpEyHJL//BOQ=="
        }

        add_user { asher:
                name    => "Asher Moshav",
                uid      => "1078",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'asher', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAABJQAAAQEAz49nxGnqIRRuXzCGxX2rpFctl2EYxOMTuBGnyCv+rsIdxutKNnZp8q58lhRaHKSE2H6lQonzKs+bHt83TC0Y3oQkfR3fWjkKWHPCg/QEQnp5a0/AjmM1azobtLDeoJ/rPOYd08MgkDa8W6UEKau3c5xUhWnv3TpQVIALkngjWvCSr8rIAKdAj3bbY4pHprSTzgRBxXOWsV10OsNslZ18OyTbhBMcrkgP69icMAmodRPM3VGPzuV0S/cd+LDP5pCIwWJPqJrc9/TgEzftjxO/1MunJH5tirXffKV/NB62N/K/Ozi07XXqkki2o6mVL0VRzNGfabjco3FOSV8Jqz3ovw=="
        }

        add_user { victord:
                name    => "Victor Djurlyak",
                uid      => "1079",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'victord', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQDX1pEmXrNaJZ4d2DMi6Up/4vc56f2Z+P9Vk7UNTBVRktUhPnMNtz4ch22WhYrdjDGMzWA3cxg6vaMe8fDSZAZhSENOW6fV0Ob+2Ba93BQOYtOAM9lqiMfpIVwcBQnfEwEpGRGXUNWSb9bxm47Xc3+WfLwgOnt2g5Nlbf7XxqaCImgc0y8Rm0b7+dZkNZsufp0+T4oH4cCIWDzzI8nUF+aT1tEGs3Brz4+Ee+LSET/1zlsv2xObiiN/NF9L39IzGj8mf6rEDXXwo47vzK06WE+NRXE2k7nbHGb1xTx0pBEBgqdYTx7tRRDjA2XkehaKuJbUVtjCr3eTqUlGhq/ZoygF"
        }

        add_user { vitaly:
                name    => "Vitaly Svyatyuk",
                uid      => "1080",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'vitaly', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAABIwAAAQEAurq6dIRBBUacC9vQqVo3NWXNHnfMI2RMc78X5mmSUHbeim6Ycip2gYLHKuBcZv4F52AacfBAKQ4J1NERSnCCasU/Hg9W06t9f1gaADTgJw0GWCXHOb6HPpzpyg9/I0c7hXVhKKfW8+ZXRiPrisKjagi2JnrO9H8N/hlaxObsy9l4mqC5n0utQ1Hn46BmEElqlWnLn+jkZQqst3QuF5PmUsqIVuKtDhwEr7IGBniWBTBiDvBD7T3H4r5ShyUpY00L0Tl7fKpM+nQkV0z6bahz9sqIPMQLnmKf5r/dFQBLzvwcWGsXhnmL3whk9YhkV4btIOh8FrhpPfPH5JoS41skMw=="
        }

        add_user { aleksey:
                name    => "Aleksey Lozovsky",
                uid      => "1081",
                password => '$6$APftEeGY$r0U5muzZ9o1ULWzSHSyuuSCOTWVzYo9ioQ/y7dJBRzdxts95k3ubRG7Im4gQUwEPQh1J/U32Y/Hn9o8kcLzaw0',
                shell => "/bin/bash",
                groups => ['sudo', 'aleksey', 'sysadmin'],
                sshkeytype => "ssh-rsa",
                sshkey => "AAAAB3NzaC1yc2EAAAADAQABAAABAQCxBF2lsjEjzEJYVgQlEeKM8slMN02puJhd9++5lytpAEuZ4tm1DqngSXHQIkQzfK+mdYrZLzcw0rn01z0kFF2iqu2Ki84adv/zWcrxpmJ01T9vYTNBJ3VCbP4X6jXG7V7p1Q9VgtZGJcxzI9lJ+oC1BhzslkUSz6PvpzWfNysCEjMolmKwTAQHTULjSXa1z3lDlR9DStst0/QgZdjTl8jYjf/cS4PXnPY9pK9RgGaBEyO5DIKjqQ9CyYH2pU6dpFQaqoifNOSgdTKzf9t8xv5yUvHJWLgJHSxsuu+aQZr1fB1sm3dunoisdkV8IlOxJ7iaNMhNeg5UKNtjcsMfiWQR"
        }
}

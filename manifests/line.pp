#set_hostname_ec2::line, helper resource to check a line exists in a file.
define set_hostname_ec2::line($file, $line, $ensure = 'present') {
  case $ensure {
    default : { err ( "unknown ensure value ${ensure}" ) }
    present: {
      exec { "/bin/echo '${line}' >> '${file}'":
        unless => "/bin/grep -qFx '${line}' '${file}'"
      }
    }
    absent: {
      exec { "/usr/bin/perl -ni -e 'print unless /^\\Q${line}\\E\$/' '${file}'":
        onlyif => "/bin/grep -qFx '${line}' '${file}'"
      }
    }
  }
}

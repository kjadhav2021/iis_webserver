# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include iis_webserver
class iis_webserver {
  $webfeatures = ['Web-Server','Web-WebServer','Web-Mgmt-Console','Web-Mgmt-Tools']
  windowsfeature { $webfeatures:
    ensure => 'present',
  }
  $iis_features = ['Web-WebServer','Web-Scripting-Tools']
  iis_feature { $iis_features:
    ensure => 'present',
  }
  # Delete the default website to prevent a port binding conflict.
  iis_site { 'Default Web Site':
    ensure  => absent,
    require => Iis_feature['Web-WebServer'],
  }
}

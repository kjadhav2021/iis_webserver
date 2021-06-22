# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include iis_webserver::iis_site
class iis_webserver::iis_site {
    file { 'basic':
      ensure => 'directory',
      path   => 'c:/inetpub/basic',
    }

    archive { 'index.zip':
      path         => 'C:/inetpub/basic/index.zip',
      source       => 'https://gist.github.com/dylanratcliffe/af0e24303d241b888152bd1cd7c9063d/archive/ad273bebc01c6dac176da7a5f3c38c4d9a584521.zip',
      extract      => true,
      extract_path => 'C:/inetpub/basic',
      creates      => 'C:/inetpub/basic', #directory inside tgz
      cleanup      => true,
      require      => File['basic'],
    }

    # archive { $filename:
    #   path          => "/tmp/${filename}",
    #   source        => "http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.0.M3/bin/apache-tomcat-9.0.0.M3.zip",
    #   checksum      => 'f2aaf16f5e421b97513c502c03c117fab6569076',
    #   checksum_type => 'sha1',
    #   extract       => true,
    #   extract_path  => '/opt',
    #   creates       => $install_path,
    #   cleanup       => 'true',
    #   require       => File[$install_path],
    # }

    iis_site { 'basic-site':
      ensure          => 'started',
      physicalpath    => 'c:/inetpub/basic',
      applicationpool => 'basic_site_app_pool',
      require         => File['basic'],
    }
}

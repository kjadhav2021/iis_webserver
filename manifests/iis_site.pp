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
      # extract_path => 'C:/inetpub/wwwroot/',
      extract_path => 'C:/inetpub/basic', #directory inside tgz
      cleanup      => false,
      require      => File['basic'],
    }
    iis_site { 'basic-site':
      ensure          => 'started',
      physicalpath    => 'c:/inetpub/basic',
      applicationpool => 'basic_site_app_pool',
      require         => File['basic'],
    }
}

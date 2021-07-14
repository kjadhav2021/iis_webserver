# @summary
# This class sllows creation of a new IIS Web Site and configuration of site parameters.
#
# @example
#   include iis_webserver::iis_site
#
# @param site_title
#   This is a site title. It ensures as a string value such as 'basic'
# @param site_directory
#   It is physical path to the site directory. This path must be fully qualified.
# @param tmp_directory
#   It is physical path to the temp directory for archive extraction. This path must be fully qualified
# @param archive_title
#   This is a archive title. It ensures as a string value such as 'index.zip'
# @param archive_src
#   It is archive file source.supports http|https|ftp|file|s3|gs uri.
# @param file_title
#   It is an index file title.
# @param index_file_src
#   It is physical path to the index.file after archive extraction in temp directory
# @param site_app_pool
#   This is application pool name.
class iis_webserver::iis_site (
  String $site_title     = 'basic',
  String $site_directory = 'C:\\inetpub\\basic',
  String $tmp_directory  = 'C:\\tmppackage',
  String $archive_title  = 'index.zip',
  String $archive_src    = 'https://gist.github.com/dylanratcliffe/af0e24303d241b888152bd1cd7c9063d/archive/ad273bebc01c6dac176da7a5f3c38c4d9a584521.zip',
  String $file_title     = 'index.html',
  String $index_file_src = 'C:\\tmppackage\\af0e24303d241b888152bd1cd7c9063d-ad273bebc01c6dac176da7a5f3c38c4d9a584521\\index.html',
  String $site_app_pool  = 'basic_site_app_pool',
){
  file { $site_title:
    ensure => 'directory',
    path   => $site_directory,
    before => File[$tmp_directory],
  }
  file { $tmp_directory:
    ensure => 'directory',
    path   => $tmp_directory,
    before => Archive[$archive_title],
  }
  archive { $archive_title:
    path         => "${tmp_directory}\\${archive_title}",
    source       => $archive_src,
    extract      => true,
    extract_path => $tmp_directory, #directory inside tgz
    cleanup      => true,
  }
  file { $file_title:
    ensure  => 'file',
    path    => "${site_directory}\\${file_title}",
    source  => $index_file_src,
    require => Archive[$archive_title],
  }
  iis_site { 'basic-site':
    ensure          => 'started',
    physicalpath    => $site_directory,
    applicationpool => $site_app_pool,
    require         => File[$site_title],
    subscribe       => File[$file_title],
  }
}

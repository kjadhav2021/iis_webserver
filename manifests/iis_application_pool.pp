# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include iis_webserver::iis_application_pool
class iis_webserver::iis_application_pool (
  String $site_title              = 'basic_site_app_pool',
  String $managed_pipeline_mode   = 'Integrated',
  String $managed_runtime_version = 'v4.0',
) {
  iis_application_pool { $site_title:
    ensure                  => 'present',
    state                   => 'started',
    managed_pipeline_mode   => $managed_pipeline_mode,
    managed_runtime_version => $managed_runtime_version,
  }
}

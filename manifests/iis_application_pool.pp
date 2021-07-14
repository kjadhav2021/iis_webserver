# @summary
# This is iis_application_pool class for the module iis_webserver
#
# It is special wrapper class with parameters app pool title, pipeline mode and .net runtime version
#
# @example
#   include iis_webserver::iis_application_pool
#
# @param app_pool_title
#   This is application pool name for the iis webserver. It ensures as a string value such as 'basic_site_app_pool'
# @param managed_pipeline_mode
#   It Specifies the request-processing mode that is used to process requests for managed content.
#   It ensures as a string value such as 'Integrated'.
# @param managed_runtime_version
#   It Specifies the .NET Framework version to be used by the application pool.

class iis_webserver::iis_application_pool (
  String $app_pool_title          = 'basic_site_app_pool',
  String $managed_pipeline_mode   = 'Integrated',
  String $managed_runtime_version = 'v4.0',
) {
  iis_application_pool { $app_pool_title:
    ensure                  => 'present',
    state                   => 'started',
    managed_pipeline_mode   => $managed_pipeline_mode,
    managed_runtime_version => $managed_runtime_version,
  }
}

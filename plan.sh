pkg_name=cortWebapp-http
pkg_origin=lfillmore
pkg_version() {
  cat "/src/version.txt"
}
 
do_before() {
  do_default_before
  update_pkg_version
}
pkg_maintainer="CORT DevOps <dlsysops@cort.com>"
pkg_description="The configures httpd for the static files for cort.com"
#pkg_upstream_url="http://cort.com"
pkg_license=("Apache-2.0")
pkg_deps=(core/httpd core/node core/coreutils)
pkg_svc_user="root"
pkg_svc_group="root"
pkg_svc_run="httpd -DFOREGROUND -f $pkg_svc_config_path/httpd.conf"
pkg_exports=(
  [host]=srv.host
  [port]=srv.port
  [app-port]=app.port
 )

 do_download() {
  return 0
}
do_prepare(){
  cd /src/
  npm install
  fix_interpreter "/src/node_modules/.bin/*" core/coreutils bin/env 
  npm run build:ssr
}
 do_build() {
  return 0
}

do_install() {
  #  mkdir -p "${pkg_prefix}/data"
  #  mkdir -p "${pkg_prefix}/htdocs"
  #  mv ${HAB_CACHE_SRC_PATH}/cortWebApp "${pkg_prefix}/data/"
    cp -R /src/dist ${pkg_prefix}/
}

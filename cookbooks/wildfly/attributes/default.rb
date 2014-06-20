#
# Cookbook Name:: wildfly
# Attributes:: default
#
# Author:: Reltask Inc<reltask@gmail.com>

default[:wildfly][:version] = "wildfly-8.0.0.Final"
default[:wildfly][:zip_url] = "http://download.jboss.org/wildfly/8.0.0.Final/wildfly-8.0.0.Final.zip"

default[:wildfly][:install_path] = "/opt/"
default[:wildfly][:home] = "/opt/wildfly"
default[:wildfly][:user] = "root"
default[:wildfly][:group] = "root"
default[:wildfly][:adminuser] = "wildfly"
default[:wildfly][:adminuserpwd] = "wildfly"

default[:wildfly][:jdbcjar] = "postgresql-9.3-1101.jdbc41.jar"
##default[:wildfly][:jdbcjar_source] = "http://jdbc.postgresql.org/download/postgresql-9.3-1101.jdbc41.jar"
default[:wildfly][:jndi_id] = "jdbc/wildfly"
default[:wildfly][:jdbc_driver] = "org.postgresql.Driver"
default[:wildfly][:jdbc_url] = "jdbc:postgresql://192.168.33.12:5432/wildfly"
default[:wildfly][:jndi_username] = "wildfly"
default[:wildfly][:jndi_password] = "flyfastflyfree"
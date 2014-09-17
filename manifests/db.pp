# == Class: mongodb::db
#
# Class for creating mongodb databases and users.
#
# == Parameters
#
#  user - Database username.
#  password - Plain text user password. 
#  roles (default: ['dbAdmin']) - array with user roles.
#  tries (default: 10) - The maximum amount of two second tries to wait MongoDB startup.
#
define mongodb::db (
  $user,
  $password      = false,
  $roles         = ['dbAdmin'],
  $tries         = 10,
) {

  mongodb_database { $name:
    ensure   => present,
    tries    => $tries,
    require  => Class['mongodb::server'],
  }

  if $password == false {
    fail("Parameter 'password' should be provided to mongodb::db.")
  }

  mongodb_user { $user:
    ensure   => present,
    password => $password,
    database => $name,
    roles    => $roles,
    require  => Mongodb_database[$name],
  }

}

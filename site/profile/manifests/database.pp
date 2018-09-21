class profile::database (
  Hash              $dbs,
  Sensitive[String] $mysql_password,
) {

  class { '::mysql::server':
    root_password           => $mysql_password,
    remove_default_accounts => true,
  }

  $dbs.each |String $db_name, Hash $db_data| {
    mysql::db { $db_name:
      user     => "${db_name}-user",
      password => Sensitive.new($db_data['password']),
      *        => delete($db_data,'password'),
    }
  }
}

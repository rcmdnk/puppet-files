class files::directories(
  $directories = {}){

  $directories |String $name, Hash $opts| {
    $path = $opts["path"]
    $source = $opts["source"]
    if has_key($opts, "owner") {
      $owner = $opts["owner"]
    }else{
      $owner = "root"
    }
    if has_key($opts, "group") {
      $group = $opts["group"]
    }else{
      $group = "root"
    }
    if has_key($opts, "mode") {
      $mode = $opts["mode"]
    }else{
      $mode = "0644"
    }
    file {$name:
      ensure => directory,
      path => $path,
      owner => $owner,
      group => $group,
      mode => $mode,
    }
  }
}

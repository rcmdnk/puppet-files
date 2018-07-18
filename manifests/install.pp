class files::install(
  $files = {}){

  $files.each |String $file, Hash $opts| {
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
    file {$file:
      path => $path,
      source => $source,
      owner => $owner,
      group => $group,
      mode => $mode,
    }
    if has_key($opts, "exec") and $opts["exec"] {
      $command = $path
      if has_key($opts, "args") {
        $command = $path + $opts["args"]
      }
      exec {"${file} exec":
        command => $command
      }
    }
  }
}

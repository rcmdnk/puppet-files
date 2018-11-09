class files::files(
  $files = {}){

  $files.each |String $name, Hash $opts| {
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
    if has_key($opts, "cwd") {
      $cwd = $opts["cwd"]
    }else{
      $cwd = "/root"
    }
    if has_key($opts, "recurse") {
      $recurse = $opts["recurse"]
    }else{
      $recurse = "false"
    }
    file {$name:
      path => $path,
      source => $source,
      owner => $owner,
      group => $group,
      mode => $mode,
      recurse => $recurse,
    }
    if has_key($opts, "exec") and $opts["exec"] {
      $command = $path
      if has_key($opts, "args") {
        $command = $path + $opts["args"]
      }
      exec {"${name} exec":
        command => $command,
        cwd => $cwd
      }
    }
  }
}

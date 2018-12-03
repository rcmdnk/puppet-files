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
    if has_key($opts, "exec_user") {
      $exec_user = $opts["exec_user"]
    }else{
      $exec_user = "root"
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
      $recurse = false
    }
    if $recurse {
      $directory = dirname($path)
      exec {"${name}_mkdir":
        command => "/bin/mkdir -p ${directory}",
      }
      if has_key($opts, "owner") {
        exec {"${name}_owner":
          command => "/bin/chown ${opts["owner"]} ${directory}",
        }
      }
      if has_key($opts, "group") {
        exec {"${name}_group":
          command => "/bin/chgrp ${opts["group"]} ${directory}",
        }
      }
    }
    file {$name:
      path => $path,
      source => $source,
      owner => $owner,
      group => $group,
      mode => $mode,
    }
    if has_key($opts, "exec") and $opts["exec"] {
      $command = "sudo -u ${exec_user} ${path}"
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

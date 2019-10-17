class files::files(
  $files = {}){

  $files.each |String $name, Hash $opts| {
    if has_key($opts, "recurse") and $opts["recurse"] {
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

    $settings = $opts.filter |$key, $val| {
      $key != "exec" and $key != "exec_user" and $key != "cwd" and $key != "args"
    }
    file {$name:
      * =>  $settings
    }

    if has_key($opts, "exec") and $opts["exec"] {
      if has_key($opts, "exec_user") {
        $exec_user = $opts["exec_user"]
      }else{
        $exec_user = "root"
      }
      if has_key($opts, "cwd") {
        $cwd = $opts["cwd"]
      }else{
        $cwd = "/root"
      }
      if has_key($opts, "args") {
        $command = "/usr/bin/sudo -u ${exec_user} ${opts["path"]} ${opts['args']}"
      }else{
        $command = "/usr/bin/sudo -u ${exec_user} ${opts["path"]}"
      }
      exec {"${name} exec":
        command => $command,
        cwd => $cwd
      }
    }
  }
}

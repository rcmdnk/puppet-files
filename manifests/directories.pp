class files::directories(
  $directories = {}){

  $directories.each |String $name, Hash $opts| {
    $path = $opts["path"]
    $source = $opts["source"]
    exec {"${name}_mkdir":
      command => "/bin/mkdir -p ${path}",
    }
    if has_key($opts, "owner") {
      exec {"${name}_owner":
        command => "/bin/chown ${opts["owner"]} ${path}",
      }
    }
    if has_key($opts, "group") {
      exec {"${name}_group":
        command => "/bin/chgrp ${opts["group"]} ${path}",
      }
    }
    if has_key($opts, "mode") {
      exec {"${name}_mode":
        command => "/bin/chmod ${opts["mode"]} ${path}",
      }
    }
  }
}

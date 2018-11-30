class files::files(
  $links = {}){

  $links.each |String $name, Hash $opts| {
    $path = $opts["path"]
    $target = $opts["target"]
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
      ensure => "link",
      path => $path,
      target => $target,
      owner => $owner,
      group => $group,
    }
  }
}

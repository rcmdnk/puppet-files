class files::install(
  $files = {}){

  $files.each |file, opts| {
    path = opts["path"]
    source = opts["source"]
    owner = opts.has_key?("owner") ? opts["owner"] : "root"
    group = opts.has_key?("group") ? opts["group"] : "root"
    mode = opts.has_key?("mode") ? opts["mode"] : "0644"
    file {file:
      path => path,
      source => source,
      owner => owner,
      group => group,
      mode => mode,
    }
    if opts.has_key?("exec") and opts["exec"] {
      command = path
      if opts.has_key?("args") {
        command = path + opts["args"]
      }
      exec {file:
        command => command
      }
    }
  }
  files {$packages:
    ensure => installed,
  }
}

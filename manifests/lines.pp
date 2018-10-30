class files::lines(
  $lines = {}){

  $lines.each |String $name, Hash $opts| {
    $path = $opts["path"]
    $line = $opts["line"]
    $match = $opts["match"]
    if has_key($opts, "append_on_no_match") {
      $append_on_no_match = $opts["append_on_no_match"]
    }else{
      $append_on_no_match = false
    }
    file_line {$name:
      path => $path,
      line => $line,
      match => $match,
      append_on_no_match => $append_on_no_match,
    }
  }
}

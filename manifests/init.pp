class files(
  $files = {},
  $lines = {},
  ){
  class { 'files::files':
    files => $files,
  }
  class { 'files::lines':
    lines => $lines,
  }
}

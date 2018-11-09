class files(
  $directories = {},
  $files = {},
  $lines = {},
  ){
  class { 'files::directories':
    directories => $directories,
  }
  class { 'files::files':
    files => $files,
  }
  class { 'files::lines':
    lines => $lines,
  }
}

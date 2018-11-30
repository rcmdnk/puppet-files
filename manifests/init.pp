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
  class { 'files::links':
    links => $links,
  }
  class { 'files::lines':
    lines => $lines,
  }
}

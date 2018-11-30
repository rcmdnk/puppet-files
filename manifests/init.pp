class files(
  $directories = {},
  $files = {},
  $links = {},
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

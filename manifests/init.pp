class files(
  $directories = {},
  $directories_add = {},
  $files = {},
  $files_add = {},
  $links = {},
  $links_add = {},
  $lines = {},
  $lines_add = {},
  ){
  $directories_all = deep_merge($directories, $directories_add)
  class { 'files::directories':
    directories => $directories_all,
  }
  $files_all = deep_merge($files, $files_add)
  class { 'files::files':
    files => $files_all,
  }
  $links_all = deep_merge($links, $links_add)
  class { 'files::links':
    links => $links_all,
  }
  $lines_all = deep_merge($lines, $lines_add)
  class { 'files::lines':
    lines => $lines_all,
  }
}

class files_exec(
  $files = {}){
  class { 'files_exec::install':
    files => $files,
  }
}

class files(
  $files = {}){
  class { 'files::install':
    files => $files,
  }
}

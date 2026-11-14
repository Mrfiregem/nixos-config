# Rename files using their md5sum as the filename.
#
# If a path to a directory is given: if the `--recursive`
# flag is also present, all files in the directory are renamed,
# otherwise, an error will occur and the program will exit.
def main [
  --no-confirm(-y) # Skip the confirmation prompt.
  --recursive(-r)  # Change the files inside directories, too.
  ...paths: path    # The file(s) to rename.
]: nothing -> nothing {
  if ($paths | is-empty) {
    print -e 'No files were provided.'
    exit 1
  }

  # Generate the list of files to rename.
  mut files = []
  for path in $paths {
    let file: string = $path | path expand
    match ($file | path type) {
      'file' => { $files = $files | append [$file] }
      'dir' => {
        if not $recursive {
          print -e $'($file) is a directory but `-r` was not given. Exiting.'
          exit 1
        }
        $files = $files | append (ls $file | where type == 'file' | get name)
      }
      _ => {
        print -e 'An error gathering files occured. Exiting.'
        exit 2
      }
    }
  }

  # Show list of files to user and ask for confirmation.
  let continue = if not $no_confirm {
    $files | let x # Required since mutables cant be used in closure below.
    | each {|p| try { path relative-to . } catch { $p } }
    | try { grid -s '  ' } catch { $x | to text }
    | print

    try { input -n 1 'Rename these files? [y/N]: ' } | default -e 'n' | $in starts-with y
  } else { true }

  if not $continue {
    print -e 'Operation canceled. Exiting.'
    exit 1
  }

  $files
  | wrap old
  | insert new {|p|
    $p.old
    | path parse
    | update stem {
      open --raw $p.old | hash md5
    }
    | path join
  }
  | each {|p|
    if $p.old != $p.new {
      mv $p.old $p.new
    }
  }
  | format pattern 'renamed {old} -> {new}'
  | to text
  | print
}

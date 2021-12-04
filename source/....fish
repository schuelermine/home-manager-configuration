set -q argv[1] || set argv[1] 2
set dest $PWD
for i in (seq $argv[1])
  set dest (dirname $dest)
end
isatty stdout && cd $dest || echo $dest

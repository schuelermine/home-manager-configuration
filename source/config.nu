let-env PROMPT_INDICATOR = "$ "

def random-choice [] {
  let $xs = $in;
  let $len = ($xs | length);
  $xs | select (random integer 0..($len - 1))
}

def column-exists? [name] { $name in ($in | columns) }

def-env cd-v [$cmd] { cd (dirname (realpath (which $cmd).path)) }

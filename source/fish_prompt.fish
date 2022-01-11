set s $status
echo -s (test "$s" != 0 && set_color brred || set_color white) $s (set_color brblack) " " (fish_prompt_pwd_dir_length=0 prompt_pwd) " " \$ (set_color normal) " "

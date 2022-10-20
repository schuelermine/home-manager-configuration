set -l last_pipestatus $pipestatus
set -lx __fish_last_status $status # Export for __fish_print_pipestatus.
set -l normal (set_color normal)
set -q fish_color_status
or set -g fish_color_status --background=red white

# Color the prompt differently when we're root
set -l color_cwd $fish_color_cwd
set -l suffix '$'
if functions -q fish_is_root_user; and fish_is_root_user
    if set -q fish_color_cwd_root
        set color_cwd $fish_color_cwd_root
    end
    set suffix '#'
end

# Write pipestatus
# If the status was carried over (e.g. after `set`), don't bold it.
set -l bold_flag --bold
set -q __fish_prompt_status_generation; or set -g __fish_prompt_status_generation $status_generation
if test $__fish_prompt_status_generation = $status_generation
    set bold_flag
end
set __fish_prompt_status_generation $status_generation
set -l status_color (set_color $fish_color_status)
set -l statusb_color (set_color $bold_flag $fish_color_status)
set -l prompt_status (__fish_print_pipestatus "[" "]" "|" "$status_color" "$statusb_color" $last_pipestatus)

function _prompt_with_pwd
        string join "" (set_color $color_cwd) $argv[1] $normal (fish_vcs_prompt) $normal " " $prompt_status $suffix " "
end

set long_prompt (_prompt_with_pwd (prompt_pwd --dir-length=0))
set short_prompt (_prompt_with_pwd (prompt_pwd))

if test (string length --visible $long_prompt) -gt (math $COLUMNS / 2)
    echo -n $long_prompt
else
    echo -n $short_prompt
end
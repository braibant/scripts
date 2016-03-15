function fish_prompt

	set -g __fish_git_prompt_show_informative_status 1
	# set -g __fish_git_prompt_hide_untrackedfiles 1
	set -g __fish_git_prompt_showupstream "informative"
 	set -g __fish_git_prompt_char_upstream_ahead "↑"
	set -g __fish_git_prompt_char_upstream_behind "↓"
	set -g __fish_git_prompt_char_upstream_prefix ""
	set -g __fish_git_prompt_char_stagedstate "●"
	set -g __fish_git_prompt_char_dirtystate "✚"
	set -g __fish_git_prompt_char_untrackedfiles "…"
	set -g __fish_git_prompt_char_conflictedstate "✖"
	set -g __fish_git_prompt_char_cleanstate "✔"
  set -g __fish_git_prompt_color_branch yellow
  set -g __fish_git_prompt_color_flags magenta --bold
	set -g __fish_git_prompt_color_upstream blue --bold

  function _git_branch_name
    echo (git symbolic-ref HEAD ^/dev/null | sed -e 's|^refs/heads/||')
  end

  function _is_git_dirty
    echo (git status -s --ignore-submodules=dirty ^/dev/null)
  end

  function _is_git_repo
    git status -s >/dev/null ^/dev/null
  end

  function _hg_branch_name
      echo (hg branch ^/dev/null)
  end

  function _is_hg_dirty
    echo (hg status -mard ^/dev/null)
  end

  function _is_hg_repo
    hg summary >/dev/null ^/dev/null
  end

  function _repo_branch_name
    eval "_$argv[1]_branch_name"
  end

  function _is_repo_dirty
    eval "_is_$argv[1]_dirty"
  end

  function _repo_type
    if _is_hg_repo
      echo '(hg)'
    else if _is_git_repo
      echo '(git)'
    end
  end

  function rule_fill
	  # set -l _hr (printf "%*s" (tput cols))
	  set -l _hr (printf "%*s" $argv[1])
		printf $_hr | sed -e "s/ /━/g"
  end


  # function rulem
	#   set -l _hr (printf "%*s" (tput cols))
	#   if test -z $argv[1]
	# 	  echo "Usage: rulem MESSAGE [RULE_CHARACTER]"
	# 	  return
	#   else
	# 	  if test (count $argv) -eq 2
	# 		  printf "$_hrr33[2C$argv[1]" | sed -e s/ /\$argv[2]/g
	# 	  else
	# 		  printf "$_hrr33[2C$argv[1]" | sed -e s/ /\-/g
	# 	  end
	#   end
  # end


  set -l cyan (set_color -o cyan)
  set -l yellow (set_color -o yellow)
  set -l red (set_color -o red)
  set -l blue (set_color -o blue)
  set -l normal (set_color normal)
  set -l def (set_color -o blue)

  set -l arrow "$red➜ "
  if [ $USER = 'root' ]
    set arrow "$red# "
  end

  set -l now (date "+%H:%M:%S")
  set -l host (hostname)
  set -l pwd (prompt_pwd)

  set -l content "━━($now)━━($host)━━($pwd)━━"
  set -l filler (rule_fill (math 15 + (tput cols) - (expr length $content)))
  set -l bar "$def━━($yellow$now$def)━━($yellow$host$def)━$filler━($yellow$pwd$def)━━"
  echo $bar
  # set -l cwd $cyan(prompt_pwd)

  echo -n -s (_repo_type) (__fish_git_prompt) (__fish_hg_prompt) $normal ' ' $arrow
end

if exists('g:loaded_yadm_handler') || &shell == 'cmd.exe' || &shell == 'command.com'
  finish
endif
let g:loaded_yadm_handler = 1

function! s:EnableYadm()
  let l:cd_to_parent = 'cd ' . shellescape(resolve(expand('%:p:h'))) . ' && '
  silent let l:in_git_repo = trim(system(l:cd_to_parent . 'git rev-parse --is-inside-work-tree'))
  if l:in_git_repo ==# 'true'
    return
  endif

  silent let l:in_yadm_repo = trim(system(l:cd_to_parent . 'yadm rev-parse --is-inside-work-tree'))
  if l:in_yadm_repo ==# 'false'
    return
  endif

  let l:real_path = resolve(expand('%:p'))
  silent let l:is_managed = system('yadm ls-files ' . shellescape(l:real_path))
  if empty(l:is_managed)
    return
  endif

  silent let l:git_dir = system('yadm enter printf %s ' . shellescape('$GIT_DIR'))
  silent let l:git_work_tree = system('yadm enter printf %s ' . shellescape('$GIT_WORK_TREE'))

  if !empty(l:git_dir)
    let b:yadm_old_git_dir = getenv('GIT_DIR')
    call setenv('GIT_DIR', l:git_dir)
  endif

  if !empty(l:git_work_tree)
    let b:yadm_old_git_work_tree = getenv('GIT_WORK_TREE')
    call setenv('GIT_WORK_TREE', l:git_work_tree)
  endif
endfunction

function! s:DisableYadm()
  if exists('b:yadm_old_git_dir')
    call setenv('GIT_DIR', b:yadm_old_git_dir)
    unlet b:yadm_old_git_dir
  endif

  if exists('b:yadm_old_git_work_tree')
    call setenv('GIT_WORK_TREE', b:yadm_old_git_work_tree)
    unlet b:yadm_old_git_work_tree
  endif
endfunction

augroup YadmHandler
  autocmd!

  autocmd BufEnter * call s:EnableYadm()
  autocmd BufLeave * call s:DisableYadm()
augroup END

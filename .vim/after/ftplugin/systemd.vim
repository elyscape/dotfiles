if !has('unix')
  finish
endif

if expand('%:t') =~# '^\.#override'
  setlocal noundofile
endif

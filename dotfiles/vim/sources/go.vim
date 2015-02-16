" using goimports for formatting (depends on vim-go plugin)
let g:go_fmt_command = "goimports"
auto BufWritePre *.go Fmt

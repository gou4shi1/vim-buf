" Description: run buf check lint

function! ale_linters#proto#buf_check_lint#GetProjectRoot(buffer) abort
    let l:config_path = ale#path#FindNearestFile(a:buffer, 'buf.yaml')
    if (!empty(l:config_path))
        return fnamemodify(l:config_path, ':h')
    endif
    let l:git_path = ale#path#FindNearestDirectory(a:buffer, '.git')
    return !empty(l:git_path) ? fnamemodify(l:git_path, ':h:h') : ''
endfunction

function! ale_linters#proto#buf_check_lint#GetCommand(buffer) abort
  return 'cd ' . ale_linters#proto#buf_check_lint#GetProjectRoot(a:buffer) . ' && buf check lint --file %s'
endfunction

call ale#linter#Define('proto', {
    \   'name': 'buf-check-lint',
    \   'lint_file': 1,
    \   'output_stream': 'stdout',
    \   'executable': 'buf',
    \   'command': function('ale_linters#proto#buf_check_lint#GetCommand'),
    \   'callback': 'ale#handlers#unix#HandleAsError',
    \})

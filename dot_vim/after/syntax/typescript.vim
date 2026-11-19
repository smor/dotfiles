" Fix a hang in Vim's bundled TypeScript syntax (yats, Apple Vim 9.1).
" Its arrow-function rules use (\_[^()]\+\|...)* - a repeat inside a repeat,
" matching across lines - which backtracks exponentially on code like
"   await f(
"     (url) => url.hostname === 'a',
" freezing Vim and dropping highlighting. Same rules, minus the inner \+.
syntax clear typescriptArrowFuncDef
syntax match   typescriptArrowFuncDef          contained /\K\k*\s*=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty
syntax match   typescriptArrowFuncDef          contained /(\%(\_[^()]\|(\_[^()]*)\)*)\_s*=>/
  \ contains=typescriptArrowFuncArg,typescriptArrowFunc,@typescriptCallSignature
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty
syntax region  typescriptArrowFuncDef          contained start=/(\%(\_[^()]\|(\_[^()]*)\)*):/ matchgroup=typescriptArrowFunc end=/=>/
  \ contains=typescriptArrowFuncArg,typescriptTypeAnnotation,@typescriptCallSignature
  \ nextgroup=@typescriptExpression,typescriptBlock
  \ skipwhite skipempty keepend

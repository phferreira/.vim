"----------------------------------------------------------------------------------------------------
" FUNCTIONS

" Plugin to copy matches (search hits which may be multiline).
" Version 2012-05-03 from http://vim.wikia.com/wiki/VimTip478

" :CopyMatches      copy matches to clipboard (each match has newline added)
" :CopyMatches x    copy matches to register x
" :CopyMatches X    append matches to register x
" :CopyMatches -    display matches in a scratch buffer (does not copy)
" :CopyMatches pat  (after any of above options) use 'pat' as search pattern
" :CopyMatches!     (with any of above options) insert line numbers
" Same options work with the :CopyLines command (which copies whole lines).

" Jump to first scratch window visible in current tab, or create it.
" This is useful to accumulate results from successive operations.
" Global function that can be called from other scripts.
function! GoScratch()
  let done = 0
  for i in range(1, winnr('$'))
    execute i . 'wincmd w'
    if &buftype == 'nofile'
      let done = 1
      break
    endif
  endfor
  if !done
    new
    setlocal buftype=nofile bufhidden=hide noswapfile
  endif
endfunction

" Append match, with line number as prefix if wanted.
function! s:Matcher(hits, match, linenums, subline)
  if !empty(a:match)
    let prefix = a:linenums ? printf('%3d  ', a:subline) : ''
    call add(a:hits, prefix . a:match)
  endif
  return a:match
endfunction

" Append line numbers for lines in match to given list.
function! s:MatchLineNums(numlist, match)
  let newlinecount = len(substitute(a:match, '\n\@!.', '', 'g'))
  if a:match =~ "\n$"
    let newlinecount -= 1  " do not copy next line after newline
  endif
  call extend(a:numlist, range(line('.'), line('.') + newlinecount))
  return a:match
endfunction

" Return list of matches for given pattern in given range.
" If 'wholelines' is 1, whole lines containing a match are returned.
" This works with multiline matches.
" Work on a copy of buffer so unforeseen problems don't change it.
" Global function that can be called from other scripts.
function! GetMatches(line1, line2, pattern, wholelines, linenums)
  let savelz = &lazyredraw
  set lazyredraw
  let lines = getline(1, line('$'))
  new
  setlocal buftype=nofile bufhidden=delete noswapfile
  silent put =lines
  1d
  let hits = []
  let sub = a:line1 . ',' . a:line2 . 's/' . escape(a:pattern, '/')
  if a:wholelines
    let numlist = []  " numbers of lines containing a match
    let rep = '/\=s:MatchLineNums(numlist, submatch(0))/e'
  else
    let rep = '/\=s:Matcher(hits, submatch(0), a:linenums, line("."))/e'
  endif
  silent execute sub . rep . (&gdefault ? '' : 'g')
  close
  if a:wholelines
    let last = 0  " number of last copied line, to skip duplicates
    for lnum in numlist
      if lnum > last
        let last = lnum
        let prefix = a:linenums ? printf('%3d  ', lnum) : ''
        call add(hits, prefix . getline(lnum))
      endif
    endfor
  endif
  let &lazyredraw = savelz
  return hits
endfunction

" Copy search matches to a register or a scratch buffer.
" If 'wholelines' is 1, whole lines containing a match are returned.
" Works with multiline matches. Works with a range (default is whole file).
" Search pattern is given in argument, or is the last-used search pattern.
function! s:CopyMatches(bang, line1, line2, args, wholelines)
  let l = matchlist(a:args, '^\%(\([a-zA-Z"*+-]\)\%($\|\s\+\)\)\?\(.*\)')
  let reg = empty(l[1]) ? '+' : l[1]
  let pattern = empty(l[2]) ? @/ : l[2]
  let hits = GetMatches(a:line1, a:line2, pattern, a:wholelines, a:bang)
  let msg = 'No non-empty matches'
  if !empty(hits)
    if reg == '-'
      call GoScratch()
      normal! G0m'
      silent put =hits
      " Jump to first line of hits and scroll to middle.
      ''+1normal! zz
    else
      execute 'let @' . reg . ' = join(hits, "\n") . "\n"'
    endif
    let msg = 'Number of matches: ' . len(hits)
  endif
  redraw  " so message is seen
  echo msg
endfunction
command! -bang -nargs=? -range=% CopyMatches call s:CopyMatches(<bang>0, <line1>, <line2>, <q-args>, 0)
command! -bang -nargs=? -range=% CopyLines call s:CopyMatches(<bang>0, <line1>, <line2>, <q-args>, 1)

"----------------------------------------------------------------------------------------------------
" XML

function! DoPrettyXML()
  execute 'set ft=xml'
  execute ':0'
  execute ':%s/></>\r</g'
  execute ':0'
  execute ':normal gg=G'
endfunction
command! PrettyXML call DoPrettyXML()

"----------------------------------------------------------------------------------------------------
" FLUTTER

function! FlutterRun()
  let flutterRun = 'FlutterRun '  
  
  if filereadable('./keys.json') 
    execute flutterRun . ' --dart-define-from-file=./keys.json'
  else
    execute flutterRun
  endif
endfunction

function! FlutterAnalyze()
  let file = '__Flutter_Analyze__'

  if (buflisted(file) == 0)
    execute ':new ' . file
  else
    execute 'buffer ' . file
    execute ':%d'
  endif

  execute ':r!flutter analyze'
  setlocal buftype=nofile
  setlocal bufhidden=hide
endfunction

function! FlutterTestAll()
  let file = '__Flutter_Test_All__'

  if (buflisted(file) == 0)
    execute ':new ' . file
  else
    execute 'buffer ' . file
    execute ':%d'
  endif

  execute ':r!flutter test -j 10 --reporter expanded '
  setlocal buftype=nofile
  setlocal bufhidden=hide
endfunction

function! FlutterTest()
  let path = expand('%:p')
  let file = '__Flutter_Test_' . expand('%:t') . '__'
  let flutterTest = ':r!flutter test -j 10 --reporter expanded '  

  if (buflisted(file) == 0)
    execute ':new ' . file
  else
    execute 'buffer ' . file
    execute ':%d'
  endif

  execute flutterTest . path
  setlocal buftype=nofile
  setlocal bufhidden=hide
endfunction

function! FlutterCreateTest()
  let filePath = expand('%:r')
  let file = substitute(filePath, 'lib/', 'test/', '') . '_test.dart'

  if !filereadable(file) 
    execute ':new ' . file 
    call append(line('^'), "import 'package:flutter_test/flutter_test.dart';");
    call append(line('$'), "void main() {");
    call append(line('$'), "  test('...', () {");
    call append(line('$'), "    // TODO: Implement test");
    call append(line('$'), "  });");
    call append(line('$'), "}");
  else
    execute ':open ' . file
  endif
endfunction

function! DoShuffle() range
  let range = a:firstline . ',' . a:lastline
  silent execute range . 's/^/\=rand() . " "'
  silent execute range . 'sort n'
  silent execute range . 's/\d\+ //g'
endfunction
command! -range=% Shuffle <line1>,<line2> call DoShuffle()

function! CreateVimspector()
  let file = './.vimspector.json'
  let keyFile = './.keys.json'

  if !filereadable(keyFile) 
    call writefile([], keyFile)
  endif

  if !filereadable(file) 
    let fileText = []
    call add(fileText, '{                                                                                ')
    call add(fileText, '  "configurations": {                                                            ')
    call add(fileText, '    "Launch": {                                                                  ')
    call add(fileText, '      "adapter": "dart-code",                                                    ')
    call add(fileText, '      "breakpoints": {                                                           ')
    call add(fileText, '        "exception": {                                                           ')
    call add(fileText, '          "All": "N",                                                            ')
    call add(fileText, '          "Unhandled": "N"                                                       ')
    call add(fileText, '        }                                                                        ')
    call add(fileText, '      },                                                                         ')
    call add(fileText, '      "configuration": {                                                         ')
    call add(fileText, '       "request": "launch",                                                      ')
    call add(fileText, '       "type": "flutter",                                                        ')
    call add(fileText, '       "dartSdkPath": "/home/paulo/.development/flutter/bin/cache/dart-sdk/bin", ')
    call add(fileText, '       "flutterSdkPath": "/home/paulo/.development/flutter/",                    ')
    call add(fileText, '       "program": "${workspaceRoot}/lib/main.dart",                              ')
    call add(fileText, '       "cwd": "${workspaceRoot}",                                                ')
    call add(fileText, '       "args": [                                                                 ')
    call add(fileText, '         "-d", "linux",                                                          ')
    call add(fileText, '         "--dart-define-from-file","./keys.json"                                 ')
    call add(fileText, '       ]                                                                         ')
    call add(fileText, '      }                                                                          ')
    call add(fileText, '    }                                                                            ')
    call add(fileText, '  }                                                                              ')
    call add(fileText, '}                                                                                ')
    call writefile(fileText, file)
  endif
  call vimspector#Launch()
endfunction

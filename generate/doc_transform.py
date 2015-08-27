import sys
import re

fn = sys.argv[1]
with open(fn, encoding='utf-8') as f:
    src = f.read()


def empty_lines(m):
    return '\n' * m.group().count('\n')

def sub(regex, sub=empty_lines, flags=0):
    global src
    src = re.sub(regex, sub, src, flags=re.UNICODE|re.MULTILINE|flags)

sub(r'^ *@\[.+\]$')

sub(r'^require ".+_lib"$')

sub(r'^  fun .+$')

if '_lib' in fn:
    sub(r'^lib CSFML$', 'module CSFML')
    sub('^ *#.*$')

    sub(r'^    [^ ]+: .+$')
    
    sub(r'^ *type (.+?) = Void\*$')
    sub(r'^  union\b', '  struct')
else:
    sub(r'^lib CSFML$', 'begin')

sub(r'^  struct CSFML::(.+)$[.\n]+?^  end$', r'  struct \1; end')
sub(r'^  struct CSFML::(.+)$', r'  struct \1')
sub(r'^  alias (.+) = CSFML::\1 # union', r'  struct \1; end')
sub(r'^  alias (.+) = CSFML::\1 # ([a-z]+)$', r'  \2 \1; end')

sub(r'^ *include Wrapper.+$')


with open(fn, 'w', encoding='utf-8') as f:
    f.write(src)

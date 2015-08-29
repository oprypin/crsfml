# Copyright (C) 2015 Oleh Prypin <blaxpirit@gmail.com>
#
# This file is part of CrSFML.
#
# This software is provided 'as-is', without any express or implied
# warranty. In no event will the authors be held liable for any damages
# arising from the use of this software.
#
# Permission is granted to anyone to use this software for any purpose,
# including commercial applications, and to alter it and redistribute it
# freely, subject to the following restrictions:
#
# 1. The origin of this software must not be misrepresented; you must not
#    claim that you wrote the original software. If you use this software
#    in a product, an acknowledgement in the product documentation would be
#    appreciated but is not required.
# 2. Altered source versions must be plainly marked as such, and must not be
#    misrepresented as being the original software.
# 3. This notice may not be removed or altered from any source distribution.

import os.path
import re
import sys

try:
    inc_path = sys.argv[1]
except IndexError:
    inc_path = 'CSFML/include'

skip = 'WindowHandle'.split()

src = ['''
typedef int sfWindowHandle;
typedef int size_t;
typedef int wchar_t;
''']

doc = []

doc_counter = 0
visited = set()

def visit_header(file_path):
    if file_path in visited:
        return

    visited.add(file_path)

    for h in skip:
        if file_path.endswith(h+'.h'):
            return

    write_doc = False

    with open(os.path.join(inc_path, file_path), encoding='ascii') as src_file:
        src.append('\n\n;;;;enum {};;;;\n\n'.format(file_path[:-2].replace('/', '_')))

        for line in src_file:
            if line.strip().startswith('//////'):
                write_doc = False
                continue

            if line.strip().startswith('///') and '\\brief' in line:
                write_doc = True
                global doc_counter
                doc_counter += 1
                doc.append('--------')
                src.append(';;;;enum doc{};;;;'.format(doc_counter))

            if write_doc:
                line = line.strip()
                assert line.startswith('//')
                doc.append(line.lstrip('/').strip())
                continue

            if '//' in line and not line.startswith('//'):
                line = line.split('//')[0]

            line = line.strip()

            if not line:
                continue

            if line.startswith('#include'):
                m = re.match(r'#include <(SFML/.+\.h)>', line)
                if m and not m.group(1).endswith('Export.h'):
                    visit_header(m.group(1))

            if line.startswith('#') or line.startswith('//'):
                continue

            if '__int64' in line or 'HWND__' in line:
                continue

            if line.startswith('typedef') and line.rstrip(';').endswith(tuple(skip)):
                continue

            if '_API' in line:
                line = re.sub(r'CSFML_[A-Z]+_API ?', '', line)

            line = line.replace('(void)', '()')

            if '<<' in line:
                line = re.sub(r'1 *<< *([0-9]+)', lambda m: str(1<<int(m.group(1))), line)

            line = line.replace('sfTitlebar | sfResize | sfClose', '7')
            src.append(line)

    src.append('\n')


for m in ['system', 'window', 'graphics', 'audio', 'network']:
    visit_header('SFML/{}.h'.format(m.capitalize()))


with open('headers_gen.h', 'w', encoding='utf-8') as f:
    f.write('\n'.join(src))

with open('docs_gen.txt', 'w', encoding='utf-8') as f:
    f.write('\n'.join(doc[1:-1]))

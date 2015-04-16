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


import sys
import re
import textwrap
import itertools
import collections

from pycparser import parse_file, c_ast, c_generator



with open('docs_gen.txt') as f:
    docs = f.read().strip().split('\n--------\n')


def rename_sf(name):
    if name is None:
        return name
    if not name.startswith('sf'):
        raise ValueError(name)
    return name[2:]

def rename_type(name, var=''):
    orname = name
    m = re.match('^(.+) *\[([0-9]+)\]$', name)
    if m:
        name, arrsize = m.groups()
        arrsize = int(arrsize)
    else:
        arrsize = None
    name = re.sub(r'\bconst\b', '', name).strip()
    if name.startswith('sf') and ('Int' in name or 'Uint' in name) and 'Rect' not in name:
        name = name[2:].replace('i', 'I')
    ptr = name.count('*')
    name = name.replace('*', '').strip()
    name = {
        'char': 'UInt8',
        'int': 'Int32',
        #'size_t': 'int',
        'unsigned int': 'Int32',
        'float': 'Float32',
        'sfBool': 'Int32',
        'sfVector2u': 'sfVector2i',
    }.get(name, name)
    if ptr and 'sf' in name:
        if rename_sf(name) in classes:
            ptr -= 1
    try:
        name = rename_sf(name)
    except ValueError:
        pass
    name = name[0].upper()+name[1:]+'*'*ptr
    if arrsize:
        name = '{}[{}]'.format(name, arrsize)
    return name

def rename_identifier(name):
    #name = {
        #'object': 'obj',
        #'type': 'kind',
        #'bind': 'bindGL',
    #}.get(name, name)
    #name = name.replace('String', 'Str').replace('string', 'str')
    return re.sub('[A-Z]', lambda m: '_'+m.group(0).lower(), name).strip('_')

def common_start(strings):
    if not strings:
        return ''
    first = strings[0]
    for i in range(1, len(first)+1):
        if not all(s[:i]==first[:i] for s in strings):
            return first[:i-1]
    return first


def get_doc(indent=2):
    global doc
    if doc is None:
        return None
    r = '\n'.join(indent*' '+'# '+l for l in doc.splitlines())
    doc = None
    return r


def handle_enum(name, items):
    if name is None:
        for name, value in items:
            name = rename_sf(name)
            lib('{} = {}'.format(name, value) if value is not None else name)
        return
    
    nitems = [name for name, value in items]
    c = len(common_start(nitems))
    nitems = [nitem[c:] for nitem in nitems]
    nitems = list(zip(nitems, (value for name, value in items)))
    
    nname = rename_sf(name)
    if all(value is not None for name, value in nitems):
        nitems.sort(key=lambda kv: int(kv[1]))
    lib('enum {}'.format(nname))
    d = get_doc()
    if d: lib(d)
    lib(*(textwrap.wrap(', '.join(
        ('{} = {}'.format(name, value) if value is not None else name)
        for name, value in nitems
    ), 78, initial_indent='  ', subsequent_indent='  ')))
    lib('end')

def handle_struct(name, items):
    if name=='sfVector2u':
        return
    name = rename_type(name)
    lib('struct {}'.format(name))
    d = get_doc()
    if d: lib(d)
    
    for typ, name in items:
        if typ in ['sfEventType']:
            continue
        typ = rename_type(typ)
        if typ=='UInt32' and name=='unicode':
            typ = 'Char'
        lib('  {}: {}'.format(rename_identifier(name), typ))
    lib('end')

def handle_union(name, items):
    name = rename_type(name)
    lib('union {}'.format(name))
    d = get_doc()
    if d: lib(d)
    
    for typ, name in items:
        typ = rename_type(typ)
        lib('  {}: {}'.format(name, typ))
    lib('end')


classes = set()
def handle_class(name):
    pname = rename_sf(name)
    classes.add(pname)
    lib('type {0} = Void*'.format(pname))
    d = get_doc()
    if d: lib(d)
    lib()


def handle_function(main, params):
    public = '*'
    ftype, ofname = main
    nfname = rename_sf(ofname)
    fname = rename_identifier(rename_sf(ofname))
    nfname = re.sub(r'(.+)_create.*', r'new\1', nfname)
    nfname = re.sub(r'(.+)_from.+', r'\1', nfname)
    nfname = re.sub(r'(.+)With.+', r'\1', nfname)
    nfname = re.sub(r'([gs]et.+)RenderWindow$', r'\1', nfname)
    if nfname != 'Shader_setCurrentTextureParameter':
        nfname = re.sub(r'_set(.+)Parameter$', r'_setParameter', nfname)
    if 'unicode' in fname.lower():
        nfname += '_U32'
    if params:
        p1 = rename_type(params[0][0])+'_'
        if nfname.startswith(p1):
            nfname = nfname[len(p1):]
    nfname = rename_identifier(nfname)
    nftype = rename_type(ftype)
    main_sgn = 'fun {fname} = {ofname}({sparams}): {nftype}'
    pragmas = []
    if nfname=='destroy':
        pragmas.append('destroy')
    if nfname.startswith('get') and nfname[3].isupper() and len(params)==1:
        nfname = nfname[3].lower()+nfname[4:]
    elif nfname.startswith('is') and nfname[2].isupper() and len(params)==1:
        nfname = nfname[2].lower()+nfname[3:]
    elif nfname.startswith('set') and nfname[3].isupper() and len(params)==2:
        nfname = nfname[3].lower()+nfname[4:]+'='
    if nfname.startswith('unicode'):
        nfname = nfname[7].lower()+nfname[8:]
    if nftype=='void':
        main_sgn = main_sgn[:-10]
    if nftype=='cstring' and nfname in ['str', 'title']:
        nfname += 'C'
    if nftype=='UInt32*':
        nftype = 'Char*'
        public = ''
    if nftype=='UInt32':
        if nfname in ['style']: nftype = 'BitMaskU32'
        else: nftype = 'Char'
    #if nftype.startswith('ptr ') or nftype=='pointer':
        #public = ''

    aparams = []
    replv = []
    sgn = main_sgn
    for ptype, pname in params:
        rtype = rename_type(ptype, pname)
        rname = rename_identifier(pname) or 'p{}'.format(i)
        if rtype=='cstring' and rname in ['str', 'title']:
            if not nfname.endswith('C'):
                nfname += 'C'
        if rtype=='UInt32*':
            rtype = 'Char*'
            public = ''
        if rtype=='UInt32':
            if rname in ['style']: rtype = 'BitMaskU32'
            else: rtype = 'Char'
        if ptype.startswith('const') and rtype.startswith('var '):
            rrtype = rtype[4:]
            replv.append(rname)
        else:
            rrtype = rtype
        #if rtype.startswith('ptr ') or rtype=='pointer':
            #public = ''
        aparams.append((rname, rrtype))
    sparams = ', '.join('{}: {}'.format(*p) for p in aparams)

    d = get_doc()
    lib(main_sgn.format(**locals()))
    if d: lib(d)
    lib()


def handle_functiondef(main, params):
    ftype, fname = main
    params = ', '.join(
        rename_type(ptype)
        for ptype, pname in params
    )
    lib('alias {} = ({}) -> {}'.format(rename_sf(fname), params, rename_type(ftype)))



cgen = c_generator.CGenerator()

def type_to_str(node):
    ptrs = 0
    while isinstance(node, c_ast.PtrDecl):
        node = node.type
        ptrs += 1
    return ' '.join(node.type.names)+'*'*ptrs, node.declname

def gen_expr_to_str(node):
    return cgen.visit(node)

def gen_type_to_str(node):
    name = None
    try: name = node.name
    except AttributeError: pass
    try: name = node.declname
    except AttributeError: pass
    typ = gen_expr_to_str(node)
    if name:
        typ = ' '.join(re.sub(r'\b{}\b'.format(name), '', typ).split())
    return typ, name


def _debug(node):
    try:
        for k, v in node.__dict__.items():
            if k.startswith('_'):
                continue
            if isinstance(v, list) and len(v)>0:
                yield '{} = ['.format(k)
                for it in v:
                    yield '    {!r} ('.format(it)
                    for l in _debug(it):
                        yield textwrap.indent(l, '        ')
                    yield ')'
                yield ']'
            else:
                yield '{} = {!r} ('.format(k, v)
                for l in _debug(v):
                    yield textwrap.indent(l, '    ')
                yield ')'
    except Exception as e:
        pass
def debug(node):
    class root:
        pass
    root = root()
    root.root = node
    r = '\n'.join(_debug(root))[7:]
    r = re.sub(r' \(\n *\)', '', r)
    r = re.sub(r' object at 0x[0-9a-f]+', '', r)
    return r

class Visitor(c_ast.NodeVisitor):
    def visit_FuncDecl(self, node):
        try:
            func_type, func_name = type_to_str(node.type)
            func_params = [gen_type_to_str(param_decl) for param_decl in node.args.params] if node.args else []
            if len(func_params)==1 and func_params[0][0]=='void':
                func_params = []
            handle_function((func_type, func_name), func_params)
        except AttributeError as e:
            print(func_name, repr(e), file=sys.stderr)

    def visit_Typedef(self, node):
        if isinstance(node.type.type, (c_ast.Enum, c_ast.Struct)):
            node.type.type.my_name = node.type.declname
        if type(node.type.type).__name__=='Union':
            name = node.name
            node = node.type.type
            if node.decls:
                items = [gen_type_to_str(decl) for decl in node.decls]
            handle_union(name, items)

            #print(debug(node))
        try:
            r = (
                (gen_type_to_str(node.type.type.type.type)[0], node.name),
                [gen_type_to_str(p) for p in node.type.type.args.params]
            )
        except Exception as e:
            pass
        else:
            handle_functiondef(*r)
            return

        self.generic_visit(node)

    def visit_Enum(self, node):
        try:
            name = node.my_name
        except AttributeError:
            name = node.name
        if node.values:
            items = [
                (en.name, (gen_expr_to_str(en.value) if en.value else None))
                for en in node.values.enumerators
            ]
            handle_enum(name, items)
        else:
            if name.startswith('doc'):
                global doc
                doc = docs[int(name[3:])-1].strip()
                doc = re.sub(r'(Example:\s+)?\\code(.|\n)+?\\endcode\n', r'', doc)
                doc = re.sub(r'\\brief ', r'', doc)
                doc = re.sub(r'\\param', r'Arguments:\n\\param', doc, 1)
                doc = re.sub(r'\\param ([a-zA-Z0-9_]+)', r'- \1: ', doc)
                doc = re.sub(r'\\li ', r'- ', doc)
                doc = re.sub(r'\\a ([a-zA-Z0-9_]+)', r'`\1`', doc)
                doc = re.sub(r'\\return ', r'Returns: ', doc)
                doc = re.sub(r'\bsf([A-Z])', r'\1', doc)
                doc = re.sub(r'\b([a-z][a-z0-9]*[A-Z][a-zA-Z0-9]+)\b', lambda m: rename_identifier(m.group(0)), doc)
            else:
                global cmodule
                cmodule = name.split('_')[1].lower()
                #lib('\n#--- {} ---#'.format(name.replace('_', '/')))

        self.generic_visit(node)

    def visit_Struct(self, node):
        try:
            name = node.my_name
        except AttributeError:
            name = node.name
        if node.decls:
            items = [gen_type_to_str(decl) for decl in node.decls]
            handle_struct(name, items)
        else:
            handle_class(name)

        self.generic_visit(node)



libs = collections.defaultdict(list)
def lib(*args):
    libs[cmodule].extend(itertools.chain.from_iterable(a.splitlines() for a in args))
    if not args or args[0].startswith('end'):
        libs[cmodule].append('')
objs = collections.defaultdict(collections.OrderedDict)
def obj(cls, *args):
    try:
        lst = objs[cmodule][cls]
    except KeyError:
        objs[cmodule][cls] = lst = []
    lst.extend(itertools.chain.from_iterable(a.splitlines() for a in args))

ast = parse_file('headers_gen.h')
Visitor().visit(ast)

for mod, lines in libs.items():
    with open('{}_lib.cr'.format(mod), 'w') as f:
        f.write('@[Link("csfml-{}")]\n\nlib CSFML\n'.format(mod))
        f.write('\n'.join('  '+l for l in lines))
        f.write('\nend')
for mod, classes in objs.items():
    with open('{}.cr'.format(mod), 'w') as f:
        f.write('require "./{}_lib"'.format(mod))
        for lines in clss.values():
            f.write('\n\n')
            f.write('\n'.join(lines))

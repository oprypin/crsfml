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
        'sfBool': 'Int32',
        'unsigned int': 'Int32',
        'float': 'Float32',
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
    name = re.sub('[A-Z](?![A-Z]|$)', lambda m: '_'+m.group(0).lower(), name)
    name = re.sub('[A-Z]+', lambda m: '_'+m.group(0).lower()+'_', name)
    return name.replace('__', '_').strip('_')

def common_start(strings):
    if not strings:
        return ''
    first = strings[0]
    for i in range(1, len(first)+1):
        if not all(s[:i]==first[:i] for s in strings):
            return first[:i-1]
    return first


def get_doc(indent=0):
    global doc
    if doc is None:
        return None
    r = '\n'.join(indent*' '+'# '+l for l in doc.splitlines())
    doc = None
    return r


aliases = set()
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
    s = 'enum {}'.format(nname)
    if nname in ['WindowStyle', 'TextStyle']:
        s += ': UInt32'
    d = get_doc()
    if d: lib(d)
    lib(s)
    lib(*(textwrap.wrap(', '.join(
        ('{} = {}'.format(name, value) if value is not None else name)
        for name, value in nitems
    ), 78, initial_indent='  ', subsequent_indent='  ')))
    lib('end')
    
    if d: obj(nname, d)
    obj(nname, 'alias {0} = CSFML::{0}'.format(nname))
    aliases.add(nname)

def handle_struct(name, items):
    if name=='sfVector2u':
        return
    name = rename_type(name)
    d = get_doc()
    if d: lib(d)
    lib('struct {}'.format(name))
    
    for t, n in items:
        t = rename_type(t)
        if t=='UInt32' and n=='unicode':
            t = 'Char'
        lib('  {}: {}'.format(rename_identifier(n), t))
    lib('end')
    
    if d: obj(name, d)
    obj(name, 'alias {0} = CSFML::{0}'.format(name))
    aliases.add(name)

def handle_union(name, items):
    name = rename_type(name)
    d = get_doc()
    if d: lib(d)
    lib('union {}'.format(name))
    
    for t, n in items:
        t = rename_type(t)
        lib('  {}: {}'.format(n, t))
    lib('end')

    if d: obj(name, d)
    obj(name, 'alias {0} = CSFML::{0}'.format(name))
    aliases.add(name)


classes = set()
def handle_class(name):
    pname = rename_sf(name)
    classes.add(pname)
    d = get_doc()
    if d: lib(d)
    lib('type {0} = Void*'.format(pname), '')
    
    obj(pname, 'class {}'.format(pname))
    obj(pname, 'def self.wrap_ptr(p)\n'.format(pname))
    obj(pname, '  result = self.allocate()'.format(pname))
    obj(pname, '  result.this = p'.format(pname))
    obj(pname, '  result'.format(pname))
    obj(pname, 'end'.format(pname))
    obj(pname, 'def to_unsafe\n'.format(pname))
    obj(pname, '  @this'.format(pname))
    obj(pname, 'end'.format(pname), '')
    if d: obj(pname, d)


def handle_function(main, params):
    public = True
    ftype, ofname = main
    nfname = rename_sf(ofname)
    fname = rename_identifier(rename_sf(ofname))
    nfname = re.sub(r'(.+)_create(From.+|Unicode)?$', r'\1_initialize', nfname)
    nfname = re.sub(r'(.+)([Ww]ith|[Ff]rom).+', r'\1', nfname)
    nfname = re.sub(r'([gs]et.+)RenderWindow$', r'\1', nfname)
    if nfname != 'Shader_setCurrentTextureParameter':
        nfname = re.sub(r'_set(.+)Parameter$', r'_setParameter', nfname)
    cls = ''
    p1 = rename_type(params[0][0] if params else ftype)
    if 'initialize' in nfname:
        cls = rename_type(ftype)
        nfname = 'initialize'
    elif ofname.startswith(p1+'_', 2) and p1 in classes:
        nfname = nfname[len(p1)+1:]
        cls = p1
    nfname = rename_identifier(nfname)
    nftype = rename_type(ftype)
    main_sgn = 'fun {fname} = {ofname}({sparams}): {nftype}'
    getter = False
    if nfname.startswith('get_') and len(params)==1 and cls:
        getter = True
        nfname = nfname[4:]
    if nfname.startswith('is_') and len(params)==1 and cls:
        getter = True
        nfname = nfname[3:]
    elif nfname.startswith('set_') and len(params)==2 and cls:
        nfname = nfname[4:]+'='
    if nfname.startswith('unicode_'):
        nfname = nfname[8:]
    if nftype=='Void':
        main_sgn = main_sgn[:-10]
    if nftype=='UInt8*' and nfname in ['str', 'title']:
        nfname += '_c'
        public = False
    if nftype=='UInt32*':
        nftype = 'Char*'
    if nftype=='UInt32':
        if nfname in ['style']:
            rtype = 'WindowStyle' if 'Window' in ofname else 'TextStyle'
        else: nftype = 'Char'
    #if nftype.startswith('ptr ') or nftype=='pointer':
        #public = False

    aparams = []
    const = []
    sgn = main_sgn
    
    for ptype, pname in params:
        rtype = rename_type(ptype, pname)
        rname = rename_identifier(pname) or 'p{}'.format(i)
        if rtype=='UInt32*':
            rtype = 'Char*'
        elif rtype=='UInt32':
            if rname in ['style']:
                rtype = 'WindowStyle' if 'Window' in ofname else 'TextStyle'
            else: rtype = 'Char'
        elif rtype=='UInt8*' and rname in ['str', 'title']:
            if not nfname.rstrip('=').endswith('_c'):
                nfname = nfname.rstrip('=') + '_c' + '='*nfname.count('=')
                public = False
        elif ptype.startswith('const'):
            if ptype.endswith('*') and ' sf' in ptype:
                const.append(rname)
        rrtype = rtype
        #if rtype.startswith('ptr ') or rtype=='pointer':
            #public = False
        aparams.append((rname, rrtype))
    sparams = ', '.join('{}: {}'.format(*p) for p in aparams)

    d = get_doc()
    if d: lib(d)
    lib(main_sgn.format(**locals()), '')
    
    if not public:
        return
    
    if nfname == 'initialize' or (aparams and aparams[0][1] not in classes):
        cut = False
        oparams = aparams[:]
    else:
        cut = True
        oparams = aparams[1:]
        params = params[1:]
    conv = []
    for i, (n, t) in enumerate(oparams):
        if t == 'UInt8*':
            t = 'String'
        elif t == 'Char*':
            t = 'String'
            conv.append('{0} = {0}.chars; {0} << \'\\0\''.format(n))
        elif params[i][0] == 'sfBool':
            t = 'Bool'
            conv.append('{0} = {0} ? 1 : 0'.format(n))
        elif t == 'Float32':
            t = None
            conv.append('{0} = {0}.to_f32'.format(n))
        if n in const and t not in classes:
            conv += 'if {0}\n  c{0} = {0}; p{0} = pointerof(c{0})\nelse\n  p{0} = nil\nend'.format(n).splitlines()
            t = None
        oparams[i] = (n, t)
    sparams = ', '.join('{}: {}'.format(n, t) if t else n for n, t in oparams)
    if not getter: sparams = '('+sparams+')'
    for i, (n, t) in enumerate(oparams):
        if n in const and t is None:
            n = 'p'+n
        oparams[i] = (n, t)
    if nfname == 'destroy':
        nfname = 'finalize'
    if d: obj(cls, d)
    obj(cls, 'def {nfname}{sparams}'.format(**locals()))
    for line in conv:
        obj(cls, '  '+line)
    if aparams:
        lparams = ', '.join(([] if not cut else ['@this']) + [n for n, t in oparams])
    else:
        lparams = ''
    call = 'CSFML.{fname}({lparams})'.format(**locals())
    if nfname == 'initialize':
        obj(cls, '  @owned = true')
        call = '@this = '+call
    elif nfname == 'finalize':
        call += ' if @owned'
    elif nftype in classes:
        call = 'self.wrap_ptr({})'.format(call)
    elif ftype == 'sfBool':
        call += ' != 0'
    obj(cls, '  '+call)
    obj(cls, 'end', '')


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
                doc = re.sub(r'\\param', r'*Arguments*:\n\n\\param', doc, 1)
                doc = re.sub(r'\\param ([a-zA-Z0-9_]+)', r'* `\1`: ', doc)
                doc = re.sub(r'\\li ', r'- ', doc)
                doc = re.sub(r'\\a ([a-zA-Z0-9_]+)', r'`\1`', doc)
                doc = re.sub(r'\\return ', r'*Returns*: ', doc)
                doc = re.sub(r'\bsf([A-Z])', r'\1', doc)
                doc = re.sub(r'\b([a-z][a-z0-9]*[A-Z][a-zA-Z0-9]+)\b', lambda m: rename_identifier(m.group(0)), doc)
                doc = re.sub(r' +', ' ', doc)
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



libs = collections.defaultdict(lambda: [[]])
def lib(*args):
    libs[cmodule].extend(itertools.chain.from_iterable(a.splitlines() or [''] for a in args))
    if not args or args[0].startswith('end'):
        libs[cmodule].append('')
def lib_pre(*args):
    libs[cmodule][0].extend(itertools.chain.from_iterable(a.splitlines() or [''] for a in args))
    if not args or args[0].startswith('end'):
        libs[cmodule][0].append('')
objs = collections.defaultdict(collections.OrderedDict)
def obj(cls, *args):
    try:
        lst = objs[cmodule][cls]
    except KeyError:
        objs[cmodule][cls] = lst = []
    lst += itertools.chain.from_iterable(a.splitlines() or [''] for a in args)

ast = parse_file('headers_gen.h')
Visitor().visit(ast)

for mod, lines in libs.items():
    with open('{}_lib.cr'.format(mod), 'w') as f:
        f.write('\n'.join(lines[0]))
        f.write('@[Link("csfml-{}")]\n\nlib CSFML\n'.format(mod))
        f.write('\n'.join('  '+l for l in lines[1:]))
        f.write('\nend')
for mod, classes in objs.items():
    with open('{}.cr'.format(mod), 'w') as f:
        f.write('require "./{}_lib"\n\n'.format(mod))
        f.write('module SF\n  extend self\n\n')
        for cls, lines in classes.items():
            if not cls:
                continue
            ind = 2
            for l in lines:
                f.write(' '*ind + l + '\n')
                if not l.startswith('#'):
                    ind = 4
            if not lines[-1].startswith(('alias')):
                f.write('end\n')
            f.write('\n')
        if '' in classes:
            f.write('\n'.join('  '+l for l in classes['']))
        f.write('\nend')

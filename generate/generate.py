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



with open('docs_gen.txt', encoding='utf-8') as f:
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
        'char': 'LibC::Char',
        'int': 'Int32',
        'size_t': 'LibC::SizeT',
        'sfBool': 'CSFML::Bool',
        'unsigned int': 'Int32',
        'unsigned short': 'UInt16',
        'float': 'Float32',
        'double': 'Float64',
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
    return name.replace('__', '_').replace('._', '.').strip('_')

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

    comments = ''

    for line in doc.splitlines():
        start = '# ' if line else '#'
        comments += '\n' + indent * ' ' + start + line

    doc = None

    return comments.strip()

enum_relations = {
    'JoystickAxis': 'Joystick',
    'MouseButton': 'Mouse',
    'MouseWheel': 'Mouse',
    'BlendEquation': 'BlendMode',
    'EventType': 'Event',
    'ContextAttribute': 'ContextSettings',
    'BlendFactor': 'BlendMode',
    'KeyCode': 'Keyboard',
    'TextStyle': 'Text',
    'SensorType': 'Sensor',
    'SoundStatus': 'SoundSource',
    'PrimitiveType': '',
    'WindowStyle': '',
    'FtpTransferMode': 'Ftp',
    'FtpStatus': 'FtpResponse',
    'HttpMethod': 'HttpRequest',
    'HttpStatus': 'HttpResponse',
    'SocketStatus': 'Socket',
}
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
    
    def subname(name):
        return {'ButtonCount': 'Count', 'DefaultStyle': 'Default'}.get(name, name)

    nname = rename_sf(name)
    if all(value is not None for name, value in nitems):
        nitems.sort(key=lambda kv: int(kv[1]))
    d = get_doc()
    if d: lib(d)
    s = 'enum {}'.format(nname)
    if nname in ['WindowStyle', 'TextStyle', 'ContextAttribute']:
        lib('@[Flags]')
        s += ': UInt32'
    lib(s)
    lib(*(textwrap.wrap(', '.join(
        ('{} = {}'.format(subname(name), value) if value is not None else subname(name))
        for name, value in nitems
    ), 78, initial_indent='  ', subsequent_indent='  ')))
    lib('end')
    
    if d: obj(nname+'ALIAS', d, '#')
    for name, value in nitems:
        cls = enum_relations[nname] or 'SF'
        obj(nname+'ALIAS', '# * `{cls}`::{name}'.format(**locals()))
    obj(nname+'ALIAS', 'alias {0} = CSFML::{0} # enum'.format(nname))
    for name, value in nitems:
        orcls = cls = enum_relations[nname]
        if cls and cls in structs:
            cls = 'CSFML::'+cls
        if cls and cls not in objs[cmodule]:
            obj(cls, ('struct ' if orcls in structs else 'class ')+cls)
        sub = subname(name)
        suffix = '.value' if name.endswith('Count') else ''
        obj(cls, '{name} = CSFML::{nname}::{sub}{suffix}'.format(**locals()))

structs = {'Event': None, 'BlendMode': None, 'ContextSettings': None}
def handle_struct(name, items):
    if name=='sfVector2u':
        return
    name = rename_type(name)
    structs[name] = [rename_identifier(n) for t, n in items]
    d = get_doc()
    if d: lib(d)
    lib('struct {}'.format(name))
    
    if d: obj(name+'ALIAS', d, '#')
    for t, n in items:
        t = rename_type(t)
        if t=='UInt32' and n=='unicode':
            t = 'Char'
        elif t=='UInt32' and n=='attributeFlags':
            t = 'ContextAttribute'
        if t in ['Vector2f', 'Vector2i']:
            t = 'Vector2'
        n = rename_identifier(n)
        obj(name+'ALIAS', '# * {n} : `{t}`'.format(**locals()))
    obj(name+'ALIAS', '#', "# Do not use `.new`; `SF` module may contain constructor methods for this struct.")
    obj(name+'ALIAS', 'alias {0} = CSFML::{0} # struct'.format(name))
    
    for t, n in items:
        rt = rename_type(t)
        rn = rename_identifier(n)

        special = ''
        if 'Vector2' in t or '*' in t and 'void' not in t and '*' not in rt:
            special = '_'

        if rt=='UInt32' and n=='unicode':
            rt = 'Char'
        elif rt=='UInt32' and n=='attributeFlags':
            rt = 'ContextAttribute'
        lib('  {}{}: {}'.format(rename_identifier(n), special, rt))

        if special:
            if name and name not in objs[cmodule]:
                obj(name, 'struct CSFML::'+name)
            
            obj(name, 'def {}'.format(rn))
            if 'Vector2' in t:
                obj(name, '  SF.vector2({}_)'.format(rn))
            else:
                obj(name, '  SF::{}.wrap_ptr?({}_)'.format(rt, rn))
            obj(name, 'end')
            
            obj(name, 'def {}=(value)'.format(rn))
            if 'Vector2' in t:
                obj(name, '  self.{}_ = SF.{}(value)'.format(rn, rt.lower()))
            else:
                obj(name, '  self.{}_ = value ? value.to_unsafe : Pointer(Void).null as CSFML::{}'.format(rn, rt))
            obj(name, 'end')
    
    lib('end')

def handle_union(name, items):
    name = rename_type(name)
    structs[name] = None
    d = get_doc()
    if d: lib(d)
    lib('union {}'.format(name))
    
    for t, n in items:
        t = rename_type(t)
        lib('  {}: {}'.format(rename_identifier(n), t))
    lib('end')

    if d: obj(name+'ALIAS', d)
    obj(name+'ALIAS', 'alias {0} = CSFML::{0} # union'.format(name))


classes = set()
reimplemented = {'Shape', 'InputStream', 'SoundStreamChunk'}
def handle_class(name):
    pname = rename_sf(name)
    classes.add(pname)
    d = get_doc()
    if d: lib(d)
    lib('type {0} = Void*'.format(pname), '')
    
    obj(pname, 'class {}'.format(pname))
    if d: obj(pname, d)
    obj(pname, 'include Wrapper(CSFML::{})'.format(pname), '')


def handle_function(main, params, alias=None):
    public = True
    orparams = params
    ftype, ofname = main
    nfname = rename_sf(ofname)
    fname = rename_identifier(rename_sf(ofname))
    nfname = re.sub(r'(.+)_create(Unicode)?$', r'\1_initialize', nfname)
    nfname = re.sub(r'(.+?)_?(?<!create)([Ww]ith|[Ff]rom).+', r'\1', nfname)
    nfname = re.sub(r'(.+)_create(From.+)$', r'\1_\2', nfname)
    nfname = re.sub(r'([gs]et.+)RenderWindow$', r'\1', nfname)
    if nfname != 'Shader_setCurrentTextureParameter':
        nfname = re.sub(r'_set(.+)Parameter$', r'_setParameter', nfname)
    cls = ''
    p1 = rename_type(params[0][0]) if params else ''
    clsmethod = False
    if 'initialize' in nfname:
        cls = rename_type(ftype)
        nfname = 'initialize'
    elif p1 and ofname.startswith(p1.rstrip('*')+'_', 2):
        nfname = nfname[len(p1.rstrip('*'))+1:]
        cls = p1.rstrip('*')
    elif '_' in nfname:
        nfname = nfname.split('_', 1)[1]
        cls = ofname.split('_')[0][2:]
        clsmethod = True
        make_alias = True
    if cls and cls not in objs[cmodule]:
        obj(cls, ('struct CSFML::' if cls in structs else 'class ')+cls)

    nfname = rename_identifier(nfname)
    nftype = rename_type(ftype)
    main_sgn = 'fun {fname} = {ofname}({sparams}): {nftype}'
    getter = False
    if nfname == 'copy':
        nfname = 'dup'

    if not alias:
        if nfname.startswith('get_') and len(params) == 1-clsmethod and cls:
            getter = True
            nfname = nfname[4:]
        elif nfname.startswith('is_') and len(params) == 1-clsmethod and cls:
            getter = True
            nfname = nfname[3:]+'?'
        elif nfname.startswith('has_') and len(params) == 1-clsmethod and cls:
            getter = True
        elif nfname.startswith('set_') and len(params) == 2-clsmethod and cls:
            nfname = nfname[4:]+'='
        else:
            make_alias = False
        if nfname.startswith('unicode_'):
            nfname = nfname[8:]
        if nftype=='Void':
            main_sgn = main_sgn[:-10]
        if nftype=='LibC::Char*' and nfname in ['string', 'title']:
            nfname += '_c'
            public = False
        if nftype=='UInt32*':
            nftype = 'Char*'
        if nftype=='UInt32':
            if nfname == 'style':
                rtype = 'WindowStyle' if 'Window' in ofname else 'TextStyle'
    
    if clsmethod:
        nfname = 'self.'+nfname

    aparams = []
    const = []
    sgn = main_sgn
    
    anon_index = 0
    for i, (ptype, pname) in enumerate(params, 1):
        if 'wchar_t' in ptype or ')' in ptype:
            return
        rtype = rename_type(ptype, pname)
        if pname:
            rname = rename_identifier(pname)
        else:
            anon_index += 1
            rname = 'p{}'.format(anon_index)
        if rtype=='UInt32*':
            rtype = 'Char*'
        elif rtype=='UInt32':
            if rname in ['style']:
                rtype = 'WindowStyle' if 'Window' in ofname else 'TextStyle'
            else:
                if 'Font' in ofname:
                    rtype = 'Char'
        elif rtype=='LibC::Char*' and rname in ['string', 'title']:
            if not nfname.rstrip('=').endswith('_c'):
                nfname = nfname.rstrip('=') + '_c' + '='*nfname.count('=')
                public = False
        elif ptype.startswith('const '):
            if ptype.endswith('*') and ' sf' in ptype and not re.search(r'U?Int[0-9]+', rtype):
                const.append(rname)
        rrtype = rtype
        #if rtype.startswith('ptr ') or rtype=='pointer':
            #public = False
        aparams.append((rname, rrtype))
    sparams = ', '.join('{}: {}'.format(*p) for p in aparams)

    d = None
    if alias:
        if alias.startswith('self.'):
            alias = alias[5:]
        else:
            alias = '#' + alias
        d = '# Deprecated alias to `{}`'.format(alias)
    else:
        d = get_doc()
        if d: lib(d)
        lib(main_sgn.format(**locals()), '')
    
    if not public:
        return
    
    if nfname == 'initialize' or (aparams and (not ofname.startswith(aparams[0][1].rstrip('*'), 2))):
        cut = False
        oparams = aparams[:]
    else:
        cut = True
        oparams = aparams[1:]
        params = params[1:]
    conv = []
    i = 0
    while i < len(oparams)-1:
        rs = oparams[i][1].rstrip('*')
        if oparams[i][1] == 'Void*' and oparams[i+1][1] == 'LibC::SizeT' and 'size' in oparams[i+1][0]:
            oparams[i:i+2] = [(oparams[i][0]+', '+oparams[i+1][0], 'Slice|Array')]
            params[i:i+2] = [('', '')]
        elif len(oparams[i][1]) == len(rs)+1 and '_count' in oparams[i+1][0]:
            oparams[i:i+2] = [(oparams[i][0]+', '+oparams[i+1][0], 'Slice({0})|Array({0})'.format(rs))]
            params[i:i+2] = [('', '')]
        i += 1
    
    for i, (n, t) in enumerate(oparams):
        if t.rstrip('*') in reimplemented:
            t = t.rstrip('*')
        if t == 'LibC::Char*':
            t = 'String'
        elif t == 'Char*':
            t = 'String'
            conv.append('{0} = {0}.chars; {0} << \'\\0\''.format(n))
        elif params[i][0] == 'sfBool':
            t = 'Bool'
            conv.append('{0} = {0} ? 1 : 0'.format(n))
        elif t == 'Float32':
            t = 'Number'
            conv.append('{0} = {0}.to_f32'.format(n))
        elif (' '+params[i][0]).endswith(' int'):
            t = 'Int'
            conv.append('{0} = {0}.to_i32'.format(n))
        elif t == 'LibC::SizeT':
            t = 'Int'
            conv.append('{0} = LibC::SizeT.cast({0})'.format(n))
        elif t == 'UInt64':
            t = 'Int'
            conv.append('{0} = {0}.to_u64'.format(n))
        elif t == 'Int64':
            t = 'Int'
            conv.append('{0} = {0}.to_i64'.format(n))
        elif t == 'UInt16':
            t = 'Int'
            conv.append('{0} = {0}.to_u16'.format(n))
        elif t in ['Vector2f', 'Vector2i']:
            conv.append('{0} = SF.{2}({0}) unless {0}.is_a? {1}'.format(n, t, t.lower()))
            t = None
        elif t == 'Slice|Array':
            conv.append('{0} = ({1}.to_unsafe as Pointer(Void)), LibC::SizeT.cast({1}.length*sizeof(typeof({1}[0])))'.format(n, n.split(', ')[0]))
        elif 'Slice(' in t:
            conv.append('{0} = {1}.to_unsafe, LibC::SizeT.cast({1}.length*sizeof(typeof({1}[0])))'.format(n, n.split(', ')[0]))
        if n in const and t not in classes:
            conv += (
                'if {0}.responds_to?(:to_unsafe); '
                  'p{0} = {0}.to_unsafe\n'
                'elsif {0}; '
                  'c{0} = {0}; '
                  'p{0} = pointerof(c{0})\n'
                'else; '
                  'p{0} = nil; '
                'end'
            ).format(n).splitlines()
            t = None
        oparams[i] = (n, t)
    sparams = ', '.join(n.split(', ')[0] + ((': '+t) if t else '') for n, t in oparams)
    if not getter: sparams = '('+sparams+')'
    for i, (n, t) in enumerate(oparams):
        if n in const and t is None:
            n = 'p'+n
        oparams[i] = (n, t)
    if nfname == 'destroy':
        nfname = 'finalize'
    
    if d:
        d = re.sub(r'\bNULL (if\b.*?\bfail[a-z]+)', r'raises `NullResult` \1', d)
        obj(cls, d)
    obj(cls, 'def {nfname}{sparams}'.format(**locals()))
    for line in conv:
        obj(cls, '  '+line)
    if aparams:
        lparams = ', '.join(([] if not cut else ['@this' if cls in classes else ('pointerof(cself)' if p1.endswith('*') else 'self')]) + [n for n, t in oparams])
        if cls in structs and p1.endswith('*'):
            obj(cls, '  cself = self')
    else:
        lparams = ''
    call = 'CSFML.{fname}({lparams})'.format(**locals())
    if nfname == 'initialize':
        obj(cls, '  @owned = true')
        obj(cls, '  @this = '+call)
    elif nfname == 'finalize':
        obj(cls, '  {} if @owned'.format(call))
    elif nftype in classes:
        if nfname == 'dup' or '_create' in ofname:
            obj(cls, '  {}.transfer_ptr({})'.format(nftype, call))
        else:
            obj(cls, '  {}.wrap_ptr{}({})'.format(nftype, '?' if 'NULL' in d else '', call))
    elif nftype == 'Char*':
        obj(cls, '  ptr = {}'.format(call))
        obj(cls, '  String.build do |io|')
        obj(cls, '    while ptr.value != \'\\0\'')
        obj(cls, '      io << ptr.value; ptr += 1')
        obj(cls, '    end')
        obj(cls, '  end')
    elif nftype == 'LibC::Char*' and not nfname.endswith('_ptr'):
        obj(cls, '  ptr = {}'.format(call))
        obj(cls, '  ptr ? String.new(ptr) : ""'.format(call))
    elif ftype == 'sfBool':
        obj(cls, '  {} != 0'.format(call))
    elif 'Vector2' in ftype:
        obj(cls, '  SF.vector2({})'.format(call))
    else:
        obj(cls, '  '+call)
    if cut and cls in structs and orparams and not orparams[0][0].startswith('const') and '*' in orparams[0][0]:
        for p in structs[cls]:
            obj(cls, '  self.{0} = cself.{0}'.format(p))
            obj(cls, '  self')
    obj(cls, 'end', '')

    if clsmethod and make_alias and not alias:
        handle_function(main, oparams, alias=nfname)


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

deps = {'system': [], 'window': ['system'], 'graphics': ['system', 'window'], 'audio': ['system'], 'network': ['system']}
for mod, lines in libs.items():
    with open('{}_lib.cr'.format(mod), 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines[0]))
        f.write('require "./common_lib"\n')
        for d in deps[mod]:
            f.write('require "./{}_lib"\n'.format(d))
        f.write('\n@[Link("csfml-{}")]\n'.format(mod))
        f.write('# :nodoc:\n')
        f.write('lib CSFML\n\n')
        f.write('\n'.join((('  ' + line) if line else '') for line in lines[1:]))
        f.write('\nend\n')
for mod, classes in objs.items():
    with open('{}_obj.cr'.format(mod), 'w', encoding='utf-8') as f:
        f.write('require "./{}_lib"\n'.format(mod))
        f.write('require "./common_obj"\n\n')
        f.write('module SF\n  extend self\n\n')
        for cls, lines in classes.items():
            if not cls:
                continue
            if cls.endswith('ALIAS'):
                cls = cls[:-5]
            if cls in reimplemented:
                continue

            indent = 2

            for i, line in enumerate(lines):
                if line:
                    f.write(' ' * indent + line + '\n')
                else:
                    f.write('\n')

                if indent == 2 and not line.startswith('#'):
                    ii = i
                    indent = 4

            if not lines[ii].startswith('alias'):
                f.write('  end\n')
            f.write('\n')
        if '' in classes:
            f.write('\n'.join('  ' + line if line else '' for line in classes['']))

        f.write('\nend\n')

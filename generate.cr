# Copyright (C) 2016 Oleh Prypin <oleh@pryp.in>
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

require "digest/sha1"
require "./tools/serialize_docs"


LIB_NAME = "SFMLExt"
PREFIX = "sfml_"

DEBUG = ARGV.delete("--debug")
SAVE_DOCS = ARGV.delete("--save-docs") ? Hash(String, Hash(String, Array(String))).new : nil

INCLUDE_DIR = ARGV[0]? || "/usr/include"
SFML_PATH = File.join(INCLUDE_DIR,
  File.basename(INCLUDE_DIR) == "SFML.framework" ? "Headers" : "SFML"
)

MODULE_CLASSES = %w[NonCopyable GlResource Drawable RenderTarget AlResource]
STRUCTS = %w[IntRect FloatRect Vector2i Vector2u Vector2f Vector3f Time Transform IpAddress Music::TimeSpan]


enum Context
  CHeader
  CPPSource
  Crystal
  CrystalLib

  def cr?
    crystal? || crystal_lib?
  end
end

enum Visibility
  Private
  Protected
  Public
end


alias CTypeBase = CClass | CEnum | CNativeType

class CType
  @@all = {} of String => CTypeBase
  def self.all
    @@all
  end

  def initialize(@type : CTypeBase, @reference = false, @pointer = 0, @const = false, @array = 1)
  end

  getter type : CTypeBase
  getter? reference : Bool
  getter pointer : Int32
  getter? const : Bool
  getter array : Int32

  def void? : Bool
    (type = self.type).is_a?(CNativeType) && type.full_name == "void" && pointer == 0
  end

  def full_name : String
    r = type.full_name
    r += " const" if const?
    r += "*"*pointer
    r += "&" if reference?
    r
  end

  forward_missing_to @type
end


def register_type(type : CTypeBase)
  CType.all[type.full_name] = type
  CType.all["String"] = CNativeType.new("String")
end

STRUCTS.each do |name|
  register_type CClass.new(name)
end


def find_type(name : String, parent : CNamespace?) : CTypeBase
  loop do
    if parent
      parents = [parent]
      if parent.is_a?(CClass) && (inh = parent.inherited_class)
        parents << inh
      end
      full_names = parents.map { |parent| "#{parent.full_name}::#{name}" }
    else
      full_names = [name]
    end
    CType.all.each do |name, type|
      if full_names.includes? name
        return type
      end
    end
    if !parent
      return CNativeType.new(name)
    end
    parent = parent.parent
  end
end

macro remove_and_count(string, remove)
  %count = 0
  {{string.id}} = {{string.id}}.gsub({{remove}}) {
    %count += 1
    ""
  }
  %count
end

def make_type(name : String, parent : CNamespace?) : CType
  array = 1
  name = name.sub /\[([0-9]+)\]$/ do
    array = $1.to_i
    ""
  end
  info = {
    reference: remove_and_count(name, "&") > 0,
    pointer: remove_and_count(name, "*"),
    const: remove_and_count(name, /\bconst\b/) > 0,
    array: array,
  }
  name = name.strip

  type = find_type(name, parent)
  CType.new(type, **info)
end

def identifier_hash(string) : String
  base = 62
  size = 3
  digest = Digest::SHA1.digest(string)
  number = 0u64
  (digest.size - sizeof(UInt64) ... digest.size).each do |i|
    number <<= 8
    number |= digest[i]
  end
  (number % (base**size)).to_s(base).rjust(3, '0')
end


abstract class CItem
  def initialize(@name : String?, @visibility = Visibility::Public, @parent : CNamespace? = nil,
                 @docs : Array(String) = [] of String, @sfmodule : CModule? = nil)
  end

  getter parent : CNamespace?
  getter docs : Array(String) = [] of String
  getter visibility = Visibility::Public

  def name(context : Context) : String?
    @name
  end

  def full_name(context = Context::CPPSource) : String
    result = (name(context) || "@")
    if (parent = @parent)
      sep = (context.crystal_lib? ? "_" : "::")
      result = parent.full_name(context) + sep + result
    end
    result
  end

  def qualname : String
    parts = [parent.try(&.qualname) || "SF", name(Context::Crystal)]
    parts.compact.join("::")
  end

  def sfmodule : CModule
    @sfmodule || parent.not_nil!.sfmodule
  end

  abstract def render(context : Context, out o : Output)

  def render_docs(out o : Output, name : String)
    in_code = false
    in_annot = false
    while @docs[-1]? == ""
      @docs.pop
    end
    doc = String.build do |io|
      prev_line = ""
      in_list = false
      @docs.each do |line|
        if line == ""
          in_list = false
        end
        if line == "\\code"
          in_code = true
          line = "```c++"
        elsif line == "\\endcode"
          in_code = false
          line = "```"
        end
        unless in_code
          if line.starts_with? "\\"
            in_annot = true
          elsif !line.starts_with? "    "
            in_annot = false
          end
          line = line.lstrip if in_annot

          line = line.sub /^\\brief\b */, ""
          line = line.sub /^\\li\b */ do
            io << "\n" unless in_list
            in_list = true
            "* "
          end
          line = line.sub /^    \b/, "  "
          old_line = line
          line = line.sub /^\\param\b +([^ ()]+) +/ { "* *#{CParameter.new($1, make_type("", nil)).name(Context::Crystal)}* - " }
          line = line.sub /^\\(ingroup|relates)\b.*/, ""
          line = line.sub /^\\return +/, "*Returns:* "
          line = line.sub /^(\\warning\b|Warning:) +/, "WARNING: "
          line = line.sub /^\\deprecated\b */, "DEPRECATED: "
          if old_line != line && prev_line != "" && line.starts_with?("* ") != prev_line.starts_with?("* ")
            io << "\n"
          end
          line = line.gsub /(@ref|\\a) +([^ (),.]+)/ { "*#{$2.underscore}*" }
          line = line.gsub /\\(em|p) +([^ (),.]+)/ { "*#{$2}*" }
          line = line.sub /^\\overload\b/, ":ditto:"
          line = line.gsub /\bsf(::[^ \.;,()]+)\b/ { "`SF#{$1}`" }
          line = line.sub /(?<= )[a-z]\w+\b\(\)\B/ { "`#{$0}`" }
          line = line.sub /^\\see\b *(.+)/ { "*See also:* " + $1.gsub(/(?<!`)\b[\w\.]+\b(?!`)/, "`\\0`") }
          line = line.gsub /%([A-Z][a-zA-Z])/ { $1 }
          line = line.gsub /<\/?b>/, "**"
          line = line.gsub "\\n", "\n"
          line = line.gsub '<', "&lt;"
          line = line.gsub '>', "&gt;"
          line = line.gsub /\b([a-z][a-z0-9]+[A-Z][a-zA-Z0-9]*)\b/ { CFunction.new($1, nil, [] of CParameter).name(Context::Crystal) }
        end
        io << "#{line.rstrip}\n" unless line == "" == prev_line
        prev_line = line
      end
    end
    if (saved_docs = SAVE_DOCS) && !{"", ":nodoc:"}.includes?(doc.strip)
      module_docs = (saved_docs[sfmodule.name] ||= {} of String => Array(String))
      (module_docs[name] ||= [] of String) << doc
    end
    if (docs = CModule.docs[name]?)
      doc = docs.shift
      if docs.empty?
        CModule.docs.delete name
      end
    end
    doc.lines.each do |line|
      o<< "# #{line}"
    end
  end
end

abstract class CNamespace < CItem
  include Enumerable(CItem)

  getter items = [] of CItem

  def each
    items.each do |x|
      yield x
    end
  end

  def <<(item : CItem)
    @items << item
  end
end


class CClass < CNamespace
  def initialize(name : String?, inherited = [] of String, *args, **kwargs)
    super(name, *args, **kwargs)
    @inherited_class = nil
    @inherited_modules = [] of String
    inherited.each do |cls|
      if MODULE_CLASSES.includes? cls
        @inherited_modules << cls
      else
        @inherited_class = inh = find_type(cls, parent).as CClass
      end
    end
  end

  getter inherited_class : CClass?
  getter inherited_modules : Array(String)

  def render(context : Context, out o : Output)
    return unless @visibility.public?
    return if @name.not_nil! =~ /<|^String$|^ThreadLocal|SoundFile|^Lock$|^Chunk$/

    if abstract? && class?
      buf = [] of String

      if context.cpp_source?
        buf<< "class _#{full_name(context)} : public sf::#{full_name(context)} {"
        buf<< "public:"
        buf<< "void* parent;"
      end

      each do |func|
        next unless func.is_a?(CFunction) && !func.visibility.private?

        abstr = func.abstract? || func.name(Context::Crystal).starts_with?("on_")
        if func.visibility.protected? && !abstr && context.cpp_source? && !func.constructor?
          buf<< "using #{full_name(context)}::#{func.name(context)};"
        end
        next unless abstr

        c_params = ["void*"]
        cpp_params = [] of String
        cpp_args = ["parent"]
        cl_params = ["self : Void*"]
        cr_args = [] of String

        if (typ = func.type)
          return_param = CParameter.new("result", typ)
        end
        (func.parameters + [return_param].compact).each do |param|
          cpp_params << "#{param.type.full_name} #{param.name(Context::CPPSource)}" unless param == return_param
          if param.type.type.is_a?(CClass)
            if param.type.type.full_name == "SoundStream::Chunk" && param.type.reference?
              c_params << "Int16**" << "std::size_t*"
              cl_params << "#{param.name(Context::CrystalLib)} : Int16**" << "#{param.name(Context::CrystalLib)}_size : LibC::SizeT*"
              cpp_args << "(Int16**)&#{param.name(Context::CPPSource)}.samples" << "&#{param.name(Context::CPPSource)}.sampleCount"
            else
              c_params << "void*"
              cl_params << "#{param.name(Context::CrystalLib)} : Void*"
              cpp_args << "&" + param.name(Context::CPPSource)
              unless param == return_param
                unless param.type.is_a?(CNativeType)
                  cr_args << "#{param.name(Context::CrystalLib)}.as(#{param.type.full_name(Context::Crystal)}*).value"
                end
              end
            end
          else
            ptr = "#{"*"*param.type.pointer}#{"*" if param.type.reference?}#{"*" if param == return_param}"
            c_type = param.type.type.full_name(Context::CHeader) + ptr
            c_params << c_type
            cl_params << "#{param.name(Context::CrystalLib)} : #{param.type.type.full_name(Context::CrystalLib)}#{ptr}"
            cpp_args << "(#{c_type})#{"&" if param == return_param}#{param.name(Context::CPPSource)}"
            if param.name(Context::CPPSource) == "sampleCount"
              cr_args[-1] = "Slice(Int16).new(samples, sample_count)"
            elsif param.name(Context::CPPSource) == "size"
              cr_args[-1] = "Slice(UInt8).new(#{cr_args[-1]}.as(UInt8*), #{param.name(Context::CrystalLib)})"
            else
              cr_args << param.name(Context::CrystalLib) unless param == return_param
            end
          end
        end

        callback_name = "#{PREFIX}#{full_name(context).downcase}_#{func.name(Context::CPPSource).downcase}_callback"
        if context.cpp_source?
          o<< "void (*_#{callback_name})(#{c_params.join(", ")}) = 0;"
          o<< "void #{callback_name}(void (*callback)(#{c_params.join(", ")})) {"
          o<< "_#{callback_name} = callback;"
          o<< "}"
        end

        if context.cpp_source?
          typ = func.type.try &.full_name || "void"
          buf<< "virtual #{typ} #{func.name(context)}(#{cpp_params.join(", ")})#{" const" if func.const?} {"
          buf<< "#{return_param.type.full_name} result;" if return_param
          buf<< "_#{callback_name}(#{cpp_args.join(", ")});"
          buf<< "return result;" if return_param
          buf<< "}"
        end
        if context.crystal_lib?
          o<< "fun #{callback_name}(callback : (#{cl_params.map(&.split(" : ")[1]).join(", ")} ->))"
        end
        if context.crystal?
          o<< "#{LIB_NAME}.#{callback_name}(->(#{cl_params.join(", ")}) {"
          inst = ("self")
          o<< "#{"output = " if func.type}#{inst}.as(#{full_name(context)}).#{func.name(context)}(#{cr_args.join(", ")})"
          if func.parameters.any? { |param| param.type.full_name(Context::CPPSource) == "SoundStream::Chunk" }
            o<< "data.value, data_size.value = output.to_unsafe, LibC::SizeT.new(output.size) if output"
          end
          if (typ = func.type)
            if typ.type.full_name(Context::Crystal) == "Bool"
              o<< "result.value = !!output"
            elsif typ.type.is_a?(CNativeType)
              o<< "result.value = #{typ.type.full_name(Context::Crystal)}.new(output)"
            elsif typ.type.full_name == "Vector2f"
              o<< "result.as(Vector2f*).value = Vector2f.new(output[0].to_f32, output[1].to_f32)"
            else
              o<< "result.value = output"
            end
          end
          o<< "})"
        end
      end
      if context.cpp_source?
        buf<< "};"
        buf.each do |line|
          o<< line
        end
      end
    end

    if context.crystal?
      render_docs(o, qualname)
      inh = " < #{inherited_class.not_nil!.name(context)}" if inherited_class
      kind = case
      when module?
        "module"
      when struct?
        "struct"
      else
        "class"
      end
      abstr = "abstract " if abstract? && !module?
      parent = self.parent
      if parent.is_a?(CClass) && parent.union?
        inh = " < #{parent.name(context)}"
        abstr = "abstract "
      end
      o<< "#{abstr}#{kind} #{name(context)}#{inh}"
      if class?
        o<< "@this : Void*"
      end
    end
    if abstract? && class?
      CFunction.new(
        name: "parent", type: nil, parameters: [CParameter.new("parent", make_type("void*", nil))] of CParameter, parent: self
      ).render(context, o)
    end
    CFunction.new(
      "allocate", type: CType.new(self, pointer: 1), parameters: [] of CParameter, static: true, parent: self
    ).render(context, o)
    if none? { |item| item.is_a? CFunction && item.constructor? }
      CFunction.new(
        name(Context::CPPSource).not_nil!, type: nil, parameters: [] of CParameter, parent: self
      ).render(context, o)
    end
    if class? && none? { |item| item.is_a? CFunction && item.destructor? }
      CFunction.new(
        name: "~#{self.name(Context::CPPSource)}", type: nil, parameters: [] of CParameter, parent: self
      ).render(context, o)
    end
    CFunction.new(
      name: "free", type: nil, parameters: [] of CParameter, parent: self
    ).render(context, o)

    to_render = Set(CClass).new
    todo = [self]
    until todo.empty?
      to_render.concat(todo)
      todo = todo.map { |cls| ([cls.inherited_class] + cls.inherited_modules.map { |m| find_type(m, nil).as?(CClass) }).compact } .flatten
    end

    done_functions = Set(String).new
    union_var = union?
    each do |item|
      if item.is_a? CVariable
        if union_var
          if context.crystal?
            o<< "@_#{item.name(context)} = uninitialized #{item.type.name(context)}"
            o<< "# :nodoc:"
            o<< "def to_unsafe()"
            o<< "pointerof(@_#{item.name(context)})"
            o<< "end"
          end
          break
        end
        item.render(context, o, var_only: true)
      end
    end

    each do |item|
      if union_var
        next if item.is_a?(CVariable)
      end
      next unless item.render(context, o)
      if item.is_a? CFunction
        done_functions << item.name(Context::CrystalLib)
      end
    end
    to_render.each do |cls|
      cls.each do |item|
        if item.is_a?(CFunction)
          begin
            next if item.destructor? || item.constructor? || (item.abstract? && abstract?) || !item.parent
            func = CFunction.new(
              name: item.name(Context::CPPSource),
              type: item.type, parameters: item.parameters,
              static: item.static?, is_abstract: item.abstract?,
              visibility: item.visibility, parent: self, docs: [":nodoc:"]
            )
            func_name = func.name(Context::CrystalLib)
            next if done_functions.includes?(func_name)
            func.render(context, o)
            done_functions << func_name
          rescue
          end
        end
      end
    end

    if context.crystal?
      if union_var
        union_enum = union_var.type.type.as(CEnum)
        union_enum.members.each do |member|
          next if member.name(context) == "Count"
          inh = name(context)
          items.each do |item|
            if item.is_a? CClass
              if item.docs.join('\n') =~ /\b#{member.name(context)}\b/
                inh = item.name(context)
                break
              end
            end
          end
          member.render_docs(o, qualname + "::" + member.name(Context::Crystal))
          o<< "struct #{member.name(context)} < #{inh}"
          o<< "@_#{union_var.name(context)} = #{member.full_name(context)}"
          o<< "end"
        end
      end

      inherited_modules.each do |mod|
        o<< "include #{mod}"
      end

      unless module? || inh
        o<< "# :nodoc:"
        o<< "def to_unsafe()"
        if struct?
          o<< "pointerof(@#{find(&.is_a? CVariable).not_nil!.name(Context::Crystal)}).as(Void*)"
        else
          o<< "@this"
        end
        o<< "end"
      end
      if class?
        o<< "# :nodoc:"
        o<< "def inspect(io)"
        o<< "to_s(io)"
        o<< "end"
      end
    end

    if has_module?("Drawable")
      %w[RenderTexture RenderWindow RenderTarget].each do |target|
        func = CFunction.new("draw", type: nil,
          parameters: [CParameter.new("target", make_type("const #{target} &", nil)),
                      CParameter.new("states", make_type("RenderStates", nil))],
          visibility: visibility, parent: self, docs: [":nodoc:"]
        )

        if context.cpp_source?
          o<< "void #{func.name(Context::CrystalLib)}(void* self, void* target, void* states) {"
          o<< "((#{target}*)target)->draw(*(#{"_" if abstract?}#{self.full_name(context)}*)self, *(RenderStates*)states);"
          o<< "}"
        else
          func.render(context, o)
        end
      end
    end

    unless has_module?("NonCopyable") || has_module?("RenderTarget") || has_module?("AlResource") || module? || abstract?
      CFunction.new(@name.not_nil!, type: nil,
        parameters: [CParameter.new("copy", CType.new(self, reference: true, const: true))],
        visibility: Visibility::Public, parent: self, docs: [":nodoc:"]
      ).render(context, o)
      if context.crystal?
        o<< "def dup() : #{name(Context::Crystal)}"
        o<< "return #{name(Context::Crystal)}.new(self)"
        o<< "end"
      end
    end

    if context.crystal?
      o<< "end"

      each do |func|
        next unless func.is_a? CFunction
        next unless (typ = func.const_reference_getter?)
        o<< "# :nodoc:"
        o<< "class #{typ.full_name(context)}::Reference < #{typ.full_name(context)}"
        o<< "def initialize(@this : Void*, @parent : #{name(context)})"
        o<< "end"
        o<< "def finalize()"
        o<< "end"
        o<< "def to_unsafe()"
        o<< "@this"
        o<< "end"
        o<< "end"
      end
    end
  end

  def union? : CVariable?
    if full_name(Context::CPPSource) == "Event"
      each do |item|
        if item.is_a?(CVariable) && item.visibility.public?
          return item
        end
      end
    end
  end
  def struct? : Bool
    return false if module?
    return false if inherited_class
    return true if STRUCTS.includes? self.full_name
    return false if any? { |item| item.is_a?(CVariable) && %w[String std::string].includes?(item.type.full_name) }
    any? { |item| item.is_a?(CVariable) && item.visibility.public? }
  end
  def module? : Bool
    return true if MODULE_CLASSES.includes? self.full_name
    !items.empty? && none? { |item|
      item.is_a?(CFunction) && !item.static? || item.is_a?(CVariable) && item.visibility.public?
    }
  end
  def class? : Bool
    !struct? && !module?
  end

  def abstract? : Bool
    (!!union? || any? { |item|
      item.is_a?(CFunction) && item.abstract?
    })
  end

  def has_module?(mod : String) : Bool
    cls = self
    while cls.is_a? CClass
      return true if cls.inherited_modules.includes? mod
      cls = cls.inherited_class
    end
    false
  end
end

class CNativeType
  def initialize(@name : String)
  end

  def name(context : Context) : String
    c_type = cl_type = @name.not_nil!
    cr_type = c_type.gsub('<', '(').gsub('>', ')')
    case c_type
    when "std::string"
      c_type = "char*"
      cl_type = "LibC::Char*"
      cr_type = "String"
    when "String"
      c_type = "Uint32*"
      cl_type = "Char*"
    when /\bstd::vector<(.+)>/
      if $1 == "std::string"
        c_type = "char**"
        cl_type = "LibC::Char**"
        cr_type = "Array(String)"
      else
        c_type = "void*"
        cl_type = "Void*"
        cr_type = "Array(#{$1})"
      end
    when "std::size_t"
      c_type = "std::size_t"
      cl_type = cr_type = "LibC::SizeT"
    when /^(unsigned )?(int|short)$/
      u = "U" if $1?
      cl_type = "LibC::#{u}#{$2.capitalize}"
      cr_type = "#{u}" + {"int" => "Int32", "short" => "Int16"}[$2]
    when /^(Int|Uint)[0-9]+$/
      cl_type = cr_type = cl_type.sub("int", "Int")
    when "float", "double", "char"
      cl_type = "LibC::#{cl_type.capitalize}"
      cr_type = {"float" => "Float32", "double" => "Float64", "char" => "UInt8"}[c_type]
    when "bool"
      c_type = "Int8"
      cr_type = cl_type = "Bool"
    when "void"
      cr_type = cl_type = "Void"
    end
    case context
    when .crystal?
      cr_type
    when .crystal_lib?
      cl_type
    when .c_header?
      c_type
    else
      @name.not_nil!
    end
  end
  def full_name(context = Context::CPPSource) : String
    name(context)
  end
end

class CEnumMember < CItem
  def initialize(name : String, @value : String?, *args, **kwargs)
    super(name, *args, **kwargs)
  end

  def name(context : Context) : String
    @name.not_nil!
  end

  def value(context = Context::CPPSource) : String?
    @value
  end

  def render(context : Context, out o : Output)
    line = name(context)
    if @value
      line += " = #{value(context)}"
    end
    o<< line
  end
end

class CEnum < CNamespace
  getter members = [] of CEnumMember

  def initialize(name : String?, *args, **kwargs)
    super(name, *args, **kwargs)
  end

  def add(member : CEnumMember)
    members << member
  end

  def render(context : Context, out o : Output)
    return if visibility.private?
    union_enum = (parent.as?(CClass).try &.union?)
    if context.crystal?
      if @name
        render_docs(o, qualname)
        if members.map(&.value).compact.any?(&.includes? "<<")
          o<< "@[Flags]"
        end
        o<< "enum #{name(context)}"
      end
      members.each do |member|
        next if member.name(Context::Crystal) == "None" && member.value == "0"
        member.render_docs(o, qualname + "::" + member.name(Context::Crystal))
        member.render(context, o)
      end
      if @name
        o<< "end"
        unless full_name == "Style" || union_enum
          o<< "Util.extract #{full_name(context)}"
        end
      end
    end
  end
end

class CParameter
  def initialize(@name : String, @type : CType, @default : String? = nil)
  end

  property name : String
  property type : CType
  property default : String?

  def name(context : Context) : String
    context.cpp_source? ? @name : @name.underscore.sub(/^(the|mode)_/, "")
  end
end

class CFunction < CItem
  def initialize(name : String, @type : CType?, @parameters : Array(CParameter),
                 @static : Bool = false, is_abstract : Bool = false, @const : Bool = false, *args, **kwargs)
    @abstract = is_abstract
    super(name.gsub(/\b \B/, ""), *args, **kwargs)
  end

  getter type : CType?
  getter parameters : Array(CParameter)
  getter? static : Bool
  getter? abstract : Bool
  getter? const : Bool

  def name(context : Context, parent : CNamespace? = @parent) : String
    name = @name.not_nil!
    name = name.underscore unless context.cpp_source?
    unless context.cpp_source?
      name = operator_name || constructor_name || destructor_name || name
    end
    if context.crystal?
      name = getter_name || setter_name || name
      name = {
        "to_string" => "to_s",
        ">>" => "read",
        "<<" => "write",
        "BoolType" => "valid?",
      }.fetch(name, name)
    end
    if context.crystal_lib?
      if operator?
        name = "operator_" + {
          "==" => "eq", "!=" => "ne",
          "<" => "lt", ">" => "gt",
          "<=" => "le", ">=" => "ge",
          "+" => "add", "-" => "sub", "*" => "mul", "/" => "div", "%" => "mod",
          "[]" => "index", "[]=" => "indexset",
          "<<" => "shl", ">>" => "shr",
          "BoolType" => "bool",
        }[name]
      else
        name = name.gsub "_", ""
      end
      if parent
        parent_name = parent.full_name(context).not_nil!
        name = parent_name.downcase + "_" + name
      end
      name = PREFIX + name
      hash = parameters.map { |param|
        identifier_hash(param.type.full_name)
      } .join
      name += "_#{hash}" unless hash.empty? || @name == "parent"
    end
    name
  end

  def qualname(parent : CNamespace? = @parent) : String
    parts = [parent.try(&.qualname) || "SF", name(Context::Crystal)]
    parts.compact.join(static? ? "." : "#")
  end

  def getter_name : String?
    name = @name.not_nil!.underscore
    case name
    when .starts_with? "get_"
      parameters.size == 0 ? name[4..-1] : name
    when .starts_with? "is_"
      name[3..-1] + "?"
    when .starts_with? "has_"
      name[4..-1] + "?"
    else
      nil
    end
  end

  def setter_name : String?
    return nil if parameters.size > 1
    name = @name.not_nil!.underscore
    if name.starts_with? "set_"
      name[4..-1] + "="
    end
  end

  def operator_name : String?
    if @name =~ /operator\b *(.+)/
      $1
    end
  end
  def operator? : Bool
    !!operator_name
  end

  private def constructor_name : String?
    if @name == parent.try &.name(Context::CPPSource)
      "initialize"
    end
  end
  def constructor?
    !!constructor_name
  end

  private def destructor_name : String?
    if @name == "~#{parent.try &.name(Context::CPPSource)}"
      "finalize"
    end
  end
  def destructor?
    !!destructor_name
  end

  def reference_getter? : CType?
    if (typ = self.type) && typ.type.as?(CClass).try &.class? && (typ.reference? && !typ.const? || typ.pointer > 0) && getter_name
      typ
    end
  end
  def const_reference_getter? : CType?
    if (typ = self.type) && typ.type.as?(CClass).try &.class? && (typ.reference? && typ.const?) && getter_name
      typ
    end
  end
  def reference_setter? : CType?
    if @name.not_nil!.underscore.starts_with?("set_") && !parameters.empty?
      typ = parameters[0].type
      if typ.type.as?(CClass).try &.class? || typ.type.is_a?(CClass) && typ.pointer > 0
        typ
      end
    end
  end
  def reference_var : String?
    name = if reference_setter?
      @name.not_nil!.underscore[4..-1]
    elsif reference_getter?
      getter_name
    else
      return
    end
    "@_#{parent.try &.full_name(Context::CrystalLib).not_nil!.downcase}_#{name}"
  end

  def render(context : Context, out o : Output, parent : CNamespace? = self.parent)
    cls = parent.as? CClass

    return if visibility.private?
    return if context.crystal? && {"allocate", "free", "parent"}.includes? @name
    return unless visibility.public? || (cls && (cls.abstract? || %w[SoundStream SoundRecorder].includes?(cls.inherited_class.try &.full_name)) && cls.class?) || constructor?
    if (operator_name || "").downcase.starts_with?("bool")
      @type = make_type("bool", nil)
    else
      return if (operator_name.try &.=~ %r(^([+\-*/%]?=|[a-zA-Z:]+)$))
    end
    return if @docs[0]? == "\\brief Copy constructor"
    if parameters.any? { |param| param.type.full_name =~ /^[A-Z]$/ }
      return unless parameters.map(&.name) == ["function", "argument"]
    end
    return if @name.try &.starts_with? "setUniform"

    cr_params = [] of String
    cr_args = [] of String
    cl_params = [] of String
    c_params = [] of String
    cpp_args = [] of String
    if !static? && cls
      c_params << "void* self"
      cl_params << "self : Void*"
      cr_args << "to_unsafe"
    end
    if cls
      if destructor? && cls.module?
        return
      end
      name = cls.full_name
      name = "_#{name}" if cls.abstract? && cls.class?
      if constructor?
        if (cls.module? || cls.union?)
          return
        end
        cpp_obj = "new(self) #{name}".sub /[A-Z]\w*$/, ""  # avoid name duplication
      elsif static?
        cpp_obj = "#{name}::"
      else
        cpp_obj = "((#{name}*)self)->"
      end
    end

    if operator_name == "[]" && !self.type.try &.const?
      @name = "operator []="
      @parameters << CParameter.new("value", CType.new(self.type.not_nil!.type))
      @type = nil
    end
    if %w[<< >>].includes? operator_name
      @type = nil
      if parameters.any? { |param| %w[char String].includes? param.type.full_name(Context::CPPSource) }
        return
      end
    end

    return_params = [] of CParameter
    extra_return_params = [] of CParameter
    if (type = self.type)
      extra = (type.reference? && type.const? && type.type.as?(CClass).try &.class? ? 1 : 0)
      type = CType.new(type: type.type, reference: type.reference?,
                       pointer: type.pointer + extra, const: type.const?)
      return_params << CParameter.new("result", type)
      cpp_asgn = "*(#{type.type.full_name}#{"*"*type.pointer}*)result = "

      if type.full_name(Context::CPPSource).starts_with?("std::vector<")
        extra_return_params << CParameter.new("result_size", make_type("std::size_t*", nil))
      end
    end

    parameters.each do |param|
      if ((param.type.reference? || param.type.pointer > 0) && !param.type.const? && !getter_name && !(param.type.type.as?(CClass).try &.class?) &&
          (!param.name.ends_with?('s') || param.name.ends_with?("ss")) && param.name(Context::Crystal) !~ /stream$|^packet$/)
        if param.type.full_name != "void*" && docs.none? &.=~ /#{param.name}.+\bfill\b/
          return_params << param
        end
      end
    end

    conversions = [] of String
    ((parameters + return_params).uniq).each_with_index do |param, param_i|
      type = param.type.type
      c_type = type.full_name(Context::CHeader)
      cl_type = type.full_name(Context::CrystalLib)
      cr_type = type.full_name(Context::Crystal)
      cr_arg = param.name(Context::Crystal)
      cpp_arg = param.name(Context::CrystalLib)
      cr_param = nil
      case type.full_name(Context::CPPSource)
      when "std::string"
        unless return_params.includes? param
          c_params << "std::size_t #{param.name(Context::CrystalLib)}_size"
          cl_params << "#{param.name(Context::CrystalLib)}_size : LibC::SizeT"
          cr_arg = "#{cr_arg}.bytesize, #{cr_arg}"
          cpp_arg = "std::string(#{cpp_arg}, #{cpp_arg}_size)"
        end
      when "String"
        unless return_params.includes? param
          c_params << "std::size_t #{param.name(Context::CrystalLib)}_size"
          cl_params << "#{param.name(Context::CrystalLib)}_size : LibC::SizeT"
          cr_arg = "#{cr_arg}.size, #{cr_arg}.chars"
          cpp_arg = "String::fromUtf32(#{cpp_arg}, #{cpp_arg}+#{cpp_arg}_size)"
        end
      when "void"
        cl_type = cr_type = "UInt8" unless param.name == "parent"
      when "CurrentTextureType"
        cl_type = c_type = cr_arg = nil
        cpp_arg = "Shader::CurrentTexture"
      when "SoundStream::Chunk"
        if param.type.reference?
          return_params << param
          next
        end
      when .includes? ")(" # function pointer
        return
      when "GlFunctionPointer"
        return
      when "wchar_t", "std::wstring", "std::ostream"
        return
      when "char"
        if param.type.pointer > 0
          cr_type = "String"
        end
      else
        if type.full_name(Context::CPPSource) == "bool" && !return_params.includes? param
          cpp_arg = "#{cpp_arg} != 0"
        elsif %w[std::size_t Int64 Uint64].includes?(type.full_name(Context::CPPSource)) && (
          (param.name(Context::Crystal).ends_with?("_count") && cr_args[-1].starts_with?(cr_arg[0...4])) ||
          (param.name(Context::Crystal) == "size" || param.name(Context::Crystal) == "size_in_bytes")
        )
          cr_params.pop
          prev_param = parameters[param_i-1]
          typ = prev_param.type.full_name(Context::Crystal)
          if typ == "Void"
            typ = "Slice"
            cr_arg = "#{cr_args[-1]}.bytesize"
          else
            typ = "Array(#{typ}) | Slice(#{typ})"
            cr_arg = "#{cr_args[-1]}.size"
          end
          cr_param = "#{prev_param.name(Context::Crystal)} : #{typ}"
        elsif {type.full_name(Context::CPPSource), param.name} == {"A", "argument"}
          prev_param = parameters[param_i-1]
          c_params[-1] = "void (*#{prev_param.name(Context::CPPSource)})(void*)"
          cl_params[-1] = "#{prev_param.name(Context::CrystalLib)} : (Void*)->"
          c_type = "void*"
          cl_type = "Void*"
          cpp_args[-1] = prev_param.name(Context::CPPSource)
          conversions << "@#{prev_param.name(Context::Crystal)} = Box.box(#{prev_param.name(Context::Crystal)})"
          cr_params.pop
          cr_param = "#{prev_param.name(Context::Crystal)} : ->"
          cr_args[-1] = "->(#{param.name(Context::Crystal)}) { Box(->).unbox(#{param.name(Context::Crystal)}).call }"
          cr_arg = "@#{prev_param.name(Context::Crystal)}"
        elsif type.is_a? CClass
          if return_params.includes?(param) || param.type.pointer > 0
            c_type = "void"; cl_type = "Void"
          else
            if type.full_name(Context::CPPSource) =~ /^Vector2([fiu])$/
              cr_type = "Vector2|Tuple"
              conversions << "#{cr_arg} = SF.vector2#{$1}(#{cr_arg}[0], #{cr_arg}[1])" if context.crystal?
            end
            c_type = "void*"; cl_type = "Void*"
          end
          extra = "*" if param.type.reference? || !type.class? || param.type.const?
          cpp_arg = "(#{"_" if type.abstract? && constructor?}#{type.full_name}#{"*"*param.type.pointer}#{"*" unless param.type.pointer > 0})#{cpp_arg}"
          cpp_arg = "#{extra unless param.type.pointer > 0}#{cpp_arg}"
          cr_type += "?" if type.class? && param.type.pointer > 0
        elsif type.is_a? CEnum
          c_type = "int"; cl_type = "LibC::Int"
          cpp_arg = "(#{type.full_name})#{cpp_arg}"
        else
          unless param.type.pointer > 0 || param.type.reference? || operator_name == "<<"
            if cr_type.includes? "Float"
              cr_type = "Number"
              cr_arg = "#{type.full_name(Context::CrystalLib)}.new(#{cr_arg})"
            elsif cr_type.includes?("Int") || cr_type == "LibC::SizeT"
              if cr_type == "UInt32" && cr_arg == "style"
                cls_name = cls.not_nil!.full_name
                cr_type = cls_name.includes?("Window") ? "Style" : "#{cls_name}::Style"
              elsif cr_type == "UInt32" && cr_arg == "attributes"
                cr_type = "Attribute"
              else
                cr_type = "Int"
                cr_arg = "#{type.full_name(Context::CrystalLib)}.new(#{cr_arg})"
              end
            end
          else
            cr_type += "*"*param.type.pointer
          end
          if return_params.includes? param
            cpp_arg = "*#{cpp_arg}"
          end
        end
      end

      if c_type
        ptr = "*" * (param.type.pointer + (return_params.includes?(param) ? 1 : 0))
        c_params << "#{c_type}#{ptr} #{param.name(Context::CrystalLib)}"
        cl_params << "#{param.name(Context::CrystalLib)} : #{cl_type}#{ptr}"
      end

      if default = param.default
        default = default.gsub("(", ".new(").gsub(/\bVector2.\b/, "Vector2")
        default = " = #{default}"
      end
      unless return_params.includes?(param)
        cr_params << (cr_param || "#{param.name(Context::Crystal)} : #{cr_type}#{default}")
      end

      unless return_params.includes?(param) && param.name == "result"
        cpp_args << cpp_arg
      end

      if cr_arg
        if return_params.includes? param
          unless type.is_a?(CClass) && !(param.type.reference? && param.type.const? && type.class?)
            cr_arg = "out #{param.name(Context::Crystal)}" if return_params.includes? param
          end
        end
        cr_args << cr_arg
      end
    end

    extra_return_params.each do |param|
      cr_args << "out #{param.name(Context::Crystal)}"
      cl_params << "#{param.name(Context::CrystalLib)} : #{param.type.full_name(Context::CrystalLib)}#{"*"*param.type.pointer}"
      c_params << "#{param.type.full_name(Context::CHeader)}#{"*"*param.type.pointer} #{param.name(Context::CrystalLib)}"
    end

    if cr_params.includes? "drawable : Drawable"
      return
    end

    if !context.crystal?
      unless cls && cls.abstract? && cls.class? || visibility.public?
        return
      end
      return if abstract?
    end

    if context.crystal?
      if operator? && !cls
        if (cls = parameters[0].type.type.as? CClass)
          cr_params.delete_at 0
          cr_args[0] = "to_unsafe"
        end
      end

      ret_types = return_params.map { |param|
        if param.type.type.is_a?(CClass)
          suffix = "?" if param.type.pointer == 1 && !const_reference_getter?
        else
          suffix = "*"*param.type.pointer
        end
        name = param.type.full_name(Context::Crystal)
        if name == "SoundStream::Chunk"
          name = "Slice(Int16)"
        end
        if ["unsigned int", "std::size_t"].includes?(param.type.full_name(Context::CPPSource))
          name = "Int32" unless param.name(Context::Crystal).includes?("handle")
        end
        "#{name}#{suffix}"
      }
      if return_params.size == 2 && return_params[0].type.full_name == "bool"
        ret_types = [ret_types[1] + "?"]
      end
      unless ret_types.empty?
        ret = ret_types.join(", ")
        ret = "{#{ret}}" if ret_types.size > 1
        ret = " : #{ret}"
      end
      func_name = name(context, parent: parent)
      abstr = "protected " if visibility.protected? && constructor?
      abstr = "abstract " if abstract? #if cls.try &.module? && !static?
      if operator_name == ">>"
        cr_params << "type : #{return_params[0].type.full_name(Context::Crystal)}.class"
      end

      render_docs(o, "#{qualname(parent || cls)}(#{cr_params.map(&.split(" : ")[0]).join(",")})")
      o<< "#{abstr}def #{"self." if static?}#{func_name}(#{cr_params.join(", ")})#{ret}"

      return if abstract?
      unless cls && cls.abstract? && cls.class? || visibility.public? || name(Context::Crystal) == "initialize"
        if ret_types.size == 1
          case ret_types[0]
          when .ends_with? "?"
            o<< "nil"
          when "Bool"
            o<< "false"
          when .starts_with? "Int"
            o<< "#{ret_types[0]}.zero"
          end
        end
        o<< "end"
        return true
      end

      if (typ = reference_getter?)
        if typ.pointer > 0
          o<< "return #{reference_var}"
          o<< "end"
          return
        end
      elsif reference_setter?
        o<< "#{reference_var} = #{parameters[0].name(Context::Crystal)}"
      end

      if (constructor? || name(Context::Crystal) == "initialize") && (cls = parent.as? CClass)
        if cls.class?
          o<< "#{LIB_NAME}.#{CFunction.new("allocate", parent: cls, type: nil, parameters: [] of CParameter).name(Context::CrystalLib)}(out @this)"
          cls.each do |func|
            next unless func.is_a?(CFunction) && !func.visibility.private?
            if func.reference_setter?
              parameters.each do |param|
                if func.name(Context::CPPSource).downcase == "set" + param.name(Context::CPPSource).downcase
                  o<< "#{func.reference_var} = #{param.name(Context::Crystal)}"
                end
              end
            end
          end
          if !constructor?
            o<< "#{LIB_NAME}.#{CFunction.new("initialize", parent: cls, type: nil, parameters: [] of CParameter).name(Context::CrystalLib)}(to_unsafe)"
          end
        elsif cls.struct?
          cls.items.each do |item|
            if item.is_a?(CVariable)
              typ = item.type.full_name(context)
              typ = "Void*" if item.type.pointer > 0
              typ += "[#{item.type.array}]" if item.type.array != 1
              o<< "@#{item.name(context)} = uninitialized #{typ}"
            end
          end
        end

        (parameters - return_params).each do |param|
          name = param.name(Context::Crystal)
          if param.type.type.is_a?(CClass) && (param.type.type.as(CClass).class? && cls.any? { |item|
            (item.is_a?(CFunction) && item.reference_var == name)
          } || param.type.pointer > 0)
            o<< "@_#{parent.not_nil!.full_name(Context::CrystalLib).not_nil!.downcase}_#{name} = #{name}"
          end
        end
      else
        return_params.each_with_index do |param, i|
          type = param.type.type
          if type.is_a? CClass
            type = type.full_name(context)
            if type == "Event"
              o<< "#{LIB_NAME}.#{PREFIX}event_allocate(out #{param.name(context)})"
            else
              unless const_reference_getter?
                if parameters.includes?(param)
                  o<< "#{param.name(context)} = #{type}.new"
                else
                  if param.type.type.as(CClass).class?
                    o<< "#{param.name(context)} = #{type}.new"
                  else
                    o<< "#{param.name(context)} = #{type}.allocate"
                  end
                end
              end
            end
          end
        end
      end

      conversions.each do |s|
        o<< s
      end

      if parent.as?(CClass).try &.struct? && @name.try &.starts_with?("set_") && cr_args.size == 2
        o<< "@#{setter_name.not_nil![0...-1]} = #{cr_args[-1]}#{" ? #{cr_args[-1]}.to_unsafe : Pointer(Void).null" if reference_setter?}"
      else
        o<< "#{LIB_NAME}.#{name(Context::CrystalLib, parent: parent)}(#{cr_args.join(", ")})"
        if destructor?
          o<< "#{LIB_NAME}.#{CFunction.new("free", parent: parent, type: nil, parameters: [] of CParameter).name(Context::CrystalLib)}(@this)"
        end
      end
      if return_params[-1]?.try &.type.type.full_name == "Event"
        union_var = CType.all["Event"].as(CClass).union?.not_nil!
        o<< "if result"
        o<< "case (event_id = event.as(#{union_var.type.full_name(context)}*).value)"
        union_var.type.type.as(CEnum).members[0...-1].each do |m|
          o<< "when .#{m.name(context).underscore}?"
          o<< "event.as(Event::#{m.name(context)}*).value"
        end
        o<< "else"
        o<< "raise \"Unknown SFML event ID \#{event_id.value}\""
        o<< "end"
        o<< "end"
        return_params.clear
      end

      if (constructor? || name(Context::Crystal) == "initialize") && cls && cls.abstract? && cls.class?
        o<< "#{LIB_NAME}.#{CFunction.new("parent", parent: cls, type: nil, parameters: [] of CParameter).name(Context::CrystalLib)}(@this, self.as(Void*))"
      end

    elsif context.cpp_source?
      o<< "void #{name(Context::CrystalLib, parent: parent)}(#{c_params.join(", ")}) {"
      if context.cpp_source?
        cpp_call = if name(context).starts_with?("get_")
          "#{cpp_obj}#{name(context)[4..-1]}"
        elsif name(context).starts_with?("set_")
          "#{cpp_obj}#{name(context)[4..-1]} = #{cpp_args.join(", ")}"
        elsif operator_name == "[]="
          "#{cpp_obj}operator[](#{cpp_args[0]}) = #{cpp_args[1]}"
        elsif (operator_name || "").downcase.starts_with? "bool"
          "(bool)#{cpp_obj.not_nil![0...-2]}"
        elsif @name == "allocate"
          "malloc(sizeof(#{"_" if parent.as(CClass).abstract? && parent.as(CClass).class?}#{parent.as(CClass).full_name(context)}))"
        elsif @name == "free"
          "free(self)"
        elsif @name == "parent"
          "#{cpp_obj}parent = #{cpp_args.join(", ")}"
        elsif destructor? && parent.as?(CClass).try &.abstract?
          "#{cpp_obj}~_#{name(context)[1..-1]}(#{cpp_args.join(", ")})"
        else
          "#{cpp_obj}#{name(context)}(#{cpp_args.join(", ")})"
        end
        if !return_params.empty?
          type = self.type || return_params[0].type
          if type.full_name(context) == "String"
            o<< "static String str;"
            o<< "str = #{cpp_call};"
            cpp_asgn = "*result = "
            cpp_call = "const_cast<Uint32*>(str.getData())"
          elsif type.full_name(context) == "std::string"
            o<< "static std::string str;"
            if self.type
              o<< "str = #{cpp_call};"
            else
              cpp_call = cpp_call.sub(/\b#{return_params[0].name(Context::CrystalLib)}\b/, "str")
              o<< "#{cpp_call};"
            end
            cpp_asgn = "*#{return_params[0].name(Context::CrystalLib)} = "
            cpp_call = "const_cast<char*>(str.c_str())"
          elsif type.full_name(context) =~ /\bstd::vector<std::string>/
            o<< "static std::vector<std::string> strs;"
            o<< "static std::vector<char*> bufs;"
            o<< "strs = #{cpp_call};"
            o<< "bufs.resize(strs.size());"
            o<< "for (std::size_t i = 0; i < strs.size(); ++i) bufs[i] = const_cast<char*>(strs[i].c_str());"
            o<< "*result_size = bufs.size();"
            cpp_asgn, cpp_call = "*result = ", "&bufs[0]"
          elsif type.full_name(context) =~ /\b(std::vector<.+>)/
            o<< "static #{$1} objs;"
            o<< "objs = const_cast<#{$1}&>(#{cpp_call});"
            o<< "*result_size = objs.size();"
            cpp_asgn, cpp_call = "*result = ", "&objs[0]"
          elsif type.const? && type.pointer > 0
            cast = CType.new(type.type, reference: false, pointer: type.pointer, const: false)
            cpp_call = "const_cast<#{cast.full_name}>(#{cpp_call})"
          elsif type.const? && type.reference? && type.type.as?(CClass).try &.class?
            cast = CType.new(type.type, reference: false, pointer: type.pointer + 1, const: false)
            cpp_call = "const_cast<#{cast.full_name}>(&#{cpp_call})"
          elsif @name == "allocate"
            cpp_asgn = "*result = "
          end
        end
        o<< "#{cpp_asgn}#{cpp_call};"
      end
    elsif context.crystal_lib?
      o<< "fun #{name(Context::CrystalLib, parent: parent)}(#{cl_params.join(", ")})"
    end
    if context.crystal?
      if operator_name == "<<"
        o<< "self"
      end
      unless return_params.empty?
        o<< "return " + return_params.map { |param|
          name = param.name(context)
          typ = param.type.type.full_name(Context::CPPSource)
          if typ == "String"
            "String.build { |io| while (v = #{name}.value) != '\\0'; io << v; #{name} += 1; end }"
          elsif typ == "std::string"
            "String.new(#{name})"
          elsif typ =~ /\bstd::vector<std::string>/
            "Array.new(#{name}_size.to_i) { |i| String.new(#{name}[i]) }"
          elsif typ =~ /\bstd::vector<(.+)>/
            "Array.new(#{name}_size.to_i) { |i| #{name}.as(#{$1}*)[i] }"
          elsif typ == "unsigned int" || typ == "std::size_t"
            "#{name}.to_i"
          elsif param.type.type.as?(CClass).try &.class? && const_reference_getter?
            "#{param.type.full_name(Context::Crystal)}::Reference.new(#{name}, self)"
          elsif param.type.type.is_a? CEnum
            "#{param.type.full_name(Context::Crystal)}.new(#{name})"
          else
            name
          end
        } .join(", ")
      end
      o<< "end"

      if name(Context::Crystal) =~ /^([a-z]+_(from_.+)|create|(open))$/
        full = $1
        short = $2? || $3? || "new"
        cls_name = cls.not_nil!.name(context).not_nil!
        obj_name = cls_name.underscore
        o<< "# Shorthand for `#{obj_name} = #{cls_name}.new; #{obj_name}.#{full}(...); #{obj_name}`"
        if self.type.try &.type.full_name == "bool"
          o<< "#"
          o<< "# Raises `InitError` on failure"
        end
        o<< "def self.#{short}(*args, **kwargs) : self"
        call = "obj.#{full}(*args, **kwargs)"
        o<< "obj = new"
        if self.type.try &.type.full_name == "bool"
          o<< "if !#{call}"
          o<< "raise InitError.new(\"#{cls_name}.#{full} failed\")"
          o<< "end"
        else
          o<< call
        end
        o<< "obj"
        o<< "end"
      end

      if reference_var && !parent.as?(CClass).try &.module?
        o<< "#{reference_var} : #{(reference_getter? || reference_setter?).not_nil!.full_name(Context::Crystal)}? = nil"
      end

    elsif context.cpp_source?
      o<< "}"
    end
    true
  end
end

class CVariable < CItem
  def initialize(name : String, @type : CType, *args, **kwargs)
    super(name, *args, **kwargs)
  end

  def name(context : Context)
    name = @name.not_nil!
    unless context.cpp_source?
      name = name.underscore
    end
    if name.starts_with?("m_")
      name = name[2..-1]
    end
    name
  end

  def qualname : String
    parts = [parent.try(&.qualname) || "SF", name(Context::Crystal)]
    parts.compact.join("#")
  end

  getter type : CType

  def render(context : Context, out o : Output, var_only = false)
    (parent = self.parent)
    return unless parent.is_a?(CClass)
    var_name = name(Context::Crystal)
    if parent.struct?
      if context.crystal?
        typ = type.type.is_a?(CNativeType) ? type.full_name(Context::CrystalLib) : type.full_name(context)
        typ = "Void*" if type.pointer > 0
        typ += "[#{type.array}]" if type.array != 1
        o<< "@#{var_name} : #{typ}"
      end
    end
    return if var_only
    return unless visibility.public?
    if parent.struct?
      if context.crystal?
        render_docs(o, qualname + "()")
        o<< "def #{var_name} : #{type.full_name(context)}#{"?" if type.pointer > 0}"
        name = var_name
        if type.pointer > 0
          name = "_#{parent.as(CClass).full_name(Context::CrystalLib).not_nil!.downcase}_#{var_name}"
        end
        o<< "@#{name}"
        o<< "end"
      end
    else
      CFunction.new("get_#{@name}",
        type: type,
        parameters: [] of CParameter,
        visibility: visibility, parent: parent, docs: docs
      ).render(context, o)
    end
    CFunction.new("set_#{@name}",
      type: nil,
      parameters: [CParameter.new(@name.not_nil!, type)],
      visibility: visibility, parent: parent
    ).render(context, o)
  end
end

class CModule < CNamespace
  getter dependencies = [] of String
  @done_files = Set(String).new

  class_getter docs = {} of String => Array(String)

  def initialize(@name : String)
    @parent = nil

    read_docs(name, CModule.docs)

    process_file "#{name}.hpp"
  end

  def name : String
    @name.not_nil!
  end

  def sfmodule : CModule
    self
  end

  def render(context : Context, out o : Output)
    case context
    when .cpp_source?
      o<< "#include <SFML/#{name}.hpp>"
      dependencies.each do |dep|
        o<< "#include <SFML/#{dep}.hpp>"
      end
      o<< "using namespace sf;"
      o<< "extern \"C\" {"
    when .crystal_lib?
      o<< "require \"../common\""
      dependencies.each do |dep|
        o<< "require \"../#{dep.downcase}/lib\""
      end
      o<< "\{% unless flag?(:win32) %}"
      o<< "@[Link(\"stdc++\")]"
      o<< "\{% end %}"
      o<< "@[Link(\"sfml-#{name.downcase}\")]"
      o<< "\{% if flag?(:win32) %}"
      o<< %q(@[Link(ldflags: "\"#{__DIR__}\\ext.obj\"")])
      o<< "\{% else %}"
      o<< %q(@[Link(ldflags: "'#{__DIR__}/ext.o'")])
      o<< "\{% end %}"
      o<< "lib #{LIB_NAME}"
    when .crystal?
      o<< "require \"./lib\""
      o<< "require \"../common\""
      dependencies.each do |dep|
        o<< "require \"../#{dep.downcase}\""
      end
      o<< "module SF"
      o<< "extend self"
    end

    each &.render(context, o)

    case context
    when .crystal?
      o<< "#{LIB_NAME}.#{PREFIX}#{name.downcase}_version(out major, out minor, out patch)"
      o<< %q(if SFML_VERSION != (ver = "#{major}.#{minor}.#{patch}"))
      o<< %q(STDERR.puts "Warning: CrSFML was built for SFML #{SFML_VERSION}, found SFML #{ver}")
      o<< %q(end)
      o<< "end"
    when .crystal_lib?
      o<< "fun #{PREFIX}#{name.downcase}_version(LibC::Int*, LibC::Int*, LibC::Int*)"
      o<< "end"
    when    .cpp_source?
      o<< "void #{PREFIX}#{name.downcase}_version(int* major, int* minor, int* patch) {"
      o<< "*major = SFML_VERSION_MAJOR;"
      o<< "*minor = SFML_VERSION_MINOR;"
      o<< "*patch = SFML_VERSION_PATCH;"
      o<< "}"
      o<< "}"
    end
  end

  macro common_info
    %docs = docs_buffer
    docs_buffer = [] of String
    {parent: parent, visibility: visibility, docs: %docs, sfmodule: self}
  end

  private def process_file(file_name : String)
    return if @done_files.includes? file_name
    @done_files.add file_name

    docs_buffer = [] of String
    upcoming_namespace = nil
    first_class = nil
    visibilities = {} of CClass => Visibility
    stack = [] of CNamespace?

    prev_line = ""
    buf = ""
    File.each_line("#{SFML_PATH}/#{file_name}") do |line|
      line = (buf + line).strip

      if line =~ %r(^////+$) && prev_line !~ %r(^///)
        docs_buffer.clear
      end

      line = line.sub %r( ?\bSFML_(\w+_API|DEPRECATED) ), " "

      if line =~ /^[^\/]*[^\)],$/  # multiline function definition
        buf = line + " "
        next
      else
        buf = ""
      end

      parent = stack.compact.last?
      if parent.is_a? CClass
        visibility = visibilities[parent]
      else
        visibility = Visibility::Public
      end

      if (enu = stack.last?).is_a? CEnum
        if line =~ %r(^(\w+)( *= *([^,/]+))?,?( +///< (.+))?$)
          member = CEnumMember.new($1, value: $3?,
                                   parent: enu, docs: [$5?].compact)
          enu.add member
          next
        end
      end

      case line

      when %r(^#include <SFML/(#{@name}/\w+\.hpp)>$)
        process_file $1
      when %r(^#include <SFML/(\w+)(/\w+)?\.hpp>$)
        @dependencies |= [$1] unless $1 == "Config"

      when %r(^///( (.+))?$)
        docs_buffer << ($2? || "")

      when /^(class|struct) ((\w|(<.+?>))+);$/
        class_name = $2
        register_type CClass.new(class_name, visibility: Visibility::Private) unless CType.all.has_key? class_name
        docs_buffer.clear
      when /^(class|struct) ((\w|(<.+?>))+)( : (.+))?$/
        class_name = $2
        inherited = ($6?.try &.split(',').map &.split.last) || [] of String
        cls = CClass.new(class_name, inherited, **common_info)
        unless class_name.includes?('<') || prev_line.includes?("template <")
          (parent || self) << cls
          register_type cls
        end
        upcoming_namespace = cls
        first_class ||= cls
        visibilities[cls] = ($1 == "struct" ? Visibility::Public : Visibility::Private)

      when "private:"
        visibilities[parent.as CClass] = Visibility::Private
      when "protected:"
        visibilities[parent.as CClass] = Visibility::Protected
      when "public:"
        visibilities[parent.as CClass] = Visibility::Public

      when /^enum( (\w+))?$/
        name = $2?
        if !name && file_name.includes? "WindowStyle"
          name = "Style"
        end
        enu = CEnum.new(name, **common_info)
        (parent || self) << enu
        register_type enu
        upcoming_namespace = enu

      when /^typedef /

      when /^(virtual|static|explicit)? *(([^\(]+) )??(operator *.+?|~?\w+)\((.*)\)( const)?( = 0)?(;| *:( .+\{\})?)$/
        match = $~
        func_params = match[5].scan(/
          (?:
            [^,()]+ | (
                        \( (?:
                             [^()]+ | (?1)
                           )* \)
                      )
          )+
        /x).map_with_index { |param_m, param_i|
          if param_m[0].strip =~ /^(.+?)(\b(\w+)\b( = (.+))?)?$/
            CParameter.new(type: make_type($1, parent),
                           name: $3? || "p#{param_i}",
                           default: $5?)
          end .not_nil!
        }
        if match[3]?
          func_type = make_type(match[3], parent)
          func_type = nil if func_type.void?
        end
        func = CFunction.new(**common_info,
                             type: func_type,
                             name: match[4],
                             parameters: func_params,
                             static: match[1]? == "static",
                             is_abstract: match[7]? != nil,
                             const: match[6]? != nil)
        if func.operator? && !parent.is_a? CClass
          parent = (func.parameters[0].type.type).as? CClass
          next if !parent
        end
        (parent || self) << func

      when %r(^([^\(\)\/;]+) ([a-z]\w*)(\[[0-9]+\])?;( +///< (.+))$)
        docs_buffer.clear
        var = CVariable.new(type: make_type("#{$1}#{$3?}", parent),
                            name: $2, parent: parent,
                            visibility: visibility, docs: [$5?].compact)
        (parent || self) << var

      when /\{$/
        docs_buffer.clear
        stack.push upcoming_namespace
        upcoming_namespace = nil
      when /^\}/
        docs_buffer.clear
        stack.pop
      end

      prev_line = line
    end

    if first_class
      docs_buffer.each do |line|
        first_class.docs << line unless line =~ /^\\class/
      end
    end
  end
end


class Output
  TAB = " "*4

  def initialize(@file : File)
    @indent = 0
  end

  def self.write(file_name : String)
    output = self.new(file = File.open(file_name, "w"))
    yield output
    file.close
  end

  def <<(line : String, lineno = __LINE__)
    tab = {% begin %}
      {{@type}}::TAB
    {% end %}
    comment = if DEBUG
      lineno ? "L#{lineno}" : nil
    else
      nil
    end
    transform line.strip, comment do |line|
      @file << tab*@indent << line << '\n'
    end
    self
  end

  def transform(line : String, comment : String? = nil)
    dedent if line.starts_with?('}') || line.ends_with?(':')
    comment = " "*{119 - line.size - TAB.size*@indent, 0}.max + " // " + comment if comment
    yield "#{line}#{comment}"
    indent if line.ends_with?('{') && !line.starts_with?("extern ") || line.ends_with?(':')
  end

  def indent(n = 1)
    @indent = {@indent + n, 0}.max
  end
  def dedent(n = 1)
    @indent = {@indent - n, 0}.max
  end

  def finalize
    @file.close
  end
end

class CrystalOutput < Output
  TAB = " "*2

  def transform(line : String, comment : String? = nil)
    dedent if line =~ /^(end|else|elsif|when)\b|^\}/
    comment = " "*{118 - line.size - TAB.size*@indent, 0}.max + "  # " + comment if comment
    yield "#{line}#{comment}"
    if line =~ /^((module|(abstract +)?(class|struct)|union|((private |protected +)?(def|macro|enum))|lib|case|if|elsif|unless|when) [^:].*|else|[^#]+(\b(begin|do)|\{))$/
      indent unless line.starts_with? '#'
    end
  end
end


modules = %w[System Window Graphics Audio Network].map { |m| CModule.new(m) }

modules.each do |mod|
  name = mod.name.downcase
  Context.values.each do |context|
    filename = case context
    when .c_header?
      next
    when .cpp_source?
      "src/#{name}/ext.cpp"
    when .crystal?
      "src/#{name}/obj.cr"
    when .crystal_lib?
      "src/#{name}/lib.cr"
    end.not_nil!
    Dir.mkdir_p File.dirname(filename)
    (context.cr? ? CrystalOutput : Output).write(filename) do |output|
      mod.render(context, output)
    end
  end
end

unless CModule.docs.empty? || SAVE_DOCS
  STDERR.puts "Failed to apply docs for:"
  CModule.docs.each do |name, docs|
    STDERR.puts name
  end
end

sfml_version = Hash(String, String).new
File.each_line(File.join(SFML_PATH, "Config.hpp")) do |line|
  if line =~ /^#define +SFML_VERSION_(\w+) +(\d+)$/
    sfml_version[$1] = $2
  end
end

crsfml_version = File.each_line(File.join(File.dirname(__FILE__), "shard.yml")) do |line|
  if line =~ /^version: +([\d.]+)$/
    break $1
  end
end .not_nil!

CrystalOutput.write("src/version.cr") do |o|
  o<< "module SF"
  o<< "VERSION = #{crsfml_version.inspect}"
  o<< "SFML_VERSION = \"#{sfml_version["MAJOR"]}.#{sfml_version["MINOR"]}.#{sfml_version["PATCH"]}\""
  o<< "end"
end

if (saved_docs = SAVE_DOCS)
  saved_docs.each do |mod, docs|
    write_docs(mod, docs)
  end
end

CRYSTAL ?= crystal
SFML_INCLUDE_DIR ?= /usr/include

shellquote = '$(subst ','"'"',$1)'

modules := system window graphics audio network

crystal_files := $(foreach module,$(modules),src/$(module)/obj.cr src/$(module)/lib.cr)
cpp_files := $(foreach module,$(modules),src/$(module)/ext.cpp)
obj_files := $(cpp_files:.cpp=.o)

.PHONY: all
all: $(crystal_files) $(obj_files)

$(crystal_files) $(cpp_files): generate.cr $(foreach module,$(modules),docs/$(module).diff)
	$(CRYSTAL) run generate.cr -- $(call shellquote,$(SFML_INCLUDE_DIR))

%.o: %.cpp
	$(CXX) -c -o $@ -Wno-deprecated-declarations -I $(call shellquote,$(SFML_INCLUDE_DIR)) $(CXXFLAGS) $<

.PHONY: clean
clean:
	rm -f $(obj_files)

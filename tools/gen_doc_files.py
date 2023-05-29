import os
import textwrap
import mkdocs_gen_files

root = mkdocs_gen_files.config["plugins"]["mkdocstrings"].get_handler("crystal").collector.root

nav = mkdocs_gen_files.open(f"api/README.md", "w")

for module in ["System", "Window", "Graphics", "Audio", "Network", ""]:
    if module:
        print(f"* [{module} module]({module.lower()}.md)", file=nav)

        with mkdocs_gen_files.open(f"api/{module.lower()}.md", "w") as f:
            f.write(textwrap.dedent(f"""
                # ::: SF
                    options:
                      file_filters:
                        - '/{module.lower()}/'
            """))

    for typ in root.lookup("SF").walk_types():
        [cur_module] = {os.path.dirname(os.path.relpath(loc.filename, "src")) for loc in typ.locations}
        if module.lower() == cur_module:
            name = typ.name
            full_name = typ.abs_id
            path = full_name.replace("::", "/")

            indent = bool(module) + full_name.count("::") - 1
            print("    " * indent + f"* [{name}]({path}.md)", file=nav)

            filename = f"api/{path}.md"
            with mkdocs_gen_files.open(filename, "w") as f:
                f.write(textwrap.dedent(f"""\
                    # ::: {full_name}
                """))

            if typ.locations:
                mkdocs_gen_files.set_edit_path(filename, typ.locations[0].url)

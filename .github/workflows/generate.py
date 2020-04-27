#!/usr/bin/env python

import glob
import os
import re
import shutil

import jinja2
import yaml


os.chdir(os.path.dirname(__file__))

for name in glob.glob("*.yml.mako"):
    basename = name.rsplit(".", 1)[0]

    tpl_loader = jinja2.FileSystemLoader(searchpath=".")
    tpl_env = jinja2.Environment(loader=tpl_loader, undefined=jinja2.StrictUndefined)
    outp = tpl_env.get_template(basename + ".jinja").render()

    outp = re.sub(r"( *\n)+", "\n", outp)
    outp = re.sub(r"(?<=\S) +", " ", outp)

    with open(basename + ".new", "w") as f:
        print(outp.strip(), file=f)

    obj = yaml.safe_load(outp)

    shutil.move(basename + ".new", basename)

#!/usr/bin/env crystal

require "ecr"
require "yaml"

outp = IO::Memory.new
outp = ECR.embed("#{__DIR__}/ci.yml.ecr", outp)
outp = outp.to_s
outp = outp.gsub(/ *\\\n/, "").gsub(/( *\n)+/, "\n").gsub(/(?<=\S) +/, " ")

File.write("#{__DIR__}/ci.yml.new", outp)

YAML.parse(outp)

File.rename("#{__DIR__}/ci.yml.new", "#{__DIR__}/ci.yml")

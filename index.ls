"use strict";

{docopt} = require('docopt')
require! 'fs'
require! 'path'

chalk = require('chalk')

doc = """
Usage:
    diff-files FILE1 FILE2 [ -m MSG ] [ -v ]
    diff-files -h | --help 

Options:
    -m , --message MSG      Print optional message when running the script
    -v , --verbose          Prefix messages with current dir
"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else 
        return o[b]

o = docopt(doc)

message = get-option('-m', '--message', '', o)
verbose = get-option('-v', '--verbose', false, o)


diff = require('diff')

f1 = fs.readFileSync(o['FILE1'], 'utf-8')
f2 = fs.readFileSync(o['FILE2'], 'utf-8')

v = diff.diffLines(f1, f2)

var prefix
prefix := path.basename(process.cwd()) if verbose
prefix ?= ""


if v.length == 1 and not v[0].count? and not v[0].added? and not v[0].removed?
    console.error "#prefix #message: " + chalk.green('OK')
else
    console.error "#prefix #message: " + chalk.red('FAIL')


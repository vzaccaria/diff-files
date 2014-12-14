
{docopt} = require('docopt')
require! 'fs'

chalk = require('chalk')

doc = """
Usage:
    diff-files FILE1 FILE2 [ -m MSG ]
    diff-files -h | --help 

Options:
    -m , --message MSG      Print optional message when running the script
"""

get-option = (a, b, def, o) ->
    if not o[a] and not o[b]
        return def
    else 
        return o[b]

o = docopt(doc)

message = get-option('-m', '--message', '', o)

diff = require('diff')

f1 = fs.readFileSync(o['FILE1'], 'utf-8')
f2 = fs.readFileSync(o['FILE2'], 'utf-8')

v = diff.diffLines(f1, f2)


if v.length == 1 and not v[0].count? and not v[0].added? and not v[0].removed?
    console.error "#message: " + chalk.green('OK')
else
    console.error "#message: " + chalk.red('FAIL')


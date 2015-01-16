"use strict"

require! 'fs'

{docopt} = require('docopt')
shelljs  = require('shelljs')
uid      = require('uid')

cwd = process.cwd()

_ = require('bluebird').promisifyAll(shelljs)

doc = shelljs.cat(__dirname+"/docs/usage.md")
opts = docopt(doc)

process.stdin.setEncoding('utf8');

chunks = ""

process.stdin.on 'readable', ->
    c = process.stdin.read()
    chunks := chunks + c if c?

process.stdin.on 'end', ->
    temp-dir = "#cwd/tmp-#{uid(8)}"
    console.log opts
    _.cp('-R', "#{opts['--template']}/*", temp-dir);
    console.log chunks
    chunks.to("#temp-dir/cookiecutter.json")

    _.execAsync("cookiecutter --no-input #{temp-dir}").then ->
        console.log "done."







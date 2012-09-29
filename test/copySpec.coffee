grunt = require 'grunt'
fs = require 'fs'
createFile = grunt.file.write
readFile = grunt.file.read

temp = './temp/'
from = "#{temp}from/"
to = "#{temp}to/"

module.exports =
	setUp: (callback) ->
		grunt.helper 'hustler delete', data: src: temp
		callback()
	tearDown: (callback) ->
		grunt.helper 'hustler delete', data: src: temp
		callback()
	'files': (test) ->
		test.expect 6

		createFile "#{from}a.coffee", 'a = 1'
		createFile "#{from}b.coffee", 'b = 2'

		test.equal true, fs.existsSync "#{from}a.coffee", 'should find a.coffee'
		test.equal true, fs.existsSync "#{from}b.coffee", 'should find b.coffee'

		grunt.helper 'hustler copy', data: src: from, dest: to

		aExpect = 'a = 1'
		aContents = readFile "#{to}a.coffee"
		bExpect = 'b = 2'
		bContents = readFile "#{to}b.coffee"

		test.equal true, fs.existsSync "#{to}a.coffee", 'should find a.coffee'
		test.equal true, fs.existsSync "#{to}b.coffee", 'should find b.coffee'
		test.equal aExpect, aContents, 'a.coffee contents should be same as original'
		test.equal bExpect, bContents, 'b.coffee contents should be same as original'
		test.done()
	'files concatenated': (test) ->
		test.expect 5

		createFile "#{from}a.coffee", 'a = 1'
		createFile "#{from}b.coffee", 'b = 2'

		test.equal true, fs.existsSync "#{from}a.coffee", 'should find a.coffee'
		test.equal true, fs.existsSync "#{from}b.coffee", 'should find b.coffee'

		src = ["#{from}a.coffee", "#{from}b.coffee"]
		dest = "#{to}concatenated.coffee"

		grunt.helper 'hustler copy', data: src: src, dest: dest, bare: true

		expect = "a = 1#{grunt.utils.linefeed}b = 2"
		contents = readFile dest

		test.equal false, fs.existsSync "#{to}a.coffee", 'should not find a.coffee'
		test.equal false, fs.existsSync "#{to}b.coffee", 'should not find b.coffee'
		test.equal expect, contents, 'concatenated.coffee should be concatenated content of a.coffee and b.coffee'
		test.done()
	'directory to directory': (test) ->
		test.expect 6

		createFile "#{from}a.coffee", 'a = 1'
		createFile "#{from}b.coffee", 'b = 2'

		test.equal true, fs.existsSync "#{from}a.coffee", 'should find a.coffee'
		test.equal true, fs.existsSync "#{from}b.coffee", 'should find b.coffee'

		grunt.helper 'hustler copy', data: src: from, dest: to

		aExpect = 'a = 1'
		aContents = readFile "#{to}a.coffee"
		bExpect = 'b = 2'
		bContents = readFile "#{to}b.coffee"

		test.equal true, fs.existsSync "#{to}a.coffee", 'should find a.coffee'
		test.equal true, fs.existsSync "#{to}b.coffee", 'should find b.coffee'
		test.equal aExpect, aContents, 'a.coffee contents should be same as original'
		test.equal bExpect, bContents, 'b.coffee contents should be same as original'
		test.done()
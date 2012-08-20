// Generated by CoffeeScript 1.3.3
/*global module, require
*/

module.exports = function(grunt) {
  var coffeeScript;
  coffeeScript = require('coffee-script');
  return grunt.registerMultiTask('coffee', 'Compile CoffeeScript to JavaScript', function() {
    var bare, dest, done, options, src, _ref;
    done = this.async();
    src = this.file.src;
    dest = this.file.dest;
    bare = (_ref = this.data.bare) != null ? _ref : false;
    options = ['"' + './node_modules/.bin/coffee' + '"', '--compile', bare ? '--bare' : void 0, '--output', dest, src];
    return grunt.helper('exec', "" + (options.join(' ')), true, true, function(err) {
      if (err) {
        grunt.log.write(err);
        return done(false);
      } else {
        return done(true);
      }
    });
  });
};

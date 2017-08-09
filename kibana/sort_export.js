var jsonfile = require('jsonfile');
jsonfile.spaces = 2;

var filename = 'export.json';

var arr = jsonfile.readFileSync(filename);

arr.sort(function(a, b) {
    var sa = a._type + a._source.title;
    var sb = b._type + b._source.title;
    return sa.localeCompare(sb);
});

jsonfile.writeFileSync(filename, arr);
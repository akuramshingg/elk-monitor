var jsonfile = require('jsonfile');
jsonfile.spaces = 2;

var filename = 'export.json';

if (process.argv.length > 2)
    filename = process.argv[2];

var arr = jsonfile.readFileSync(filename);

arr.sort(function(a, b) {
    var sa = a._type + a._source.title;
    var sb = b._type + b._source.title;
    return sa.localeCompare(sb);
});

jsonfile.writeFileSync(filename, arr);
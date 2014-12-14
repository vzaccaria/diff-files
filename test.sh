echo "Should be ok"
./index.js test/a test/a
./index.js test/b test/b
./index.js test/c test/c
echo "Should fail"
./index.js test/b test/a
./index.js test/a test/b
./index.js test/c test/a
./index.js test/a test/c
./index.js test/b test/a
./index.js test/a test/b


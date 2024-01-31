# use `nano makefile` to edit this file
# run `make`
# run `make [target name]` e.g., make run_test

target: print

print:
	echo "Makefile's working."

run_test:
	sh test/test.sh
	python test/test.py


run_test_mdb:
	sh test/test_mdb.sh
	python test/test_mdb.py

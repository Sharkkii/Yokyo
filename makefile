mul:
	xvlog --sv mul_testbench.sv mul.sv
	xelab -debug typical mul_testbench -s mul_testbench.sim
	xsim --runall mul_testbench.sim

div:
	xvlog --sv div_testbench.sv div.sv
	xelab -debug typical div_testbench -s div_testbench.sim
	xsim --runall div_testbench.sim
	
clean:
	rm -rf xsim.dir *.jou *.log *.pb *.sim.wdb
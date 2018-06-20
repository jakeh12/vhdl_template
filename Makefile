TOP=template_tb
STOP_TIME=1000ns
PREFIX=/usr/local/lib/ghdl
WORK_LIB=work
WORK_DIR=sim
SOURCES=$(wildcard src/*.vhd)
VCD=$(TOP).vcd
WAVE_APP=Scansion
MORE_FLAGS=#--disp-time

all:
	@mkdir -p sim
	@ghdl -i --PREFIX=$(PREFIX) --workdir=$(WORK_DIR) --work=$(WORK_LIB) $(SOURCES)
	@ghdl -a --PREFIX=$(PREFIX) --workdir=$(WORK_DIR) --work=$(WORK_LIB) $(SOURCES)
	@ghdl -r --PREFIX=$(PREFIX) --workdir=$(WORK_DIR) --work=$(WORK_LIB) $(TOP) $(MORE_FLAGS) --stop-time=$(STOP_TIME) --vcd=$(WORK_DIR)/$(VCD)
	@open -a $(WAVE_APP) $(WORK_DIR)/$(VCD)

clean:
	@ghdl --remove --PREFIX=$(PREFIX) --workdir=$(WORK_DIR) --work=$(WORK_LIB)
	rm -rf $(WORK_DIR)
	
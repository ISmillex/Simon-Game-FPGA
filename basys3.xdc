## Clock signal
set_property -dict { PACKAGE_PIN W5   IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports clk]

set_property PACKAGE_PIN R2 [get_ports reset]     
set_property IOSTANDARD LVCMOS33 [get_ports reset]


set_property -dict { PACKAGE_PIN U14   IOSTANDARD LVCMOS33 } [get_ports {led[0]}]
set_property -dict { PACKAGE_PIN V14   IOSTANDARD LVCMOS33 } [get_ports {led[1]}]
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports {led[2]}]
set_property -dict { PACKAGE_PIN V3    IOSTANDARD LVCMOS33 } [get_ports {led[3]}]

set_property -dict { PACKAGE_PIN P3   IOSTANDARD LVCMOS33 } [get_ports {control_led[0]}]
set_property -dict { PACKAGE_PIN N3   IOSTANDARD LVCMOS33 } [get_ports {control_led[1]}]
set_property -dict { PACKAGE_PIN P1   IOSTANDARD LVCMOS33 } [get_ports {control_led[2]}]
set_property -dict { PACKAGE_PIN L1    IOSTANDARD LVCMOS33 } [get_ports {control_led[3]}]

set_property -dict { PACKAGE_PIN U16   IOSTANDARD LVCMOS33 } [get_ports {state_led[0]}]
set_property -dict { PACKAGE_PIN E19   IOSTANDARD LVCMOS33 } [get_ports {state_led[1]}]
set_property -dict { PACKAGE_PIN U19   IOSTANDARD LVCMOS33 } [get_ports {state_led[2]}]
set_property -dict { PACKAGE_PIN V19    IOSTANDARD LVCMOS33 } [get_ports {state_led[3]}]
set_property -dict { PACKAGE_PIN W18    IOSTANDARD LVCMOS33 } [get_ports {state_led[4]}]
set_property -dict { PACKAGE_PIN U15    IOSTANDARD LVCMOS33 } [get_ports {state_led[5]}]

##Buttons
set_property -dict { PACKAGE_PIN T18   IOSTANDARD LVCMOS33 } [get_ports buttons[0]]
set_property -dict { PACKAGE_PIN W19   IOSTANDARD LVCMOS33 } [get_ports  buttons[1]]
set_property -dict { PACKAGE_PIN T17   IOSTANDARD LVCMOS33 } [get_ports  buttons[2]]
set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports  buttons[3]]
set_property -dict { PACKAGE_PIN U18   IOSTANDARD LVCMOS33 } [get_ports  buttons[4]]


## Configuration options, can be used for all designs
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

## SPI configuration mode options for QSPI boot, can be used for all designs
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 33 [current_design]
set_property CONFIG_MODE SPIx4 [current_design]

#seven-segment LED display
set_property PACKAGE_PIN W7 [get_ports {out[6]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[6]}]
set_property PACKAGE_PIN W6 [get_ports {out[5]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[5]}]
set_property PACKAGE_PIN U8 [get_ports {out[4]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[4]}]
set_property PACKAGE_PIN V8 [get_ports {out[3]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[3]}]
set_property PACKAGE_PIN U5 [get_ports {out[2]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[2]}]
set_property PACKAGE_PIN V5 [get_ports {out[1]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[1]}]
set_property PACKAGE_PIN U7 [get_ports {out[0]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {out[0]}]
set_property PACKAGE_PIN U2 [get_ports {anod[0]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {anod[0]}]
set_property PACKAGE_PIN U4 [get_ports {anod[1]}]                    
   set_property IOSTANDARD LVCMOS33 [get_ports {anod[1]}]
set_property PACKAGE_PIN V4 [get_ports {anod[2]}]               
   set_property IOSTANDARD LVCMOS33 [get_ports {anod[2]}]
set_property PACKAGE_PIN W4 [get_ports {anod[3]}]          
   set_property IOSTANDARD LVCMOS33 [get_ports {anod[3]}]

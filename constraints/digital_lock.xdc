
## Nexys A7 - 100 MHz Clock
set_property -dict { PACKAGE_PIN E3 IOSTANDARD LVCMOS33 } [get_ports clk]
create_clock -add -name sys_clk_pin -period 10.00 [get_ports clk]

## Password switches SW0-SW3
set_property -dict { PACKAGE_PIN J15 IOSTANDARD LVCMOS33 } [get_ports {password[0]}]
set_property -dict { PACKAGE_PIN L16 IOSTANDARD LVCMOS33 } [get_ports {password[1]}]
set_property -dict { PACKAGE_PIN M13 IOSTANDARD LVCMOS33 } [get_ports {password[2]}]
set_property -dict { PACKAGE_PIN R15 IOSTANDARD LVCMOS33 } [get_ports {password[3]}]

## Enter button - BTNU
set_property -dict { PACKAGE_PIN M18 IOSTANDARD LVCMOS33 } [get_ports enter_n]

## Reset button - BTNC
set_property -dict { PACKAGE_PIN N17 IOSTANDARD LVCMOS33 } [get_ports reset_n]

## Unlock LED - LD0
set_property -dict { PACKAGE_PIN H17 IOSTANDARD LVCMOS33 } [get_ports unlock]

## Lockout LED - LD1
set_property -dict { PACKAGE_PIN K15 IOSTANDARD LVCMOS33 } [get_ports locked]

## Attempt counter LEDs - LD2 and LD3
set_property -dict { PACKAGE_PIN J13 IOSTANDARD LVCMOS33 } [get_ports {attempts[0]}]
set_property -dict { PACKAGE_PIN N14 IOSTANDARD LVCMOS33 } [get_ports {attempts[1]}]

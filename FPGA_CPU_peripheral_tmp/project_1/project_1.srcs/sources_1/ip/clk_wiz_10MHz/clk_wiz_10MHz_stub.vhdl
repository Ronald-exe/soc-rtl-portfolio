-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Sat Jun 14 15:31:17 2025
-- Host        : DESKTOP-2LUQ77G running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub {f:/Proyecto/Nueva
--               carpeta/project_1/project_1.srcs/sources_1/ip/clk_wiz_10MHz/clk_wiz_10MHz_stub.vhdl}
-- Design      : clk_wiz_10MHz
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_wiz_10MHz is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_wiz_10MHz;

architecture stub of clk_wiz_10MHz is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,reset,locked,clk_in1";
begin
end;

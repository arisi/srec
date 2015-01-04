#!/usr/bin/env ruby
#encoding: UTF-8

require 'optparse'
require 'yaml'
require "pp"

lib="srec"
if File.file? "./lib/#{lib}.rb"
  require "./lib/#{lib}.rb"
  puts "using local #{lib}"
  local=true
else
  require lib
end

fn="/home/arisi/projects/mygit/arisi/ctex/bin/sol_STM32L_mg11.srec"
fn_old="old.srec"
$s=Srec.new file: fn
$s_old=Srec.new file: fn_old
min= $s.min
max= $s.max
bsize=512

b= $s.to_blocks min,max,bsize
b_old= $s_old.to_blocks min,max,bsize
todo=Srec::diff b,b_old
printf  "flashing %d of %d: %d%%\n",todo.count,b.count,100*todo.count/b.count



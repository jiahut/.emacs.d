#!/usr/bin/env ruby

all_elpas = []

ARGF.each do |elpa|
  if all_elpas.include? elpa 
      puts "#{elpa} repeat!!!"
  else 
      all_elpas << elpa
  end
end

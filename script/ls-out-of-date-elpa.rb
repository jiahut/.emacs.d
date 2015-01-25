#!/usr/bin/env ruby

ls = `ls -1 ../elpa/`
elpas = {}

ls.split.each do |line|
  if (match = line.match /^([\w|-]+[+]*?)-([\d.]+)$/)
    # puts "#{match[1]}-#{match[2]}"
    tmp = elpas[match[1]]
    if tmp
      tmp << match[2]
    else
      elpas[match[1]] = [ match[2] ]
    end
  end
end

overdue = []

elpas.each_entry do | k,v | 
  if v.length > 1 
    overdue <<  [k,v.min].join("-")
  end
end

overdue.each do  | elpa | 
  puts elpa
  # `rm -rf ../elpa/#{elpa}`
end

# ./ls-all-elpa.rb | xargs rm -rf 

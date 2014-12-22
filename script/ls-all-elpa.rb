#!/usr/bin/env ruby

ls = `ls -1 ../elpa`

ls.split.each do |line|
  if (match = line.match /([\w|-]+)-[\d.]+/)
    puts match[1]
  end
end

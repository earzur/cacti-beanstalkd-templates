#!/usr/bin/env ruby
# ============================================================================
# This script collects and display statistics about 
# beanstalkd (http://kr.github.com/beanstalkd/)
#
# This program is copyright (c) 2009 Silentale SA
# Feedback and improvements are welcome.
#
# THIS PROGRAM IS PROVIDED "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, WITHOUT LIMITATION, THE IMPLIED WARRANTIES OF
# MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
#
# This program is free software; you can redistribute it and/or modify it under
# the terms of the GNU General Public License as published by the Free Software
# Foundation, version 2.
#
# You should have received a copy of the GNU General Public License along with
# this program; if not, write to the Free Software Foundation, Inc., 59 Temple
# Place, Suite 330, Boston, MA  02111-1307  USA.
#
# ============================================================================
require 'rubygems'
require 'beanstalk-client'
require 'trollop'

script_name = __FILE__.split('/').last
opts = Trollop::options do
  version "#{script_name} © 2009 Silentale S.A." 
  banner <<-EOS
  display statistics about a queue on a beanstalkd server
EOS
  opt :server, 'beanstalk server address', :type => :string
  opt :port, 'beanstalk server port (default: 11300)', :type => :integer
  opt :queue, 'name of the beanstalk queue', :type => :string
end
Trollop::die :server, 'is mandatory' unless opts[:server]
Trollop::die :queue, 'is mandatory' unless opts[:queue]
opts[:port] = 11300 unless opts[:port]


B = Beanstalk::Connection.new "#{opts[:server]}:#{opts[:port]}"

ts=B.stats_tube opts[:queue]

ts.delete 'name'

result = ''
ts.keys.sort.each do |k|
   result << "#{k}:#{ts[k]} "
end

puts result
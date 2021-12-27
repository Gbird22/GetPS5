# GetPS5
A Perl script to check PS5 stock online.

This script was developed on Mac OS X. It should just run with the default Perl. The script uses curl and should also work on any Linux distribution assuming curl is installed. The script will go out and check for PS5 stock in roughly 6 minute intervals. If it finds stock it will execute the system beep command excessively for approximately 15 minutes. When you hear your system beeping, check stock at the stores listed in the store data. It's probably helpful to make sure you have logins for any store listed, and if possible stay logged in. If it finds stock it will log the finding in a new text file in the directory where the script was installed. 

To run the script open a terminal app CD to the directory where the script was downloaded and simply type: "perl get_ps5.pl" and hit return. The script will run continuously for about a week, if you close the terminal window the script will be terminated so please leave the window open. Good luck.

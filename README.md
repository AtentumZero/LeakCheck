## Leakcheck

Bash script to check an email address or username against the haveibeenpwned.com database. 

Results will be listed if an address or username has been included in a major data breach. If results are found, then an option to save a results file with details of the breach will be displayed.

Keep in mind. Repeated use in a short period of time may trigger haveibeenpwned.com to ratelimit you.

Compatible with POSIX systems - Linux, BSD, Solaris etc.

## Example use:

`./leakcheck.sh`

`Please enter an email address or username...`

`USERINPUT`

`Processing inputted data, please wait...`
 
`That address/username is listed in the following known data breach(es):`

`majordatabreach`

`Do you want further details? (y/n)`

`USERINPUT`

`Further details saved into Breach_YOURUSERNAME.txt file`

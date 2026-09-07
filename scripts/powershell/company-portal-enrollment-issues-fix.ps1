In such cases the issue is mostly due to broken authentication of the device.
Kindly check the below:

In command prompt execute:

dsregcmd /status

check the status of AzureAdPrt, if it is yes

delete the subkeys of HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Enrollments\
Not the Enrollments key, but all the subkeys (some would still stay, ignore those)

if AzureAdPrt, value is no, you need to request the PRT with below:
dsregcmd /refreshprt

Restart the machine (mandatory) and wait for some time.
The company portal should be fixed by itself.

In case if the issue still persist, with admin rights execute below commands:
dsregcmd /leave
then
reboot

after restart

dsregcmd /join
SFTP RETRIEVAL SCRIPT: Windows Batch File
=========================================

This guide will help you create a script that will:
1. Retrieve a completed export from the MySchoolSask SFTP server
2. Send that file to a vendor

This guide will specifically use **Windows Batch Files**. 

There are also **Powershell** and **Linux Bash** versions of this guide available, if you would prefer to use those. If you are setting up a dedicated "sync" server in your environment, running Linux and using the Powershell or Linux Bash versions will eliminate the need for a potentially costly Windows license.

What you will need
------------------
* The "portable" executables for WinSCP from here: https://winscp.net/download/WinSCP-5.15.3-Portable.zip
* A Windows workstation or server to run your script from on a schedule

My recommended set up
---------------------
I would recommend you create a new Windows Server specifically for syncing with all of your vendors. This allows you to control access to the scripts much more easily, and also makes it so all your sync scripts are in the same place. 

Security concerns
-----------------
This script will put your MySchoolSask AND vendor usernames and passwords in plain-text. You should take steps to limit access to this script and the server it's running on, so unauthorized people can't access your passwords.

Full Script
-----------
The fill script can be found below, and also in a separate file in this same directory. The scripts are identical.

The file names you wish to retrieve from MSS and then send to your vendor are set in the files **sftp-batch-mss.txt** and **sftp-batch-vendor.txt** respectively.

**mss-to-vendor-x.bat**

This is the file that you want to run with your scheduled task.
```bat
```

**sftp-batch-mss.txt**

This file contains the FTP commands to run on MySchoolSask's SFTP server.

```
```

**sftp-batch-vendor.txt**

This file contains the FTP commands to run on your vendor's server.
```
```
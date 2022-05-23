# The following are the scripts for day to day use ..
1) Check Java Version and Vendor names
2) Check RHEL last patch Version
3) Check SAMBA Service status
4) Run the Ping check Parallely using subshell to multiple hosts
5) The quick nslookup IP to name translator
6) The quick nslookup name to IP translator

# What these scripts are doing? see below quick summary ..

	✔️ Check_RHEL_Patch_Version.bash(This is just to list the last patch Information and Kernel Version.)
	✔️ nslookup_IP_to_name.bash(This is Just a quick nslookup IP to name translator.)
	✔️ nslookup_name_to_IP.bash(This is Just a quick nslookup name to IP translator.)
	✔️ ping_parallel.bash(Quick Ping script providing a parallelism)
	✔️ samba_state_check.bash(This is basically to check the SMB daemon and resport back to Linux team in case its dead in a form of e-mail notofication.)
  
* Once you run the `check_Java_ver_Check.bash` , will see the below output table generated.
```
$ bash check_Java_ver_Check.bash
  Please Enter password below:
  Please Enter your hostFile name: my_hostfile
```
* Once you get successful run of `check_Java_ver_Check.bash`  then, you will see below tabular output 
![image](https://user-images.githubusercontent.com/30109092/169745184-0174ecdd-4e40-44ed-80aa-ea1d66d6d176.png)



* When you run `Check_RHEL_Patch_Version.bash`; you will get prompted for `password` and `hostfile` before proceeding as follows..
```
$ bash Check_RHEL_Patch_Version.bash
  Please Enter password below:
  Please Enter your hostFile name: my_hostfile
```
* Once you get successful run of  `Check_RHEL_Patch_Version.bash` then, you will see below tabular output 

![image](https://user-images.githubusercontent.com/30109092/169745913-07a6d2fb-1950-4a2b-bc3e-6852431bf2ac.png)

* While having the samba status check IE `samba_state_check.bash`, you will get below mail in the HTML format over outlook when it get fails.
![image](https://user-images.githubusercontent.com/30109092/169748963-387d039c-e60a-450d-8359-f23e9d6aed93.png)

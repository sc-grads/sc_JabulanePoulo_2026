Linux Documentation: 
Table of Contents
Introduction to Linux

Linux Distributions

Linux Directory Structure

Installation Methods

Command Line Interface

File and Directory Management

Permissions

File Operations

Finding Files

Viewing and Editing Files

Input/Output Redirection

File Comparison

1. Introduction to Linux
What is Linux?
Linux is an operating system that acts as a master manager and middleman between physical hardware (CPU, RAM, DISK, I/O devices) and software applications.

Operating System Functions
Function	Description
Processor Scheduling	Decides which application gets CPU attention and for how long
Memory Management	Allocates RAM to programs and prevents data conflicts
File Management	Organizes data into logical structure (folders and files)
Device Management	Manages input/output devices and creates queues for access
The Kernel Components
Component	Description
Hardware Communication	Talks to CPU, RAM, Disk, and devices
Process Management	Manages running programs
Memory Allocation	Handles RAM distribution
Device Control	Controls keyboards, network interfaces, and other devices
Components of a Usable Linux System
Component	Examples
Linux Kernel	Core operating system engine
Shell	bash, zsh, fish
System Libraries	glibc, libc
Utilities	ls, cp, grep, find
Package Managers	apt, yum, dnf, pacman
Linux History
Year	Event
1991	Linus Torvalds creates Linux kernel
1992	Linux released under GNU General Public License
Present	Open source, free, globally developed
2. Linux Distributions
What is a Distribution?
Linux Distribution = Linux Kernel + Software + Tools = Complete Operating System

Types of Distributions
Type	Description	Examples
Commercial Distros	Backed by companies, paid support	Red Hat Enterprise Linux, SUSE Linux Enterprise Server
Community Distros	Maintained by volunteers, free to use	Ubuntu, Debian, Fedora
Enterprise Focused	Designed for business environments	CentOS, AlmaLinux, Rocky Linux
Most Important Distros for IT Careers
Distribution	Best For	Key Features
Red Hat Enterprise Linux (RHEL)	Corporate environments, system administration	Enterprise-level, paid support, very stable
Ubuntu	Learning, development, everyday use	Beginner-friendly, strong community, widely used
3. Linux Directory Structure
Root Directory (/)
Top-level directory - starting point of everything

Common Directories
Directory	Purpose
/	Root - top of file system hierarchy
/bin	Binaries and executable programs
/boot	Files needed to boot the operating system
/dev	Device files, controlled by OS and administrators
/etc	System configuration files
/home	Home directories for users
/lib, /lib64	System libraries
/lost+found	Recovered files after file system check
/media	Mount removable media (CD-ROMs, USBs)
/mnt	Mount external file systems
/opt	Optional or third-party software
/proc	Information about running processes
/root	Home directory for root account
/sbin	System administration binaries
/selinux	SELinux information
/srv	Data served by the system
/sys	Device information known to the kernel
/tmp	Temporary space, cleared on reboot
/usr	User-related programs, libraries, docs
/var	Variable data, especially log files
Application Directory Structures
Directory	Purpose
/usr/local	Software installed manually by users/admins
/usr/local/bin	Executable files
/usr/local/etc	Configuration files
/usr/local/lib	Libraries (support files/code)
/usr/local/log	Log files
/opt	Large third-party applications
/opt/acme	Root directory for Acme software
4. Installation Methods
Installing Linux on Windows using WSL
Step	Command/Action	Description
1	Check prerequisites	Windows 10+, virtualization enabled in BIOS, internet connection
2	wsl --install	Install WSL and default Ubuntu distribution
3	Restart Windows	Reboot after installation completes
4	Search "Ubuntu"	Open and set up Linux user account
WSL Management Commands
Command	Description
wsl -l	List installed distributions
wsl --install -d Debian	Install specific distribution
wsl --unregister DistributionName	Uninstall a distribution
Installing VirtualBox on Windows
Step	Action
1	Install Microsoft Visual C++ Redistributable (x64)
2	Download VirtualBox from virtualbox.org
3	Run installer with default settings
4	Click "Next" through all prompts
5	Click "Install" then "Finish"
Installing AlmaLinux Using OVA
Step	Action
1	Download AlmaLinux OVA file
2	Launch VirtualBox
3	File → Import Appliance
4	Select OVA file and click Open
5	Review settings and click Import
6	Click Start to boot VM
7	Complete setup prompts
VirtualBox Troubleshooting
Issue	Solution
Antivirus conflicts	Temporarily disable antivirus and reboot
Virtualization errors	Enable VT-x (Intel) or AMD-V (AMD) in BIOS
32-bit/64-bit mismatch	Ensure using 64-bit OS with 64-bit configuration
Memory allocation issues	Don't allocate more RAM than host can handle
Persistent problems	Check log files in VirtualBox VM settings
5. Command Line Interface
What is the Shell?
The shell is a program that takes commands and executes them - a command line interpreter.

Access Methods
Method	Description
Text-based login	Automatically placed into shell
Graphical Interface	Open terminal emulator (Activities → Terminal)
Types of Shells
Type	Description
Command Line Shell	Text-based interface
Graphical Shell	GUI (desktop environment)
Basic Linux Commands
Command	Description
pwd	Print working directory (show current directory)
cd	Change directory
ls	List contents of directory
ls -l	Detailed list with permissions, size, date
ls -a	Include hidden files (dot files)
clear	Clear the screen
man command	Display online manual for command
Man Pages Navigation
Key	Action
Enter	Move down one line
Space	Move down one page
g	Move to top of the page
G	Move to bottom of the page
q	Quit
Environment Variables
Concept	Description
Definition	Storage location with a name and a value
Format	Typically uppercase
Access	echo $VAR_NAME
PATH	Controls command search path, contains list of directories
which cat	Locates the path of a command
6. File and Directory Management
Directory Navigation Shortcuts
Shortcut	Description
.	This directory
..	Parent directory
cd -	Change to previous directory
cd ~	Go to home directory
/	Directory separator (forward slash)
Creating and Removing Directories
Command	Description
mkdir directory	Create a directory
mkdir -p directory	Create directory with parent directories
rmdir directory	Remove an empty directory
rmdir -p directory	Remove directory and parent if empty
rm -rf directory	Recursively remove directory (force)
./command	Execute command in current directory
Listing Files Commands
Command	Description
ls -F	Reveal file types (/=directory, @=link, *=executable)
ls -t	List files by time (newest first)
ls -r	Reverse order
ls -latr	Long listing including all files, reverse sorted by time
ls -d	List directory name, not contents
tree	Visual directory structure output
tree -d	List directories only
tree -C	Colorize output
Decoding ls -l Output
Field	Description
First character	File type (-=file, d=directory, l=link)
Next 9 characters	Permissions (rwx for user, group, other)
Number	Link count
Owner	User who owns the file
Group	Group that owns the file
Size	File size in bytes
Date/Time	Last modification time
Name	File or directory name
Handling Spaces in Names
Recommendation	Examples
Avoid spaces	Use hyphens (-) instead
Use underscores (_) instead
Use CamelCase (MyFile.txt)
7. Permissions
Permission Symbols
Symbol	Type
-	Regular file
d	Directory
l	Symbolic link
r	Read
w	Write
x	Execute
Permissions: Files vs Directories
Permission	File Effect	Directory Effect
Read (r)	Allows file to be read	Allows file names in directory to be read
Write (w)	Allows file to be modified	Allows entries to be modified within directory
Execute (x)	Allows execution of file	Allows access to contents and metadata for entries
Permission Categories
Symbol	Category
u	User (owner)
g	Group
o	Other (everyone else)
a	All (user, group, other)
Groups Commands
Command	Description
groups	Display a user's groups
id -Gn	Alternative group display
chgrp group file	Change group ownership
Changing Permissions - Symbolic Method
Command	Description
chmod u+x file	Add execute for user
chmod go-w file	Remove write for group and others
chmod a+rx file	Add read and execute for all
chmod u=rwx,g=rx,o= file	Set specific permissions
Numeric (Octal) Permission Values
Octal	Binary	String	Description
0	000	---	No permissions
1	001	--x	Execute only
2	010	-w-	Write only
3	011	-wx	Write and execute (2+1)
4	100	r--	Read only
5	101	r-x	Read and execute (4+1)
6	110	rw-	Read and write (4+2)
7	111	rwx	Read, write, and execute (4+2+1)
Common Permission Sets
Symbolic	Octal	Explanation
-rwx------	700	User: read, write, execute; group/others: none
-rwxr-xr-x	755	User: rwx; group/others: read and execute
-rw-rw-r--	664	User/group: read and write; others: read
-rw-rw----	660	User/group: read and write; others: no access
-rw-r--r--	644	User: read and write; group/others: read
drwx------	700	Private directory
drwxr-xr-x	755	Public directory
File Creation Mask (umask)
Command	Description
umask	Display current mask
umask 022	Set mask to 022
umask -S	Display symbolic notation
Default Permissions Without Mask
Type	Default Permission
Directories	777 (rwxrwxrwx)
Files	666 (rw-rw-rw-)
Common umask Values
umask	Owner	Group	Others
022	Full access	Read/execute (dirs), read (files)	Read/execute (dirs), read (files)
002	Full access	Full access	Read/execute (dirs), read (files)
077	Full access	No access	No access
007	Full access	Full access	No access
8. File Operations
Removing Files
Command	Description
rm file	Remove file
rm -r dir	Remove directory and contents recursively
rm -f file	Force removal, never prompt for confirmation
rm -rf dir	Force remove directory and contents
Copying Files
Command	Description
cp source destination	Copy source_file to destination_file
cp src1 src2 dest_dir	Copy multiple files to destination directory
cp -i source destination	Interactive prompt before overwriting
cp -r source_dir dest_dir	Copy directory recursively
Moving and Renaming Files
Command	Description
mv source destination	Move or rename files and directories
mv -i source destination	Interactive prompt before overwriting
mv file1 file2 file3 dest_dir	Move multiple files to directory
Wildcards
Wildcard	Description	Examples
*	Matches zero or more characters	ls .txt, ls a
?	Matches exactly one character	ls ?, ls a?.txt
[chars]	Matches any single character in set	ls [aeiou]*, ls [0-9].txt
Compression and Archiving
Command	Description
tar -c f tarfile [pattern]	Create a tar archive
tar -x f tarfile [pattern]	Extract files from archive
tar -t f tarfile [pattern]	Display table of contents
tar -cvf archive.tar files	Create archive with verbose output
tar -xvf archive.tar	Extract archive with verbose output
tar -czvf archive.tar.gz files	Create compressed archive
tar -xzvf archive.tar.gz	Extract compressed archive
tar Options
Option	Description
-c	Create archive
-x	Extract archive
-t	List contents
-v	Verbose (show progress)
-z	Use gzip compression
-f file	Use this file
Compression Commands
Command	Description
gzip file	Compress file (creates file.gz)
gunzip file.gz	Uncompress file
gzcat file.gz	Concatenate compressed file
zcat file.gz	Concatenate compressed file
Disk Usage
Command	Description
du	Estimates file usage
du -k	Display sizes in kilobytes
du -h	Display sizes in human readable format
du -sh directory	Summary total for directory
du -ah	All files with human readable sizes
9. Finding Files
The find Command
Command	Description
find [path...] [expression]	Recursively finds files in path that match expression
find . -name "*.txt"	Find all .txt files in current directory
find / -name "filename"	Search entire system for filename
find Options
Option	Description	Example
-name pattern	Find files/directories matching pattern	find . -name "*.conf"
-iname pattern	Same as -name, ignores case	find . -iname "README"
-ls	Performs ls on found items	find . -name "*.log" -ls
-mtime days	Find files that are days old	find . -mtime -7
-size num	Find files of size num	find . -size +10M
-newer file	Find files newer than file	find . -newer reference.txt
-exec command {} ;	Run command on found files	find . -name "*.tmp" -exec rm {} ;
The locate Command
Command	Description
locate pattern	Lists files that match pattern
locate -i pattern	Case-insensitive search
locate Features
Feature	Description
Speed	Faster than find command
Method	Queries an index/database
Timing	Results are not in real-time
Availability	May not be enabled on all systems
10. Viewing and Editing Files
Viewing Files
Command	Description
cat file	Display entire contents of file
more file	Browse through text file page by page
less file	More features than more (backward navigation)
head file	Output beginning portion (default 10 lines)
tail file	Output ending portion (default 10 lines)
tail -f file	Follow file, display data as written in real-time
Head and Tail Options
Command	Description
head -15 file.txt	Display first 15 lines
tail -15 file.txt	Display last 15 lines
head -n 20 file.txt	Display first 20 lines
tail -n 20 file.txt	Display last 20 lines
tail -f /var/log/syslog	Monitor log file in real-time
Vi/Vim Editor Overview
Editor	Description
vi	Advanced and powerful editor, has learning curve
vim	Vi Improved, more features than vi
view	Opens vim in read-only mode
Starting Vi/Vim
Command	Purpose
vi [file]	Edit a file
vim [file]	Edit a file with Vim
view [file]	Open in read-only mode
Vi Three Modes
Mode	Purpose	How to Enter
Command Mode	Navigation, deleting, copying, pasting	Default mode; press Esc to return
Insert Mode	Typing/editing text	i, I, a, A
Line Mode	Save, quit, search, set options	Type : (colon)
Command Mode Navigation
Key	Action
k	Up one line
j	Down one line
h	Left one character
l	Right one character
w	Right one word
b	Left one word
^	Go to beginning of line
$	Go to end of line
Insert Mode Commands
Command	Action
i	Insert at cursor position
I	Insert at beginning of line
a	Append after cursor position
A	Append at end of line
Line Mode Commands
Command	Action
:w	Save (write) the file
:w!	Force save
:q	Quit
:q!	Quit without saving
:wq or :x	Save and quit
:n	Go to line number n
:$	Go to last line
:set nu	Turn on line numbers
:set nonu	Turn off line numbers
:help [subcommand]	Get help
Editing Commands
Command	Action
x	Delete character under cursor
dw	Delete a word
dd	Delete the current line
d$	Delete from cursor to end of line
yy	Yank (copy) current line
yw	Yank word
p	Paste after cursor (or below current line)
u	Undo
Ctrl + r	Redo
Repeating Commands
Command	Effect
5k	Move up 5 lines
80iTextEsc	Insert "Text" 80 times
80i_Esc	Insert 80 underscore characters
Vi Quick Reference Card
Goal	Command
Start editing	i or a
Return to command mode	Esc
Save	:w
Quit	:q
Save & quit	:wq or :x
Quit without saving	:q!
Delete line	dd
Copy line	yy
Paste	p
Undo	u
Redo	Ctrl + r
11. Input, Output, and Redirection
Three I/O Types
I/O Name	Abbreviation	File Descriptor
Standard Input	stdin	0
Standard Output	stdout	1
Standard Error	stderr	2
Redirection Operators
Operator	Description
>	Redirects standard output to a file (overwrites)
>>	Redirects standard output to a file (appends)
<	Redirects input from a file to a command
Redirection Examples
Command	Description
ls > files.txt	Save directory listing to file
ls >> files.txt	Append directory listing to file
sort < file.txt	Sort content from file
command > output.txt 2>&1	Redirect both stdout and stderr
File Descriptor Redirection
Syntax	Description
2> file	Redirect standard error to a file
2>&1	Combine stderr and standard output
&> file	Redirect both stdout and stderr (bash)
The Null Device (/dev/null)
Command	Description
> /dev/null	Redirect output to nowhere
2> /dev/null	Suppress error messages
> /dev/null 2>&1	Redirect both stdout and stderr to nowhere
Null Device Examples
Example	Explanation
ls here not-here 2> /dev/null	Suppress error messages from ls command
ls here not-here > /dev/null 2>&1	Redirect both stdout and stderr to nowhere
command > /dev/null 2>&1	Completely silence all output from a command
12. File Comparison
Comparison Commands
Command	Description
diff file1 file2	Compare two files line by line
sdiff file1 file2	Side-by-side comparison of two files
vimdiff file1 file2	Highlight differences in vim editor
diff Output Format
Component	Description
LineNumFile1	Line number in first file where difference occurs
Action	Type of change: (A)dd, (C)hange, or (D)elete
LineNumFile2	Line number in second file where difference occurs
diff Output Symbols
Symbol	Meaning
<	Indicates a line from the first file
>	Indicates a line from the second file
---	Separates lines from file1 and file2
sort Command Options
Option	Description
-k F	Sort by key (field number)
-r	Sort in reverse order
-u	Sort unique (remove duplicates)
-n	Sort numerically
sort Examples
Command	Description
sort file.txt	Sort file alphabetically
sort -r file.txt	Sort in reverse order
sort -k 2 file.txt	Sort by second field
sort -u file.txt	Sort and remove duplicates
sort -n numbers.txt	Sort numerically
Quick Reference Cards
Essential Linux Commands
Goal	Command
Show current directory	pwd
List files	ls
List all files with details	ls -la
Change directory	cd /path
Create empty file	touch file
Create directory	mkdir dir
Copy file	cp source dest
Move/Rename file	mv source dest
Delete file	rm file
Delete directory	rm -r dir
View file	cat file
View file page by page	less file
Find files	find . -name "pattern"
Search in files	grep pattern file
Disk usage	du -h
Manual	man command
Clear screen	clear
Show command history	history
Show current user	whoami
Show system info	uname -a
Show running processes	top
Show process list	ps
Vi/Vim Quick Reference
Goal	Command
Start editing	i or a
Return to command mode	Esc
Save	:w
Quit	:q
Save & quit	:wq or :x
Quit without saving	:q!
Delete line	dd
Copy line	yy
Paste	p
Undo	u
Redo	Ctrl + r
Go to line 10	:10
Go to end of file	:$
Show line numbers	:set nu
Hide line numbers	:set nonu
Search forward	/pattern
Search backward	?pattern
Permission Quick Reference
Goal	Command
Make file executable	chmod +x file
Set permissions 755	chmod 755 file
Set permissions 644	chmod 644 file
Add execute for user	chmod u+x file
Remove write for group	chmod g-w file
Change owner	chown user file
Change group	chgrp group file
Change owner and group	chown user:group file
View umask	umask
View umask symbolic	umask -S
File Operations Quick Reference
Goal	Command
Copy file	cp file1 file2
Copy directory	cp -r dir1 dir2
Move file	mv file1 file2
Rename file	mv oldname newname
Remove file	rm file
Remove directory	rm -r dir
Create archive	tar -cvf archive.tar files
Extract archive	tar -xvf archive.tar
Create compressed archive	tar -czvf archive.tar.gz files
Extract compressed archive	tar -xzvf archive.tar.gz
Redirection Quick Reference
Goal	Command
Save output to file	command > file
Append output to file	command >> file
Read input from file	command < file
Save errors to file	command 2> file
Save output and errors	command &> file
Suppress errors	command 2> /dev/null
Suppress all output	command > /dev/null 2>&1

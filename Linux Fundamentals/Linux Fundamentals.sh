############################################################
#                LINUX DOCUMENTATION SCRIPT                #
############################################################

##############################
# 1. INTRODUCTION TO LINUX   #
##############################

# What is Linux?
# Linux is an operating system that acts as a master manager
# between hardware (CPU, RAM, Disk) and software applications.

# Operating System Functions:

# Processor Scheduling
#   Decides which application gets CPU attention and for how long

# Memory Management
#   Allocates RAM to programs and prevents data conflicts

# File Management
#   Organizes data into logical structure (folders and files)

# Device Management
#   Manages input/output devices and creates queues for access

# Kernel Components:

# Hardware Communication
#   Talks to CPU, RAM, Disk, and devices

# Process Management
#   Manages running programs

# Memory Allocation
#   Handles RAM distribution

# Device Control
#   Controls keyboards, network interfaces, and other devices

# Components of a Usable Linux System:

# Linux Kernel
#   Core operating system engine

# Shell
#   Command-line interface like bash, zsh, fish

# System Libraries
#   glibc, libc

# Utilities
#   ls, cp, grep, find

# Package Managers
#   apt, yum, dnf, pacman

# Linux History:

# 1991
#   Linus Torvalds creates Linux kernel

# 1992
#   Linux released under GNU General Public License

# Present
#   Open source, free, globally developed


##############################
# 2. LINUX DISTRIBUTIONS    #
##############################

# What is a Distribution?
# Linux Distribution = Linux Kernel + Software + Tools = Complete Operating System

# Types of Distributions:

# Commercial Distros
#   Backed by companies, offer paid support, used in businesses
#   Examples: Red Hat Enterprise Linux, SUSE Linux Enterprise Server

# Community Distros
#   Maintained by volunteers, free to use
#   Examples: Ubuntu, Debian, Fedora

# Enterprise Focused
#   Designed for business environments
#   Examples: CentOS, AlmaLinux, Rocky Linux

# Most Important Distros for IT Careers:

# Red Hat Enterprise Linux (RHEL)
#   Best For: Corporate environments, system administration
#   Key Features: Enterprise-level, paid support, very stable
#   Used by: Banks, telecom companies, large corporations

# Ubuntu
#   Best For: Learning, development, everyday use
#   Key Features: Beginner-friendly, strong community, widely used
#   Also used in servers and cloud environments


##############################
# 3. DIRECTORY STRUCTURE    #
##############################

# Root Directory (/)
# Top-level directory - starting point of everything

# Common Directories:

# /
#   Root - top of file system hierarchy

# /bin
#   Binaries and executable programs

# /boot
#   Files needed to boot the operating system

# /dev
#   Device files, controlled by OS and administrators

# /etc
#   System configuration files

# /home
#   Home directories for users

# /lib, /lib64
#   System libraries

# /lost+found
#   Recovered files after file system check

# /media
#   Mount removable media (CD-ROMs, USBs)

# /mnt
#   Mount external file systems

# /opt
#   Optional or third-party software

# /proc
#   Information about running processes

# /root
#   Home directory for root account

# /sbin
#   System administration binaries

# /selinux
#   SELinux information

# /srv
#   Data served by the system

# /sys
#   Device information known to the kernel

# /tmp
#   Temporary space, cleared on reboot

# /usr
#   User-related programs, libraries, docs

# /var
#   Variable data, especially log files

# Application Directory Structures:

# /usr/local
#   Software installed manually by users/admins
#   /usr/local/bin - Executable files
#   /usr/local/etc - Configuration files
#   /usr/local/lib - Libraries (support files/code)
#   /usr/local/log - Log files

# /opt
#   Large third-party applications
#   Each app usually gets its own directory
#   Example: /opt/google/chrome


##############################
# 4. INSTALLATION METHODS   #
##############################

# Installing Linux on Windows using WSL

# Step 1: Check Prerequisites
#   Windows 10 or newer
#   Virtualization enabled in BIOS
#   Internet connection

# Step 2: Install WSL
#   wsl --install

# Step 3: Restart Windows
#   Reboot after installation completes

# Step 4: Access Linux Distribution
#   Search for "Ubuntu" in Start menu
#   Open and set up Linux user account

# WSL Management Commands:

# wsl -l
#   List installed distributions

# wsl --install -d Debian
#   Install specific distribution

# wsl --unregister DistributionName
#   Uninstall a distribution

# Installing VirtualBox on Windows

# Step 1
#   Install Microsoft Visual C++ Redistributable (x64)

# Step 2
#   Download VirtualBox from virtualbox.org

# Step 3
#   Run installer with default settings

# Step 4
#   Click "Next" through all prompts

# Step 5
#   Click "Install" then "Finish"

# Installing AlmaLinux Using OVA

# Step 1
#   Download AlmaLinux OVA file

# Step 2
#   Launch VirtualBox

# Step 3
#   File → Import Appliance

# Step 4
#   Select OVA file and click Open

# Step 5
#   Review settings and click Import

# Step 6
#   Click Start to boot VM

# Step 7
#   Complete setup prompts

# VirtualBox Troubleshooting

# Antivirus conflicts
#   Temporarily disable antivirus and reboot

# Virtualization settings
#   Enable VT-x (Intel) or AMD-V (AMD) in BIOS

# Guest settings
#   Ensure using 64-bit OS with 64-bit configuration

# Memory allocation
#   Don't allocate more RAM than host can handle

# Log files
#   Check log files in VirtualBox VM settings


##############################
# 5. COMMAND LINE INTERFACE #
##############################

# What is the Shell?
# The shell is a program that takes commands and executes them
# Also called a command line interpreter

# Access Methods:

# Text-based login
#   Automatically placed into shell

# Graphical Interface
#   Open terminal emulator (Activities → Terminal)

# Types of Shells:

# Command Line Shell
#   Text-based interface

# Graphical Shell
#   GUI (desktop environment)

# Basic Linux Commands:

# pwd
#   Print working directory (show current directory)

# cd
#   Change directory

# ls
#   List contents of directory

# ls -l
#   Detailed list with permissions, size, date

# ls -a
#   Include hidden files (dot files)

# clear
#   Clear the screen

# man command
#   Display online manual for command

# Man Pages Navigation:

# Enter
#   Move down one line

# Space
#   Move down one page

# g
#   Move to top of the page

# G
#   Move to bottom of the page

# q
#   Quit

# /pattern
#   Search forward

# ?pattern
#   Search backward

# n
#   Next match

# N
#   Previous match

# Environment Variables:

# Definition
#   Storage location with a name and a value

# Format
#   Typically uppercase

# Access
#   echo $VAR_NAME

# PATH
#   Controls command search path
#   Contains list of directories

# which cat
#   Locates the path of a command


##############################
# 6. FILE AND DIRECTORY     #
#    MANAGEMENT             #
##############################

# Directory Navigation Shortcuts:

# .
#   This directory

# ..
#   Parent directory

# cd -
#   Change to previous directory

# cd ~
#   Go to home directory

# /
#   Directory separator (forward slash)

# Creating and Removing Directories:

# mkdir directory
#   Create a directory

# mkdir -p directory
#   Create directory with parent directories

# rmdir directory
#   Remove an empty directory

# rm -rf directory
#   Recursively remove directory (force)

# ./command
#   Execute command in current directory

# Listing Files Commands:

# ls -F
#   Reveal file types (/ = directory, @ = link, * = executable)

# ls -t
#   List files by time (newest first)

# ls -r
#   Reverse order

# ls -latr
#   Long listing including all files, reverse sorted by time

# ls -d
#   List directory name, not contents

# tree
#   Visual directory structure output

# tree -d
#   List directories only

# tree -C
#   Colorize output

# Decoding ls -l Output:

# First character
#   File type (- = file, d = directory, l = link)

# Next 9 characters
#   Permissions (rwx for user, group, other)

# Number
#   Link count

# Owner
#   User who owns the file

# Group
#   Group that owns the file

# Size
#   File size in bytes

# Date/Time
#   Last modification time

# Name
#   File or directory name

# Handling Spaces in Names:

# Recommendation
#   Avoid spaces in file and directory names

# Alternatives
#   Use hyphens (-) instead
#   Use underscores (_) instead
#   Use CamelCase (MyFile.txt)


##############################
# 7. PERMISSIONS            #
##############################

# Permission Symbols:

# -
#   Regular file

# d
#   Directory

# l
#   Symbolic link

# r
#   Read

# w
#   Write

# x
#   Execute

# Permissions: Files vs Directories:

# Read (r)
#   File: Allows file to be read
#   Directory: Allows file names in directory to be read

# Write (w)
#   File: Allows file to be modified
#   Directory: Allows entries to be modified within directory

# Execute (x)
#   File: Allows execution of file
#   Directory: Allows access to contents and metadata for entries

# Permission Categories:

# u
#   User (owner)

# g
#   Group

# o
#   Other (everyone else)

# a
#   All (user, group, other)

# Groups Commands:

# groups
#   Display a user's groups

# id -Gn
#   Alternative group display

# chgrp group file
#   Change group ownership

# Changing Permissions - Symbolic Method:

# chmod u+x file
#   Add execute for user

# chmod go-w file
#   Remove write for group and others

# chmod a+rx file
#   Add read and execute for all

# chmod u=rwx,g=rx,o= file
#   Set specific permissions

# Numeric (Octal) Permission Values:

# 0
#   Binary: 000, String: ---, Description: No permissions

# 1
#   Binary: 001, String: --x, Description: Execute only

# 2
#   Binary: 010, String: -w-, Description: Write only

# 3
#   Binary: 011, String: -wx, Description: Write and execute

# 4
#   Binary: 100, String: r--, Description: Read only

# 5
#   Binary: 101, String: r-x, Description: Read and execute

# 6
#   Binary: 110, String: rw-, Description: Read and write

# 7
#   Binary: 111, String: rwx, Description: Read, write, execute

# Common Permission Sets:

# -rwx------ (700)
#   User: read, write, execute; group/others: none

# -rwxr-xr-x (755)
#   User: read, write, execute; group/others: read and execute

# -rw-rw-r-- (664)
#   User/group: read and write; others: read

# -rw-rw---- (660)
#   User/group: read and write; others: no access

# -rw-r--r-- (644)
#   User: read and write; group/others: read

# drwx------ (700)
#   Private directory

# drwxr-xr-x (755)
#   Public directory

# File Creation Mask (umask):

# umask
#   Display current mask

# umask 022
#   Set mask to 022

# umask -S
#   Display symbolic notation

# Default Permissions Without Mask:

# Directories
#   777 (rwxrwxrwx)

# Files
#   666 (rw-rw-rw-)

# Common umask Values:

# umask 022
#   Owner: Full access
#   Group: Read/execute (dirs), read (files)
#   Others: Read/execute (dirs), read (files)

# umask 002
#   Owner: Full access
#   Group: Full access
#   Others: Read/execute (dirs), read (files)

# umask 077
#   Owner: Full access
#   Group: No access
#   Others: No access

# umask 007
#   Owner: Full access
#   Group: Full access
#   Others: No access


##############################
# 8. FILE OPERATIONS        #
##############################

# Removing Files:

# rm file
#   Remove file

# rm -r dir
#   Remove directory and contents recursively

# rm -f file
#   Force removal, never prompt for confirmation

# rm -rf dir
#   Force remove directory and contents

# Copying Files:

# cp source destination
#   Copy source_file to destination_file

# cp src1 src2 dest_dir
#   Copy multiple files to destination directory

# cp -i source destination
#   Interactive prompt before overwriting

# cp -r source_dir dest_dir
#   Copy directory recursively

# Moving and Renaming Files:

# mv source destination
#   Move or rename files and directories

# mv -i source destination
#   Interactive prompt before overwriting

# mv file1 file2 file3 dest_dir
#   Move multiple files to directory

# Wildcards:

# *
#   Matches zero or more characters
#   Examples: ls *.txt, ls a*

# ?
#   Matches exactly one character
#   Examples: ls ?, ls a?.txt

# [chars]
#   Matches any single character in set
#   Examples: ls [aeiou]*, ls [0-9].txt

# Compression and Archiving:

# tar -cvf archive.tar files
#   Create a tar archive with verbose output

# tar -xvf archive.tar
#   Extract archive with verbose output

# tar -tvf archive.tar
#   Display table of contents

# tar -czvf archive.tar.gz files
#   Create compressed archive with gzip

# tar -xzvf archive.tar.gz
#   Extract compressed archive

# tar Options:

# -c
#   Create archive

# -x
#   Extract archive

# -t
#   List contents

# -v
#   Verbose (show progress)

# -z
#   Use gzip compression

# -f file
#   Use this file

# Compression Commands:

# gzip file
#   Compress file (creates file.gz)

# gunzip file.gz
#   Uncompress file

# gzcat file.gz
#   Concatenate compressed file

# zcat file.gz
#   Concatenate compressed file

# Disk Usage:

# du
#   Estimates file usage

# du -k
#   Display sizes in kilobytes

# du -h
#   Display sizes in human readable format

# du -sh directory
#   Summary total for directory

# du -ah
#   All files with human readable sizes


##############################
# 9. FINDING FILES          #
##############################

# The find Command:

# find [path...] [expression]
#   Recursively finds files in path that match expression

# find . -name "*.txt"
#   Find all .txt files in current directory

# find / -name "filename"
#   Search entire system for filename

# find . -iname "*.TXT"
#   Case-insensitive search

# find . -type f
#   Find only files

# find . -type d
#   Find only directories

# find . -size +10M
#   Find files larger than 10MB

# find . -mtime -7
#   Find files modified in last 7 days

# find . -mtime +30
#   Find files modified more than 30 days ago

# find . -empty
#   Find empty files and directories

# find . -exec ls -l {} \;
#   Execute command on found files

# find . -name "*.tmp" -delete
#   Find and delete matching files

# The locate Command:

# locate pattern
#   Lists files that match pattern (faster than find)

# locate -i pattern
#   Case-insensitive search

# updatedb
#   Update locate database

# find vs locate:

# find
#   Speed: Slower
#   Real-time: Yes
#   Search criteria: Many options
#   Availability: Always available

# locate
#   Speed: Very fast
#   Real-time: No (uses index)
#   Search criteria: Limited
#   Availability: May need installation


##############################
# 10. VIEWING AND EDITING   #
#     FILES                 #
##############################

# Viewing Commands:

# cat file
#   Display entire file

# less file
#   Browse file page by page

# more file
#   Browse file forward only

# head file
#   Display first 10 lines

# head -20 file
#   Display first 20 lines

# tail file
#   Display last 10 lines

# tail -20 file
#   Display last 20 lines

# tail -f file
#   Follow file (real-time updates)

# nl file
#   Display with line numbers

# less Navigation:

# Space or Page Down
#   Next page

# b or Page Up
#   Previous page

# Enter or Down Arrow
#   Next line

# y or Up Arrow
#   Previous line

# g
#   Go to beginning

# G
#   Go to end

# /pattern
#   Search forward

# ?pattern
#   Search backward

# n
#   Next match

# N
#   Previous match

# q
#   Quit

# Vi/Vim Editor - Starting:

# vi file
#   Edit file with vi

# vim file
#   Edit file with vim (improved)

# view file
#   Open file in read-only mode

# Vi/Vim - Three Modes:

# Command Mode
#   Purpose: Navigation, deleting, copying, pasting
#   How to Enter: Default mode; press Esc to return

# Insert Mode
#   Purpose: Typing/editing text
#   How to Enter: i, I, a, A

# Line Mode
#   Purpose: Save, quit, search, set options
#   How to Enter: : (colon)

# Vi/Vim - Command Mode Navigation:

# k or Up Arrow
#   Up one line

# j or Down Arrow
#   Down one line

# h or Left Arrow
#   Left one character

# l or Right Arrow
#   Right one character

# w
#   Right one word

# b
#   Left one word

# 0 or ^
#   Beginning of line

# $
#   End of line

# gg
#   Beginning of file

# G
#   End of file

# Vi/Vim - Insert Mode Commands:

# i
#   Insert at cursor position

# I
#   Insert at beginning of line

# a
#   Append after cursor

# A
#   Append at end of line

# o
#   Open new line below

# O
#   Open new line above

# Esc
#   Return to Command Mode

# Vi/Vim - Editing Commands:

# x
#   Delete character under cursor

# dw
#   Delete word

# dd
#   Delete current line

# d$
#   Delete from cursor to end of line

# yy
#   Yank (copy) current line

# yw
#   Yank word

# p
#   Paste after cursor (or below line)

# P
#   Paste before cursor (or above line)

# u
#   Undo

# Ctrl + r
#   Redo

# .
#   Repeat last command

# Vi/Vim - Line Mode Commands:

# :w
#   Save file

# :w!
#   Force save

# :q
#   Quit

# :q!
#   Quit without saving

# :wq or :x
#   Save and quit

# :n
#   Go to line number n

# :$
#   Go to last line

# :set nu
#   Turn on line numbers

# :set nonu
#   Turn off line numbers

# :/pattern
#   Search forward

# :?pattern
#   Search backward

# :%s/old/new/g
#   Replace all occurrences

# :help
#   Get help


##############################
# 11. INPUT, OUTPUT, AND    #
#     REDIRECTION           #
##############################

# Three I/O Types:

# Standard Input (stdin)
#   File Descriptor: 0
#   Data stream that provides input to a command
#   Typically from keyboard

# Standard Output (stdout)
#   File Descriptor: 1
#   Data stream where command sends normal results
#   Typically displayed on screen

# Standard Error (stderr)
#   File Descriptor: 2
#   Separate data stream for error messages
#   Allows handling independently from normal output

# Redirection Operators:

# >
#   Redirect standard output to a file (overwrites existing content)

# >>
#   Redirect standard output to a file (appends to existing content)

# <
#   Redirect input from a file to a command

# 2>
#   Redirect standard error to a file

# 2>>
#   Redirect standard error to a file (append)

# &>
#   Redirect both stdout and stderr

# 2>&1
#   Redirect stderr to stdout

# |
#   Pipe output to next command

# Redirection Examples:

# ls > files.txt
#   Save directory listing to file

# ls >> files.txt
#   Append directory listing to file

# sort < file.txt
#   Read input from file and sort

# ls 2> errors.txt
#   Save error messages to file

# ls > out.txt 2>&1
#   Save both output and errors to file

# ls &> output.txt
#   Same as above (bash)

# ls 2> /dev/null
#   Suppress error messages

# ls > /dev/null 2>&1
#   Suppress all output

# ls | grep pattern
#   Pipe output to grep

# The Null Device (/dev/null):

# > /dev/null
#   Discard standard output

# 2> /dev/null
#   Discard error messages

# &> /dev/null
#   Discard all output

# /dev/null
#   Special device file that discards any data written to it
#   Functions like a black hole or trash can


##############################
# 12. FILE COMPARISON       #
##############################

# Comparison Commands:

# diff file1 file2
#   Compare two files line by line

# diff -u file1 file2
#   Unified format (shows context)

# sdiff file1 file2
#   Side-by-side comparison

# vimdiff file1 file2
#   Highlight differences in vim

# cmp file1 file2
#   Compare byte by byte

# diff Output Format:

# 5c5
#   Line 5 changed in file1 vs file2

# 3a4
#   After line 3, add line from file2

# 7d6
#   Delete line 7 from file1 to match file2

# <
#   Line from first file

# >
#   Line from second file

# ---
#   Separator between files

# sort Command:

# sort file
#   Sort file alphabetically

# sort -r file
#   Sort in reverse order

# sort -n file
#   Sort numerically

# sort -u file
#   Sort and remove duplicates

# sort -k 2 file
#   Sort by second field

# sort -t: -k 1 file
#   Sort using colon delimiter, first field

# sort file | uniq
#   Sort and count unique lines


##############################
# 13. PROCESS MANAGEMENT    #
##############################

# Process Commands:

# ps
#   Show current processes

# ps aux
#   Show all processes (detailed)

# ps -ef
#   Show all processes (standard format)

# top
#   Interactive process viewer

# htop
#   Enhanced interactive viewer

# kill PID
#   Terminate process by PID

# kill -9 PID
#   Force terminate process

# pkill process
#   Kill processes by name

# jobs
#   Show background jobs

# bg
#   Resume job in background

# fg
#   Bring job to foreground

# &
#   Run command in background

# Ctrl + Z
#   Suspend current process

# Ctrl + C
#   Interrupt current process


##############################
# 14. SYSTEM INFORMATION    #
##############################

# System Commands:

# uname -a
#   Show all system information

# hostname
#   Show computer name

# whoami
#   Show current user

# who
#   Show who is logged in

# uptime
#   Show system uptime

# date
#   Show current date and time

# cal
#   Show calendar

# df -h
#   Show disk space usage

# free -h
#   Show memory usage

# history
#   Show command history

# history -c
#   Clear command history


############################################################
#                  QUICK REFERENCE                         #
############################################################

# Essential Commands:

# pwd
#   Show current directory

# ls
#   List files

# ls -la
#   List all files with details

# cd /path
#   Change directory

# mkdir dir
#   Create directory

# touch file
#   Create file

# cp source dest
#   Copy file

# mv source dest
#   Move/Rename file

# rm file
#   Delete file

# rm -r dir
#   Delete directory

# cat file
#   View file

# less file
#   View file page by page

# find . -name "pattern"
#   Find files

# grep pattern file
#   Search in files

# du -h
#   Disk usage

# man command
#   Manual

# clear
#   Clear screen

# history
#   Command history

# Permission Quick Reference:

# chmod +x file
#   Make executable

# chmod 755 file
#   Set 755 permissions

# chmod 644 file
#   Set 644 permissions

# chown user file
#   Change owner

# chgrp group file
#   Change group

# chown user:group file
#   Change both

# umask -S
#   View umask

# Vi/Vim Quick Reference:

# i or a
#   Start editing

# Esc
#   Return to command mode

# :w
#   Save

# :q
#   Quit

# :wq or :x
#   Save and quit

# :q!
#   Quit without saving

# dd
#   Delete line

# yy
#   Copy line

# p
#   Paste

# u
#   Undo

# Ctrl + r
#   Redo

# Redirection Quick Reference:

# command > file
#   Save output to file

# command >> file
#   Append output to file

# command 2> file
#   Save errors to file

# command 2> /dev/null
#   Suppress errors

# command > /dev/null 2>&1
#   Suppress all output

# command1 | command2
#   Pipe output to another command


############################################################
#                END OF DOCUMENTATION                      #
############################################################

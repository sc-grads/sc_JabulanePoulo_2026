############################################################
#                LINUX DOCUMENTATION                       #
#                                                          #
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
# 6. CUSTOMIZING THE SHELL  #
#     PROMPT                #
##############################

# Shell Prompt Environment Variables:

# Shell: Bash, ksh, sh
#   Variable: PS1
#   Description: Primary prompt variable for Bourne-style shells

# Shell: Csh, tcsh, zsh
#   Variable: prompt
#   Description: Prompt variable for C-style shells

# PS1 Special Characters:

# @
#   Current time in 12-hour am/pm format

# \A
#   Current time in 24-hour HH:MM format

# \u
#   Username of the current user

# \w
#   Current working directory (full path)

# \W
#   Basename of the current working directory

# $
#   If the effective UID is 0 (root), a #; otherwise a $

# Examples of PS1 Customization:

# export PS1="\u@\h:\w\$ "
#   Standard prompt showing user@host:full/path$

# export PS1="[\u@\h \W]\$ "
#   Prompt showing [user@host folder]$

# export PS1="\A \u \$ "
#   Prompt showing time username $

# Making PS1 Changes Permanent:

# echo 'export PS1="[\u@\h \W]\$ "' >> ~/.bash_profile
#   Add PS1 customization to user's shell profile file

# source ~/.bash_profile
#   Apply changes immediately without logging out

# Summary of Shell Prompt:

# Environment Variable
#   PS1 (or prompt) controls the shell prompt appearance

# Persistence
#   Set the environment variable in dot files to retain changes across sessions

# Common dot files
#   .bashrc, .bash_profile, .profile


##############################
# 7. SHELL ALIASES          #
##############################

# What Are Aliases:

# Purpose: Shortcuts
#   Create shorter versions of long commands

# Purpose: Efficiency
#   Use for commands you type often

# Purpose: Productivity
#   Reduce typing and minimize errors

# Creating Aliases:

# alias
#   List all current aliases

# alias name='value'
#   Create a new alias where name is the shortcut and value is the command

# Alias Examples:

# alias ll='ls -la'
#   Creates a shortcut for detailed listing with all files

# alias grep='grep --color=auto'
#   Adds color highlighting to grep output

# alias cls='clear'
#   Makes Linux behave like Windows/DOS

# alias ..='cd ..'
#   Quickly go up one directory

# alias home='cd ~'
#   Quickly go to home directory

# Removing Aliases:

# unalias name
#   Remove the specified alias

# unalias -a
#   Remove all aliases

# Persisting Aliases:

# echo 'alias ll="ls -la"' >> ~/.bashrc
#   Add alias to bash configuration file

# source ~/.bashrc
#   Apply changes immediately

# Summary of Aliases:

# alias
#   Command to list and create aliases

# unalias
#   Command to delete aliases

# Persistence
#   Store aliases in dot files to make them permanent across sessions


##############################
# 8. ENVIRONMENT VARIABLES  #
##############################

# Definition and Purpose:

# Environment Variables
#   Name/value pairs that influence how programs operate

# Example
#   $EDITOR specifies the preferred text editor for various commands

# Viewing Environment Variables:

# printenv
#   List all current environment variables with their values

# env
#   Alternative command to list all environment variables

# Common Environment Variables:

# HOSTNAME
#   Provides the system's name

# PATH
#   Specifies the directories to search for executable files

# HOME
#   Path to the current user's home directory

# USER or LOGNAME
#   Current username

# SHELL
#   Path to the current user's shell

# Displaying Specific Variables:

# printenv PATH
#   Display the value of the PATH variable

# echo $PATH
#   Display PATH using echo with dollar sign prefix

# Creating and Updating Variables:

# export MY_VAR=value
#   Create or update an environment variable

# Important Rule:
#   No spaces around equals sign
#   Correct: export MY_VAR=example
#   Incorrect: export MY_VAR = example

# Removing Variables:

# unset MY_VAR
#   Remove an environment variable

# Persistence of Variables:

# echo 'export EDITOR=vim' >> ~/.bashrc
#   Add variable to shell configuration file

# source ~/.bashrc
#   Apply changes immediately

# Program-Specific Variables:

# man program_name
#   Review the "ENVIRONMENT" section to understand which variables a program uses

# Examples of Program Variables:

# LESS
#   Controls options for the less pager

# GREP_OPTIONS
#   Sets default options for grep

# LS_COLORS
#   Controls color output for ls command

# Summary of Environment Variables:

# Definition
#   Name/value pairs that influence program behavior

# View
#   Use printenv or echo $VARIABLE

# Create
#   Use export VAR=value with no spaces around =

# Remove
#   Use unset VAR

# Persist
#   Add to .bash_profile or .bashrc

# Program Variables
#   Check the ENVIRONMENT section in man pages


##############################
# 9. PROCESSES AND JOB      #
#     CONTROL               #
##############################

# Listing Processes with ps:

# ps
#   Display process status for current terminal

# ps -e
#   Display all processes

# ps -ef
#   Display all processes with full format details

# ps -eH
#   Display a process tree

# ps -e --forest
#   Display a process tree in hierarchical view

# ps -u username
#   Display processes owned by a specific user

# ps -p pid
#   Display information for a specific process ID

# Other Ways to View Processes:

# pstree
#   Display processes in a tree format

# top
#   Interactive process viewer with real-time updates

# htop
#   Enhanced interactive process viewer with color and mouse support

# Background and Foreground Processes:

# command &
#   Start command in the background

# Ctrl-c
#   Kill the foreground process

# Ctrl-z
#   Suspend the foreground process

# Job Control Commands:

# jobs
#   List all background and suspended processes in current session

# bg [%num]
#   Resume a suspended process in the background

# fg [%num]
#   Bring a background process to the foreground

# kill [%num or PID]
#   Kill a process by job number or process ID

# Killing Processes:

# Ctrl-c
#   Kill the foreground process

# kill PID
#   Send the default TERM signal to process

# kill -9 PID
#   Send SIGKILL to process (forceful termination)

# kill -15 PID
#   Send SIGTERM to process (graceful termination)

# kill -TERM PID
#   Send SIGTERM using signal name

# kill -1
#   Display a list of available signals

# Summary of Process Control:

# Listing Processes
#   ps, pstree, top, htop

# Job Control
#   Ctrl-c, Ctrl-z, bg, fg, jobs

# Terminating Processes
#   kill with different signals


##############################
# 10. SCHEDULING REPEATED   #
#     JOBS WITH CRON        #
##############################

# Cron Overview:

# cron
#   A time-based job scheduling service that runs continuously in the background

# crontab
#   A program to create, read, update, and delete job schedules

# Crontab Format Structure:

# Field 1: Minute
#   Range: 0-59

# Field 2: Hour
#   Range: 0-23

# Field 3: Day of Month
#   Range: 1-31

# Field 4: Month
#   Range: 1-12

# Field 5: Day of Week
#   Range: 0-6 (0 = Sunday, 6 = Saturday)

# Field 6: Command
#   The command to execute

# Example Crontab Entry:

# 0 7 * * 1 /opt/sales/bin/weekly-report
#   Run every Monday at 07:00

# Redirecting Output:

# 0 2 * * * /root/backupdb > /tmp/db.log 2>&1
#   Run at 02:00 every day and send output to a log file

# Advanced Crontab Scheduling:

# 0,30 * * * * /opt/acme/bin/half-hour-check
#   Run every 30 minutes (comma for multiple values)

# */2 * * * * /opt/acme/bin/half-hour-check
#   Another way to run every 30 minutes (slash for intervals)

# 0-4 * * * * /opt/acme/bin/first-five-mins
#   Run for the first 5 minutes of each hour (hyphen for ranges)

# Crontab Shortcuts:

# @yearly or @annually
#   Equivalent to: 0 0 1 1 *
#   Run once per year at midnight on January 1

# @monthly
#   Equivalent to: 0 0 1 * *
#   Run once per month at midnight on the 1st

# @weekly
#   Equivalent to: 0 0 * * 0
#   Run once per week at midnight on Sunday

# @daily or @midnight
#   Equivalent to: 0 0 * * *
#   Run once per day at midnight

# @hourly
#   Equivalent to: 0 * * * *
#   Run once per hour at minute 0

# Crontab Command Usage:

# crontab file
#   Install a new crontab from a file

# crontab -l
#   List your current cron jobs

# crontab -e
#   Edit your cron jobs using the default text editor

# crontab -r
#   Remove all of your cron jobs

# Summary of Cron:

# cron
#   The service that runs scheduled jobs in the background

# crontab
#   The command used to create, edit, list, and remove scheduled jobs

# Format
#   Minute, Hour, Day of Month, Month, Day of Week, Command


##############################
# 11. SWITCHING USERS AND   #
#     RUNNING COMMANDS      #
#     AS OTHERS             #
##############################

# The su Command:

# su [username]
#   Change user ID or become superuser

# su -
#   Switch to root with root's environment

# su - username
#   Switch to username with that user's environment

# su -c "command" username
#   Run a single command as another user

# whoami Command:

# whoami
#   Displays the effective username of the current session

# Example of su Usage:

# whoami
#   Output: jason

# su oracle
#   (prompt for oracle password)

# whoami
#   Output: oracle

# exit
#   Return to original user

# sudo - Super User Do:

# sudo
#   Execute a command as another user, typically the superuser

# sudo -l
#   List available commands the user is allowed to run

# sudo command
#   Run command as root

# sudo -u user command
#   Run command as the specified user

# Using sudo for Shell Access:

# sudo su
#   Switch to the superuser account

# sudo su -
#   Switch to the superuser account with root's environment

# sudo su - username
#   Switch to the username account

# sudo -s
#   Start a shell as root

# sudo -u root -s
#   Same as sudo -s

# sudo -u user -s
#   Start a shell as the specified user

# Changing the sudo Configuration:

# visudo
#   Edit the /etc/sudoers file safely with syntax checking

# Sudoers Format:

# user host=(users) [NOPASSWD:]commands
#   Define sudo privileges for a user

# Sudoers Examples:

# adminuser ALL=(ALL) NOPASSWD:ALL
#   adminuser can run any command as any user on any host without password

# jason linuxsvr=(root) /etc/init.d/oracle
#   jason can run the oracle init.d script as root only on linuxsvr

# %wheel ALL=(ALL) ALL
#   Users in the wheel group can run any command as any user

# Summary of Switching Users:

# su
#   Switch users, requiring the target user's password

# whoami
#   Display the effective username of the current session

# sudo
#   Run programs as other users using your own password

# Shell Access
#   Use sudo -s or sudo su to switch users with sudo

# Configuration
#   Use visudo to safely edit the sudoers file


##############################
# 12. SHELL HISTORY         #
##############################

# Concept of Shell History:

# History Storage
#   Executed commands are added to the history

# Memory and Disk
#   Shell history is stored in memory during the session and saved to disk when the session ends

# History Files
#   ~/.bash_history (Bash), ~/.history, ~/.histfile (other shells)

# history Command and HISTSIZE:

# history
#   Displays the shell history with line numbers

# HISTSIZE
#   Controls the number of commands to retain in memory during the session

# export HISTSIZE=1000
#   Set history to retain 1000 commands

# HISTFILESIZE
#   Controls how many commands are saved to the history file on disk

# Exclamation Mark Syntax - Basic:

# !N
#   Repeat command line number N

# !!
#   Repeat the previous command line

# !string
#   Repeat the most recent command starting with "string"

# Exclamation Mark Syntax - Word Selection:

# !^
#   Represents the first argument of the previous command

# !$
#   Represents the last argument of the previous command

# !:N
#   Represents a word on the command line (0 = command, 1 = first argument, etc.)

# History Expansion Examples:

# head files.txt sorted_files.txt notes.txt
#   Original command

# !!
#   Repeats the entire command

# vi !:2
#   Opens vi with the second argument (sorted_files.txt)

# !^
#   Expands to files.txt (first argument)

# !$
#   Expands to notes.txt (last argument)

# Searching Shell History:

# Ctrl-r
#   Reverse shell history search (incremental)

# Ctrl-r again
#   Cycle through older matches

# Enter
#   Execute the selected command

# Arrow keys (Up/Down)
#   Navigate and edit the selected command

# Ctrl-g
#   Cancel the search and return to an empty prompt

# Tab Completion:

# Tab once
#   Completes unambiguous text

# Tab twice
#   Displays a list of possible completions

# Completion Types:
#   Commands (based on PATH)
#   Files and directories
#   Environment variables (when preceded by $)
#   Usernames (when preceded by ~)

# Summary of Shell History:

# Shell History
#   Commands are stored in memory and disk; view with history

# Exclamation Mark Syntax
#   Use !N, !!, !string, !^, !$ to repeat commands and reuse arguments

# History Search
#   Use Ctrl-r to interactively search through previous commands

# Autocompletion
#   Use Tab to complete commands, paths, variables, and usernames


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
#   Set 755 permissions (rwxr-xr-x)

# chmod 644 file
#   Set 644 permissions (rw-r--r--)

# chown user file
#   Change owner

# chgrp group file
#   Change group

# chown user:group file
#   Change both

# umask -S
#   View umask

# Shell Prompt Quick Reference:

# export PS1="\u@\h:\w\$ "
#   Standard prompt: user@host:full/path$

# export PS1="[\u@\h \W]\$ "
#   Short prompt: [user@host folder]$

# export PS1="\A \u \$ "
#   Time prompt: HH:MM username $

# Aliases Quick Reference:

# alias
#   List all aliases

# alias ll='ls -la'
#   Create alias for detailed listing

# unalias ll
#   Remove specific alias

# unalias -a
#   Remove all aliases

# Environment Variables Quick Reference:

# printenv
#   List all environment variables

# echo $PATH
#   Display specific variable

# export EDITOR=vim
#   Create or update variable

# unset EDITOR
#   Remove variable

# Process Control Quick Reference:

# ps -ef
#   List all processes

# top
#   Interactive process viewer

# command &
#   Run command in background

# Ctrl-z
#   Suspend foreground process

# bg
#   Resume in background

# fg
#   Bring to foreground

# kill PID
#   Terminate process

# kill -9 PID
#   Force terminate

# Cron Quick Reference:

# crontab -e
#   Edit cron jobs

# crontab -l
#   List cron jobs

# */5 * * * * command
#   Run every 5 minutes

# 0 2 * * * command
#   Run daily at 2:00 AM

# @daily command
#   Run once per day

# Switching Users Quick Reference:

# su - username
#   Switch to user with their environment

# sudo command
#   Run command as root

# sudo -u user command
#   Run command as specific user

# sudo -s
#   Start root shell

# whoami
#   Show current user

# Shell History Quick Reference:

# history
#   Show command history

# !!
#   Repeat last command

# !123
#   Repeat command number 123

# !string
#   Repeat last command starting with "string"

# !$
#   Use last argument of previous command

# Ctrl-r
#   Search history

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

---
title: Killing all descendant processes in Linux
date: 2021-01-25 09:46
description: How to kill a process and its entire process subtree with a shell script
tags: article, linux, shell
---

## <code>kill</code> command

I want to force stop a process with its process ID. No big deal right? Just run the kill command as <code> kill -9 &lt;pid&gt;</code> to stop it. This works fine when this process has no subprocesses. In my case, the process can have some child processes. These child processes can have more and so on.

I couldn't kill these processes with the group ID, since my target process was spawned by another process. This made the target process to take up the root process's ID as it's group ID. 

## <code>pkill</code> command

With some preliminary google search, <code>pkill</code> looked promising. It can kill the child processes of a  process with the -P option <code>pkill -P &lt;ppid&gt;</code> (Where ppid is the parent process ID). 

Just got to recursively call this on all the child processes. But how do I find the process IDs of the children? Luckily, from the man page of pkill, I found <code>pgrep</code> - it prints the process IDs. 

Now it's just a matter of wiring them all into a bash script. 

## <code>killThemAll.sh</code>

```bash
#!/bin/sh

# Check if arguments are present
if [[ -z "$1" ]]; then
  echo "Error: Please enter a Process ID to kill" >&2
  exit 1
fi

# Check if the argument is an integer
REGEX='^[0-9]+$'
if [[ $1 =~ $REGEX ]]; then
  echo "Error: Process ID is not a number" >&2
  echo "Please enter an integer for Process ID" >&2
  exit 1
fi

# Prints the child processes of a process with
# pgrep command - Recursively
findChildProcesses()
{
  CHILDREN=$(pgrep -P $1)
  if [[ -n "$CHILDREN" ]]; then
    echo $CHILDREN
  fi
  for PID in $CHILDREN
  do
    findChildProcesses $PID
  done
}

# Command to kill all the processes listed by the above function
kill -9 $1 `findChildProcesses $1`
```


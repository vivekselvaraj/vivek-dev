---
title: Killing all descendant processes in Linux
date: 2021-01-25 09:46
description: How to kill a process and its entire process subtree with a shell script
tags: article, linux, shell
---

## <code>kill</code> command

At my daily job, I had to force stop a process with its process ID. No big deal right? Just run the kill command as <code> kill -9 &lt;pid&gt;</code> to stop it abruptly. This works, if that is the only process that I had to kill. The process can have some subprocesses which are started by it. Those subprocesses can have more subprocesses under it (this can go on forever). The kill command can do the job only if I know the process IDs of all the processes that I want to kill. 

## <code>pkill</code> command

With some preliminary google search, <code>pkill</code> looked promising. It can kill the child processes of a target process with the -P option <code>pkill -P &lt;ppid&gt;</code> (Where ppid is the parent process ID). Even this does not cater to the recursive killing of subprocesses that I am looking for.

## <code>killThemAll.sh</code>

Since no built in commands in Linux had the ability to recursively kill the subprocesses of a parent process, I decided to write a shell script of my own. You might think that I could have killed by the process' group ID. In my particular case, the target process itself was spawned by another process. This made the target process and all its subprocesses to take up the parent's process ID as their group ID

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

I sought the help of the <code>pgrep</code> command to find the child processes under a process.


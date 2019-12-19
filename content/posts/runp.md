---
title: "runp: run shell commands in parallel"
date: 2019-12-17
categories: [prog]
tags: [sysadmin,go,parallel,shell]
---

I'm using shell (bash specifically) on daily basis. From time to time a need arises to run multiple commands in parallel. For example my [.bashrc](https://github.com/jreisinger/dotfiles/blob/master/.bashrc) runs commands like these to download or clone vim plugins I use:

```
curl -L -o $HOME/.git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
rm -rf $HOME/.vim/pack/plugins/start/grep.vim && git clone https://github.com/yegappan/grep.git $HOME/.vim/pack/plugins/start/grep.vim
# https://tpaschalis.github.io/vim-go-setup/
rm -rf $HOME/.vim/pack/plugins/start/vim-go && git clone https://github.com/fatih/vim-go.git $HOME/.vim/pack/plugins/start/vim-go
```

## Why and how is it useful

The problem is that these commmands run sequentially and it takes a while until they are done. I was thinking of a way how to speed them up. So to scratch my itch I came up with [runp](https://github.com/jreisinger/runp). Now I can run those commands (I stored them in `install-my-stuff.txt`) in parallel:

<script id="asciicast-288718" src="https://asciinema.org/a/288718.js" async></script>

Let's see how much time did I save:

```
$ time bash install-my-stuff.txt
<...>
real	0m15.690s
user	0m3.440s
sys	0m0.902s

$ time runp install-my-stuff.txt
<...>
real	0m3.678s
user	0m3.904s
sys	0m0.880s
```

Hmm, around 12 seconds. Not bad I think :-).

If you don't want `runp` to add any output of its own (that is sent to stderr by the way) use the `-q` flag to quiet it:

```
$ runp -q install-my-stuff.txt 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 70071  100 70071    0     0   145k      0 --:--:-- --:--:-- --:--:--  145k
Cloning into '/home/reisinge/.vim/pack/plugins/start/vim-go'...
Cloning into '/home/reisinge/.vim/pack/plugins/start/grep.vim'...
```

## How to install it

`runp` is easy to install it. It's a single binary that you download and make it executable:

```
# choose your system and architecture
export SYS=linux  # or darwin
export ARCH=amd64 # or arm

# download it an make it executable
curl -L https://github.com/jreisinger/runp/releases/latest/download/runp-$SYS-$ARCH -o ~/bin/runp
chmod u+x ~/bin/runp
```

## More examples

The commands to execute can be supplied also via stdin. It means that `runp` can be used within pipelines like this one:

```
$ for dir in $HOME /etc /tmp; do echo sudo "du -sh $dir"; done | runp -q | sort -h
13M	/tmp
17M	/etc
370G	/home/reisinge
```

Here we generate the commands to run in a bash for loop. Then we pipe the commands into `runp`. Finally the `runp`'s output (stdout) is sorted.

We can simplify by using the `-p` flag which adds a prefix string to the final command that will be run:

```
$ echo -e "$HOME\n/etc\n/tmp" | runp -q -p 'sudo du -sh' | sort -h
13M	/tmp
17M	/etc
370G	/home/reisinge
```

The final example shows how to find open ports from a list of hosts and ports:

```
# file with host-port pairs
$ cat host-port.txt
localhost 80
localhost 81
127.0.0.1 443
127.0.0.1 444
localhost 22

# find out which ports are listening
$ cat host-port.txt | runp -p 'netcat -v -w2 -z' -q 2>&1 | egrep 'open$'
localhost [127.0.0.1] 443 (https) open
localhost [127.0.0.1] 80 (http) open
localhost [127.0.0.1] 22 (ssh) open
```

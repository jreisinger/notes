---
title: "Git"
date: 2014-03-20
draft: false
tags: [prog]
categories: [git]
---

[Git](http://git-scm.com/) is a free & open source, distributed version control system designed to handle everything from small to very large projects with speed and efficiency.

Every Git clone is a full-fledged [in svk: ucelený, kompletný] repository with complete history and full revision tracking capabilities, not dependent on network access or a central server. Branching and merging are fast and easy to do.

First-Time Git Setup
====================

Introduce yourself to git with your name and public email address before doing any operation:

    git config --global user.name "Jeffrey Lebowski"
    git config --global user.email "jlebowski@dude.org"

You might also like to add some colors, alias(es), your editor and diff tool:

    git config --global color.ui true
    git config alias.lol 'log --pretty=oneline --abbrev-commit --graph --decorate'
    git config --global core.editor vim
    git config --global merge.tool vimdiff

You only need to do this *once*.

You can see your configuration like this:

    $ git config --list    # output depends on whether you're in a git repo directory or not

You can also manage you configuration via [~/.gitconfig](https://github.com/jreisinger/dotfiles/blob/master/.gitconfig) file.

If you want to manage the current repository configuration just leave out the `--global` option or use the local config file `.git/config`.

To start using git, you can either create a new project or get one from the Internet and start working on it.

Starting a git repository
=========================

    $ mkdir project
    $ cd project
    $ git init

You've now initialized the working directory -- you may notice a new directory created, named `.git`. Git stores all of its stuff in this hidden directory. If you want Git to stop tracking your files, just remove `.git`.

Next, tell git to take a snapshot [in svk: momentka] of the contents of all files under the current directory (note the `.`), with git-add:

    $ git add .     # add files in working directory to a temporary storage - index

This snapshot is now stored in a *temporary staging area* which git calls the "staging index" or just "index". You can permanently store the contents of the index in the repository with `git-commit`:

    $ git commit    # add files in index to a permanent storage - repository (.git directory)

This will prompt you for a commit message. You've now stored the first version of your project in git.

Getting a git repository
========================

    ## the Linux kernel (approx. 150MB download):
    $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
    ## any server with ssh and git
    $ git clone ssh://[user@]server.xy/path/to/repo.git/

Making changes
==============

When dealing with git, it's best to work in small bits. Rule of thumb: *if you can't summarise it in a sentence, you've gone too long without committing*.

The typical working cycle is:

1. Work on your project.
2. Check which files you have changed:

        $ git status

3. Check what the actual changes were:

        $ git diff

4. Add any files/folders mentioned in step 2:

        $ git add file1 newfile2 newfolder3

5. You are now ready to commit. You can see what is about to be committed using `git-diff` with the `--cached` option:

        $ git diff --cached

    (Without `--cached`, `git-diff` will show you any changes that you've made but not yet added to the index.) If you need to make any further adjustments, do so now, and then add any newly modified content to the index. Finally, "commit" your changes with:

        $ git commit

    This will again prompt you for a message describing the change, and then record a new version of the project.

Alternatively, instead of running `git-add` beforehand, you can use

    $ git commit -am "commit message"

which will automatically notice any modified (but not new) files, add them to the index, and commit, all in one step.

A note on commit messages: Though not required, it's a good idea to begin the commit message with a single short (less than 50 character) line summarizing the change, followed by a blank line and then a more thorough description. Tools that turn commits into email, for example, use the first line on the `Subject:` line and the rest of the commit in the body.

Exclude some files
==================

To set certain files or patterns to be ignored by Git, you must either modify the `$GIT_DIR/info/exclude` file or create a file called `.gitignore` in your project’s root directory. The former is not shared between repositories (so you can set ignores for your specific environment), while the `.gitignore` is usually checked into Git and distributed along with everything else.

For example if you don't want to track dot-files, setup `.gitignore` like this:

    .*
    !/.gitignore

See more [here](http://github.com/guides/ignore-for-git).

If some of your files is already beeing tracked by git, you can untrack it like this:

    git rm --cached <filename>

To to list tracked files:

    # currently tracked files under master branch
    git ls-tree -r master --name-only

    # files that ever existed (i.e. including deleted files)
    git log --pretty=format: --name-only --diff-filter=A | sort - | sed '/^$/d'

To remove files not tracked by Git (like log files, zipped files, compiled files)

    git clean -n  # dry-run
    git clean -f  # files removed!

Tips and Tricks
===============

Apply changes generated via `git diff [--binary]`:

    git apply --ignore-space-change --ignore-whitespace

While in Git-tracked directory, print the filename followed by the author of the last commit:

    for f in `find -type f`; do
            git log -1 --date=iso -- $f |
            grep ^Author |
            perl -wnla -s -F: -e 'print "$file --" . $F[1]' -- -file=$f
    done

Ignore changes of the files' mode (for current repo):

    git config core.fileMode false

More
====

* See my [wiki](http://wiki.reisinge.net/Git) for more
* [My blog post derived from this text](http://jreisinger.blogspot.sk/2014/01/simple-source-code-management-with-git.html)
* [Git Magic](http://www-cs-students.stanford.edu/~blynn/gitmagic/)
* [O'Reilly Webcast: Git in One hour](http://www.youtube.com/watch?v=OFkgSjRnay4)
* [Pro Git - Online book](http://progit.org/book/)

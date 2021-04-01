
An important tactic when taking the CKAD examination is to set yourself up to answer questions quickly while at the same time reducing the rate of mistakes.

These techniques can help here:

- Use command completion
- Use aliases and shorthands for longer keywords that you would otherwise have to type

Your environment has been pre-configured with command completion, and a few shortcuts and aliases that you should consider taking advantage of:

- The kubectl command has been aliased as `k`.  Typing `k` sure beats having to type `kubectl` each and every time.

- The environment variable `DR` has been set.  It expands to `--dry-run=client -oyaml` and is provided for convenience.  Each time you need to produce a _base_ yaml file for a pod or a deployment, the mechanism is to dry-run a kubectl command and set the output format to yaml.

## Editing

The `.vimrc` file has been pre-set with line numbers and auto-indent.

## The command line

If you are comfortable with vim, vim bindings is turned on in the bash command shell (`set -o vi`).  It's often quicker to edit an existing the command instead of typing Ctl-C and having to re-type it from scratch.

## Command History

The `.inputrc` file has been set for history search.  I find this to be one of the [most useful things in bash](https://coderwall.com/p/oqtj8w/the-single-most-useful-thing-in-bash).  I recommend you take advantage of it.

## Problem validation

Similar to the katacoda workshop, each section provides a mechanism to validate your solutions.

Try to get in the habit of doing this test-first:

- run the check and see it fail
- implement your solution
- re-run the check and see it pass

A script is also provided to run all checks in each section.

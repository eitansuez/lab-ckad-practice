
An important tactic when taking the CKAD examination is to set yourself up to answer questions quickly while at the same time reducing the rate of mistakes.

These techniques can help here:

- Use command completion
- Use aliases and shorthands for longer keywords or flags that you would otherwise have to type

Your environment has been pre-configured with command completion, and a few shortcuts and aliases that you should consider taking advantage of:

- The kubectl command has been aliased as `k`.  Typing `k` sure beats having to type `kubectl` each and every time.

- The environment variable `DR` has been set.  It expands to `--dry-run=client -oyaml` and is provided for convenience.  Each time you need to produce a _base_ yaml file for a pod or a deployment, the mechanism is to dry-run a kubectl command and set the output format to yaml.

The `.vimrc` file has been pre-set with line numbers and auto-indent.

If you are comfortable with vim, vim bindings is turned on in the bash command line (`set -o vi`).  The idea is that it's easier to edit the command line over typing Ctl-C and having to re-type it.

The `.inputrc` file has been set for history search.  I find this to be one of the [most useful things in bash](https://coderwall.com/p/oqtj8w/the-single-most-useful-thing-in-bash).

Similar to the katacoda workshop, each section has a verification script that can be run to see validate your solutions.  The name of the verification script is provided in each section's instructions.  Make use of it to verify whether you have answered all questions correctly.

The instructions also embed validations that you can run on a per-problem basis.
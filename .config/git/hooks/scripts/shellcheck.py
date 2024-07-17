#!/usr/bin/env python3

"""Helper script to be used as a pre-commit hook."""
import os
import sys
import subprocess


def shellcheckEnabled():
    """Determine if the pre-commit hook for shellcheck is enabled."""
    out = subprocess.getoutput("git config --bool hooks.shellcheck")
    if out == "false":
        return False
    return True


if shellcheckEnabled():
    exitCode = os.WEXITSTATUS(os.system('git diff --name-only --cached | xargs shellcheck --norc -S error --exclude=SC1071'))
    if exitCode == 1:
        print('''Warning: shellcheck has detected syntax errors in your changes.
To disable the shellcheck precommit hook run the following command:

    git config hooks.shellcheck false
''')
        sys.exit(1)
else:
    print('shellcheck precommit disabled\
     (enable with `git config hooks.shellcheck true`)')

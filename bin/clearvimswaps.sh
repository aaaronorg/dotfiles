#!/bin/bash
# Expects variables realfile, swapfile, recoveryfile.
# http://superuser.com/a/157510
vim -r "$swapfile" -c ":wq! $recoveryfile" && rm "$swapfile"
if cmp "$recoveryfile" "$realfile"
then rm "$recoveryfile"
else vimdiff "$recoveryfile" "$realfile"
fi

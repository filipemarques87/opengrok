

Copyright (c) 2006, 2019 Oracle and/or its affiliates. All rights reserved.

For the official documentation, see https://github.com/oracle/opengrok

## Changes

The reindex only happens if the script detects a new commit on the branch. If it is not the case, the script will do nothing for that repository.
  
## Varibles
| Variable | Description | Example |
|--|--|--|
| SRC_FOLDER | Source folder used by opengrok where the repository will be cloned | ~/opengrok/opengrok-src/ |
| ETC_FOLDER | Configuration folder used by the opengrok and where is the file with the repository list | ~/opengrok/opengrok-etc/ |
| DATA_FOLDER | Data folder used by opengrok to store the indices | ~/opengrok/opengrok-data/ |
| SSH_FOLDER | Location of the ssh keys | ~/.ssh/ |
| REINDEX | The value in minutes the reindex frequency | 60 |
| BRANCH | The remote branch for which opengrok will be looking at. To see the different branches: `git ls-remote git://github.com/jszakmeister/trac-backlog.git` | HEAD |

## How to setup

- add the repositories that you would like to add to opengrok into `repo.txt` file. This file should be in placed in `$ETC_FOLDER` defined in `install.sh` script

- the ssh public key should be added into remove repository

- the frequency of the indexing is controlled by `$REINDEX` variable, also defined in `install.sh` script

- the URL is http://localhost:8080/

## TODO
- use docker secret command to deal with the ssh keys (right now, the ssh keys are exposed)

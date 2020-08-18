#!/bin/bash
#
# Call the opengrok indexer if there were changes in the code

# Current work directory
# CWD=/home/filipe/projects/opengrok-git

# List of repositories
#REPO_FILE=./repo.txt
REPO_FILE=/opengrok/etc/repo.txt

# Filename where the commit hash is stored
LAST_COMMIT_FILENAME=prev_commit

#######################################
# Extract folder name from git repository url.
# Globals:
#   None
# Arguments:
#   repository url
#######################################
git_foldername()
{
  repo_url=$1
  repo_folder=${repo_url##*/}
  echo "${repo_folder%.git}"
}

#######################################
# Get last commit from a branch
# Globals:
#   BRANCH
# Arguments:
#   repository url
#######################################
get_last_commit()
{
  echo "$(git ls-remote $1 | grep $BRANCH | cut -d$'\t' -f1)"
}

if [ ! -f "$REPO_FILE" ]; then
	date +"%F %T file with repository does not exist"
	exit 1
fi

while read repo; do
   date +"%F %T Treate $repo ..."

  cd $SRC_ROOT
  # repo_dir="$(git_foldername $repo)"

  if [ -d "$repo_dir" ]; then
    # Last known commit hash from the last run
    prev_commit=$(head -n 1 ./$repo_dir/$LAST_COMMIT_FILENAME)
    
    # Last commit hash from remote
    last_commit="$(get_last_commit $repo)"

    if [ "$prev_commit" != "$last_commit" ]; then
      # There is a new commit, the code must be updated and re-indexed
      cd $repo_dir
      git pull
      echo $last_commit > $LAST_COMMIT_FILENAME
      # ./index.sh
		  /scripts/index.sh
    fi

  else
      date +"%F %T Cloning $repo..."
      # The repository does not exist, clone it and run the indexers
      git clone $repo
      echo $(get_last_commit $repo) > ./$repo_dir/$LAST_COMMIT_FILENAME
      # ./index.sh
      /scripts/index.sh
  fi

done < $REPO_FILE

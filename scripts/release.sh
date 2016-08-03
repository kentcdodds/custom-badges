#!/bin/sh

# Diff against working directory AND staged files
diff_output=$(git diff HEAD)

# If there are any changes that haven't been comitted or stashed, abort.
# This is needed to avoid push hooks passing but the code being pushed that is not compliant.
if [[ "$diff_output" != "" ]];
then
  echo '*** Aborting Push: Please stash or commit your changes before attempting to push. ***'
  exit 1
fi

latest_version=$(git tag | tail -1)
new_version=$((latest_version+1))
echo "Tagging \"$new_version\" as the new version"
git tag $new_version
echo "Pushing"
git push --follow-tags

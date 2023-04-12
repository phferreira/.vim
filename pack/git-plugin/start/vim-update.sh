for DIR in /home/paulo/.vim/pack/git-plugin/start/*; 
do 
  if [ -d "$DIR" ]; then
    cd $DIR
    git fetch
    branch=$(git branch --show-current)
    git fetch
    git pull origin $branch --recurse-submodules
  else
      echo "Warning: '$DIR' NOT found.";
  fi
done

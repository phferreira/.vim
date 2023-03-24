for DIR in *; 
do 
  if [ -d "$DIR" ]; then
    cd $DIR;
    pwd;
    git fetch;
    git pull;
    cd ..;
  else
      echo "Warning: '$DIR' NOT found.";
  fi
done

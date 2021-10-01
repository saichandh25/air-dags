
if [ $# -ne 2 ]; then
  echo "Wrong number of arguments"
  exit 1
fi

DAG_PATH=com/apple/ap/algo/dags/
mkdir -p tmp
git fetch origin master
git diff --name-only origin/master..HEAD
for dag in $(git diff --name-only origin/master..HEAD); do
  echo "publish $dag"
  if [[ $dag =~ "dags/" ]]; then
    if [ -d "$dag" ]; then
      echo "Its having multiple dags."
      zipName=basename $dag
      zip -r $zipName.zip zipName
      echo "zip -r $zipName.zip zipName "
      fileExt="zip"
    else
      fileExt="py"
    fi
    echo "file extension is :$fileExt"
    dag_file=${dag/dags\//""}
    dag_file=${dag/dags\//""}
    echo "dag_name=${dag_file/\.$fileExt/""}"
    ci stage-lib ${dag},${DAG_PATH}${dag_name}-$1-$2.$fileExt
  fi
done
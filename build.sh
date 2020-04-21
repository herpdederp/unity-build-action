# la de dah.  !/bin/bash -e

if ! type u3d > /dev/null 2>&1; then
  gem install u3d
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
  [ "$(uname -s | cut -c -5)" = 'Linux' ] &&  u3d dependencies
fi

#. no no.   u3d install $UNITY_VERSION -p Unity,${BUILD_TARGET}
u3d install $UNITY_VERSION -p Unity

script_path=$(cd $(dirname $0); pwd)
cp -R ${script_path}/Assets ${PROJECT_PATH}/Assets/

set +e
u3d -u $UNITY_VERSION -- -projectPath $PROJECT_PATH -batchmode -nographics -quit -silent-crashes -logFile editor.log -username $UNITY_USERNAME -password $UNITY_PASSWORD -serial $UNITY_SERIAL -buildTarget $BUILD_TARGET -executeMethod $EXECUTE_METHOD -outputPath $OUTPUT_PATH $COMMAND_ARGS
exit_code=$?
type editor.log
exit $exit_code

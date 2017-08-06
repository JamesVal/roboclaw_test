#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
    DESTDIR_ARG="--root=$DESTDIR"
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/amhil/Devel/james_testing/roboclaw_ws/src/roboclaw_ros/roboclaw_node"

# snsure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/amhil/Devel/james_testing/roboclaw_ws/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/amhil/Devel/james_testing/roboclaw_ws/install/lib/python2.7/dist-packages:/home/amhil/Devel/james_testing/roboclaw_ws/build/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/amhil/Devel/james_testing/roboclaw_ws/build" \
    "/usr/bin/python" \
    "/home/amhil/Devel/james_testing/roboclaw_ws/src/roboclaw_ros/roboclaw_node/setup.py" \
    build --build-base "/home/amhil/Devel/james_testing/roboclaw_ws/build/roboclaw_ros/roboclaw_node" \
    install \
    $DESTDIR_ARG \
    --install-layout=deb --prefix="/home/amhil/Devel/james_testing/roboclaw_ws/install" --install-scripts="/home/amhil/Devel/james_testing/roboclaw_ws/install/bin"

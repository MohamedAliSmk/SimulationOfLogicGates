git config --global user.name "MohamedAliSamk"
git config --global user.email "MohamedAlisamk@gmail.com"
#! /bin/bash
#
# install.sh
# Copyright (C) 2013 sagar <sagar@sagar-liquid>
#
echo "Installing freeglut..."
sudo apt-get install freeglut3-dev
echo "Installing SDL..."
sudo apt-get install libsdl1.2-dev libsdl-image1.2-dev
#! /bin/bash
#
# install.sh
# Copyright (C) 2013 sagar <sagar@sagar-liquid>
#
echo "Installing freeglut..."
sudo apt-get install freeglut3-dev
echo "Installing SDL..."
sudo apt-get install libsdl1.2-dev libsdl-image1.2-dev
composer install
composer install
Composer install
composer install
git clone https://github.com/sagarrakshe/opengl-mario.git
composer install
# This script is sourced by the user and uses
# their shell.
#
# This script tries to find its location but
# this does not work in every shell.
#
# It is known to work in bash, zsh and ksh
#
# Do not execute this script without sourcing,
# because it won't have any effect then.
# That is, always run this script with
#
#     . /path/to/emsdk_env.sh
#
# or
#
#     source /path/to/emsdk_env.sh
#
# instead of just plainly running with
#
#     ./emsdk_env.sh
#
# which won't have any effect.
CURRENT_SCRIPT=
DIR="."
# use shell specific method to get the path
# to the current file being source'd.
#
# To add a shell, add another conditional below,
# then add tests to scripts/test_source_env.sh
if [ -n "${BASH_SOURCE-}" ]; then   CURRENT_SCRIPT="$BASH_SOURCE"; elif [ -n "${ZSH_VERSION-}" ]; then   CURRENT_SCRIPT="${(%):-%x}"; elif [ -n "${KSH_VERSION-}" ]; then   CURRENT_SCRIPT=${.sh.file}; fi
if [ -n "${CURRENT_SCRIPT-}" ]; then   DIR=$(dirname "$CURRENT_SCRIPT");   if [ -h "$CURRENT_SCRIPT" ]; then     SYMDIR=$(dirname "$(ls -l "$CURRENT_SCRIPT" | sed -n "s/.*-> //p")");     if [ -z "$SYMDIR" ]; then       SYMDIR=".";     fi;     FULLDIR="$DIR/$SYMDIR";     DIR=$(cd "$FULLDIR" > /dev/null 2>&1; /bin/pwd);     unset SYMDIR;     unset FULLDIR;   fi; fi
unset CURRENT_SCRIPT
if [ ! -f "$DIR/emsdk.py" ]; then   echo "Error: unable to determine 'emsdk' directory. Perhaps you are using a shell or" 1>&2;   echo "       environment that this script does not support." 1>&2;   echo 1>&2;   echo "A possible solution is to source this script while in the 'emsdk' directory." 1>&2;   echo 1>&2;   unset DIR;   return; fi
# Force emsdk to use bash syntax so that this works in windows + bash too
eval `EMSDK_BASH=1 $DIR/emsdk construct_env`
unset DIR
git clone https://github.com/Microsoft/vcpkg.git
.\vcpkg\bootstrap-vcpkg.bat
vcpkg install
vcpkg install
#!/bin/sh -e
# PCSX2 - PS2 Emulator for PCs
# Copyright (C) 2002-2011  PCSX2 Dev Team
#
# PCSX2 is free software: you can redistribute it and/or modify it under the terms
# of the GNU Lesser General Public License as published by the Free Software Found-
# ation, either version 3 of the License, or (at your option) any later version.
#
# PCSX2 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
# without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along with PCSX2.
# If not, see <http://www.gnu.org/licenses/>.
# This script is a small wrapper to the PCSX2 exectuable. The purpose is to
# 1/ launch PCSX2 from the same repository every times.
# Rationale: There is no guarantee on the directory when PCSX2 is launched from a shortcut.
#            This behavior trigger the first time wizards everytime...
# 2/ Change LD_LIBRARY_PATH to uses 3rdparty library
# Rationale: It is nearly impossible to have the same library version on all systems. So the
#            easiest solution it to ship library used during the build.
current_script=$0
# We are already in the good directory. Allow to use "bash launch_pcsx2_linux.sh"
if [ $current_script = "launch_pcsx2_linux.sh" ]; then     if [ -e "./launch_pcsx2_linux.sh" ];     then         current_script="./launch_pcsx2_linux.sh";     fi; fi
[ $current_script = "launch_pcsx2_linux.sh" ] &&     echo "Error the script was either directly 'called' (ie launch_pcsx2_linux.sh)" &&     echo "Use either /absolute_path/launch_pcsx2_linux.sh or ./relative_path/launch_pcsx2_linux.sh" && exit 1;
# Note: sh (dash on debian) does not support pushd, popd...
# Save current directory
PWD_old=$PWD
# Go to the script directory
cd `dirname $current_script`
# Allow to ship .so library with the build to avoid version issue 
if [ -e 3rdPartyLibs ]; then     if [ -z $LD_LIBRARY_PATH ];     then         OLD_LD_LIBRARY_PATH="";         export LD_LIBRARY_PATH="./3rdPartyLibs";     else         OLD_LD_LIBRARY_PATH="$LD_LIBRARY_PATH";         export LD_LIBRARY_PATH="./3rdPartyLibs:$LD_LIBRARY_PATH";     fi ; fi
# Test plugin depencencies
if [ -x `which ldd` ]; then     for plugin in `find plugins -iname "lib*.so"`;     do         if [ `ldd $plugin | grep -c found` != 0 ];         then             echo "ERROR the plugin ($plugin) miss some dependencies";             echo "    `ldd $plugin | grep found`";             echo "";         fi;     done; fi
# Launch PCSX2
if [ -x pcsx2 ]; then     ./pcsx2 $@; else     echo "Error PCSX2 not found";     echo "Maybe the script was directly 'called'";     echo "Use either /absolute_path/launch_pcsx2_linux.sh or ./relative_path/launch_pcsx2_linux.sh";     exit 1; fi
# Be a good citizen. Restore the shell context
cd $PWD_old
if [ -z $OLD_LD_LIBRARY_PATH ]; then     unset LD_LIBRARY_PATH; else     export LD_LIBRARY_PATH="$OLD_LD_LIBRARY_PATH"; fi

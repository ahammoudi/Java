#!/bin/bash

# ###########################################################################
# Locations
# ###########################################################################
BASEDIR=`cd $(dirname $0); pwd`
WORKINGDIR=`pwd`
SCRIPT_NAME=`basename $0`

# Use TEST_ROOT for local testing
ROOT_DIR=${HOME}
[ ! -z ${TEST_ROOT} ] && ROOT_DIR=${TEST_ROOT}
DOWNLOAD_DIR=${ROOT_DIR}/download
INSTALL_DIR=${ROOT_DIR}/bin


# ###########################################################################
# Variables
# ###########################################################################
ORACLE_DOWNLOAD_COOKIE="Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie"

print_env() {
  cat << EOF
Build Environment Setup
-----------------------

Script                 $SCRIPT_NAME
Base directory         $BASEDIR
Working directory      $WORKINGDIR
Installation Root      $ROOT_DIR
Download directory     $DOWNLOAD_DIR
Installation directory $INSTALL_DIR

EOF
}

init() {
  echo "Creating directories"
  mkdir -vp ${DOWNLOAD_DIR}
  mkdir -vp ${INSTALL_DIR}

  echo "Initialization complete"
}

download_and_install_oracle_jdk() {
  jdk_major_version=$1
  jdk_minor_version=$2
  jdk_build_number=$3

  # JDK full version string as it appears in the download URL, e.g. 8u40-b26
  jdk_full_version_string=${jdk_major_version}u${jdk_minor_version}-b${jdk_build_number}

  # JDK version string as it appears in the archive name
  jdk_version_string=${jdk_major_version}u${jdk_minor_version}

  # JDK version number as it appears within the archive, e.g. 1.8.0_40
  archive_version="1.${jdk_major_version}.0_${jdk_minor_version}"

  # Final name of the downloaded file and of the installation folder
  final_name="oracle-jdk-${archive_version}"

  download_url=http://download.oracle.com/otn-pub/java/jdk/${jdk_full_version_string}/jdk-${jdk_version_string}-linux-x64.tar.gz
  download_target=${DOWNLOAD_DIR}/oracle-jdk-${jdk_version_string}.tar.gz

  if [ ! -d $INSTALL_DIR/${final_name} ]; then

    # Download if necessary
    if [ ! -f ${download_target} ]; then
      echo "Downloading ${final_name}"
      curl --create-dirs -o ${download_target} -LH "${ORACLE_DOWNLOAD_COOKIE}" "${download_url}"
    else
      echo "${download_target} does already exist. No need to download."
    fi

    # Extract and install
    echo "Extracting ${download_target} to ${INSTALL_DIR}"
    tar --overwrite -zxf ${download_target} -C ${INSTALL_DIR}

    echo "Rename to ${final_name}"
    mv -f ${INSTALL_DIR}/jdk${archive_version} ${INSTALL_DIR}/${final_name}
  else
    echo "${INSTALL_DIR}/${final_name} does already exist. Nothing to install."
  fi

  echo "Installation of ${final_name} completed."

}

# ###########################################################################
# Main
# ###########################################################################

print_env
init
download_and_install_oracle_jdk "8" "40" "26"

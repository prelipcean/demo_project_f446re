#!/bin/bash
# Build project script for CMake projects

echo "Welcome to build project script for CMake projects"
echo ""

# Variables
OUTPUT_DIR="./out/"
OUTPUT_RELEASE_DIR="./out/release/"
OUTPUT_DEBUG_DIR="./out/debug/"
OUTPUT_ECLIPSE_DIR="./out/eclipse/"

# Functions
cmakeRelease()
{
	# Create makefiles for MinGW
	if [ -d "$OUTPUT_RELEASE_DIR" ]; then
	  # Take action if $OUTPUT_RELEASE_DIR exists
	  echo "Running cmake ... output dir is: ${OUTPUT_RELEASE_DIR}"
	  cmake $1 -S . -B $OUTPUT_RELEASE_DIR -DCMAKE_BUILD_TYPE=RELEASE -G "MinGW Makefiles" 
	else
	  # Control will jump here if $OUTPUT_RELEASE_DIR does NOT exists
	  echo "Info: ${OUTPUT_RELEASE_DIR} not found. Directory will be created."
	  mkdir -p  $OUTPUT_RELEASE_DIR
	  sleep 0.5 # Waits 0.5 seconds
	  echo "Running cmake ... output dir is: ${OUTPUT_RELEASE_DIR}"
	  cmake $1 -S . -B $OUTPUT_RELEASE_DIR -DCMAKE_BUILD_TYPE=RELEASE -G "MinGW Makefiles"
	fi
}

cmakeDebug()
{
	# Create makefiles for MinGW
	if [ -d "$OUTPUT_DEBUG_DIR" ]; then
	  # Take action if $OUTPUT_DEBUG_DIR exists
	  echo "Running cmake ... output dir is: ${OUTPUT_DEBUG_DIR}"
	  cmake $1 -S . -B $OUTPUT_DEBUG_DIR -DCMAKE_BUILD_TYPE=DEBUG -G "MinGW Makefiles"
	else
	  # Control will jump here if $OUTPUT_DEBUG_DIR does NOT exists
	  echo "Info: ${OUTPUT_DEBUG_DIR} not found. Directory will be created."
	  mkdir -p  $OUTPUT_DEBUG_DIR
	  sleep 0.5 # Waits 0.5 seconds
	  echo "Running cmake ... output dir is: ${OUTPUT_DEBUG_DIR}"
	  cmake $1 -S . -B $OUTPUT_DEBUG_DIR -DCMAKE_BUILD_TYPE=DEBUG -G "MinGW Makefiles"
	fi
}

cmakeEclipse()
{
	# Create makefiles for Eclipse
	if [ -d "$OUTPUT_ECLIPSE_DIR" ]; then
	  # Take action if $OUTPUT_ECLIPSE_DIR exists
	  echo "Running cmake ... output dir is: ${OUTPUT_ECLIPSE_DIR}"
	  cmake $1 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_ECLIPSE_GENERATE_LINKED_RESOURCES=TRUE -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 -S . -B $OUTPUT_ECLIPSE_DIR -G "Eclipse CDT4 - MinGW Makefiles"
	else
	  # Control will jump here if $OUTPUT_ECLIPSE_DIR does NOT exists
	  echo "Info: ${OUTPUT_ECLIPSE_DIR} not found. Directory will be created."
	  mkdir -p  $OUTPUT_ECLIPSE_DIR
	  sleep 0.5 # Waits 0.5 seconds
	  echo "Running cmake ... output dir is: ${OUTPUT_ECLIPSE_DIR}"
	  cmake $1 -DCMAKE_BUILD_TYPE=Debug -DCMAKE_ECLIPSE_GENERATE_LINKED_RESOURCES=TRUE -DCMAKE_ECLIPSE_GENERATE_SOURCE_PROJECT=TRUE -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 -S . -B $OUTPUT_ECLIPSE_DIR -G "Eclipse CDT4 - MinGW Makefiles"
	fi
}

# Main
if [ $# -eq 0 ]
  then
    echo "Error: No arguments supplied, script will exit!"
	echo "Arguments are: "
	echo "release = to build the make files for release"
	echo "debug = to build the make files for debug"
	echo "eclipse = to build the make files for eclipse"
	echo "cleanR = to delete release folder"
	echo "cleanD = to delete debug folder"
	echo "cleanE = to delete eclipse folder"
	echo "cleanAll = to delete all folders in output directory"
	exit 1
fi

if [ "$1" == "release" ]
  then
	cmakeRelease
	echo ""	
	
  elif  [ "$1" == "debug" ]
	then
	cmakeDebug
	echo ""
	
  elif  [ "$1" == "eclipse" ]
	then
	cmakeEclipse
	echo ""
	
  elif  [ "$1" == "cleanR" ]
	then
	echo "Deleting release folder."
	rm -rf $OUTPUT_RELEASE_DIR

  elif  [ "$1" == "cleanD" ]
	then
	echo "Deleting debug folder."
	rm -rf $OUTPUT_DEBUG_DIR

  elif  [ "$1" == "cleanE" ]
	then
	echo "Deleting eclipse folder."
	rm -rf $OUTPUT_ECLIPSE_DIR

  elif  [ "$1" == "cleanAll" ]
	then
	echo "Deleting out folder."
	rm -rf $OUTPUT_DIR

  else
	echo "Error: Arguments supplied is not valid, script will exit!"
	exit 1
fi

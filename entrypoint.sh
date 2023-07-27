#!/bin/bash
set -e

INPUT_PUML_VERSION="${1}"
INPUT_PY2PUML_VERSION="${2}"
INPUT_PATH="${3}"
INPUT_MODULE="${4}"
INPUT_OUTPUT_DIR="${5}"


if [ "$INPUT_PY2PUML_VERSION" = "latest" ]; then
	pip install py2puml --upgrade
else
	pip install py2puml=="${INPUT_PY2PUML_VERSION}"
fi

mkdir -p "${INPUT_OUTPUT_DIR}"
py2puml "${INPUT_PATH}" "${INPUT_MODULE}" > "${INPUT_OUTPUT_DIR}"/"${INPUT_MODULE}".puml

# Check if a PUML file is found at the expected location
if [ ! -f "${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.puml" ]; then
	echo "File not found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.puml"
	exit 1
else
	echo "File found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.puml"
fi


if [ "$INPUT_PUML_VERSION" = "latest" ]; then
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.jar/download"
else
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.${INPUT_PUML_VERSION}.jar/download"
fi

java -jar /tmp/plantuml.jar "${INPUT_OUTPUT_DIR}"/"${INPUT_MODULE}".puml -o ../"${INPUT_OUTPUT_DIR}"


# Check if a PUML file is found at the expected location
if [ ! -f "${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.png" ]; then
	echo "File not found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.png"
	exit 1
else
	echo "File found: ${INPUT_OUTPUT_DIR}/${INPUT_MODULE}.png"
fi

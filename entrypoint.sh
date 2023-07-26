#!/bin/sh -l

INPUT_OUTPUT_DIR="${1}"
INPUT_PATH="${2}"
INPUT_MODULE="${3}"
INPUT_PY2PUML_VERSION="${4}"


if [ "$INPUT_PY2PUML_VERSION" = "latest" ]; then
	pip install py2puml
else
	pip install py2puml=="${INPUT_PY2PUML_VERSION}"
fi

mkdir -p "${INPUT_OUTPUT_DIR}"
py2puml "${INPUT_PATH}" "${INPUT_MODULE}" > "${INPUT_OUTPUT_DIR}"/"${INPUT_MODULE}".puml

if [ -z "$INPUT_VERSION" ]; then
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.jar/download"
else
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.${INPUT_PUML_VERSION}.jar/download"
fi

java -jar /tmp/plantuml.jar "${INPUT_OUTPUT_DIR}"/"${INPUT_MODULE}".puml -o ../"${INPUT_OUTPUT_DIR}"

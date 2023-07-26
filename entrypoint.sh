#!/bin/sh -l

INPUT_PUML_OUTPUT_PATH="${1}"
INPUT_PATH="${2}"
INPUT_MODULE="${3}"
INPUT_PY2PUML_VERSION="${4}"


if [ -z "$INPUT_PY2PUML_VERSION" ]; then
	pip install py2puml
else
	pip install py2puml=="${INPUT_PY2PUML_VERSION}"
fi

py2puml "${INPUT_PATH}" "${INPUT_MODULE}" > "${INPUT_PUML_OUTPUT_PATH}"
cat test_diagram.puml

if [ -z "$INPUT_VERSION" ]; then
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.jar/download"
else
	wget -O /tmp/plantuml.jar "http://sourceforge.net/projects/plantuml/files/plantuml.${INPUT_PUML_VERSION}.jar/download"
fi

java -jar /tmp/plantuml.jar test_diagram.puml

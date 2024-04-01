#!/bin/bash
#
# 2019-07-11
# philipp.freimann@bbw.ch
#
# Create all TeX-Relevant files (index, bibliography)
# and rebuild the pdf.
#

echo "ECHO Starting MAKE-TRAINER and no TRAINER"

export FRAMEWORK_BIN_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
echo "Layout Dir: ${FRAMEWORK_BIN_DIR}"

echo "Caller Dir (make_dir): ${MAKE_DIR}"

export TEX_LAYOUT_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )
echo "Layout Dir: ${TEX_LAYOUT_DIR}"

TEX_LAYOUT_DIR=`realpath ${TEX_LAYOUT_DIR}/..`
echo "Layout Dir: ${TEX_LAYOUT_DIR}"

TEX_MAIN_PARENT=`realpath "${TEX_LAYOUT_DIR}/../cnt"`

echo "Tex main Parent: ${TEX_MAIN_PARENT}"

##export BBW_KAPITEL_DIR=${TEX_MAIN_PARENT}/includes/kapitel
## neu ab Dez. 2020: nur noch die neuen Unterverzeichnisse in "thema" untersuchen.
export BBW_THEMA_DIR=${TEX_MAIN_PARENT}/thema
echo "BBW_THEMA_DIR = ${BBW_THEMA_DIR}"

export BBW_PRUEFUNGS_AUFGABEN_DIR=`realpath ${TEX_MAIN_PARENT}/../pruefungen/aufgaben`
echo "BBW_PRUEFUNGS_AUFGABEN_DIR = ${BBW_PRUEFUNGS_AUFGABEN_DIR}"

##export BBW_REPETITIONS_AUFGABEN_DIR=${TEX_MAIN_PARENT}/includes/repetition

##declare -x TEXINPUTS="${MAKE_DIR}:${TEX_LAYOUT_DIR}:${BBW_PRUEFUNGS_AUFGABEN_DIR}:${BBW_REPETITIONS_AUFGABEN_DIR}:${BBW_KAPITEL_DIR}:${BBW_THEMA_DIR}:"

declare -x TEXINPUTS="${TEX_LAYOUT_DIR}:${BBW_PRUEFUNGS_AUFGABEN_DIR}:${BBW_KAPITEL_DIR}:${BBW_THEMA_DIR}:${MAKE_DIR}"

echo "Tex Inputs: ${TEXINPUTS}"

export POST_PROCESS_DIR=${MAKE_DIR}
export POST_PROCESS_COMMAND="post_process.sh"

. ${TEX_LAYOUT_DIR}/bin/makeAndRenamePDF.sh

ZIELGRUPPE=TRAINER_${ZIELGRUPPE}

${TEX_LAYOUT_DIR}/bin/makeAndRenamePDF.sh

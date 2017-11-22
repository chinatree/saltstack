#!/bin/bash 

# [global]
SCRIPT_PATH="$(cd "$(dirname "$0")"; pwd)"
SCRIPT_NAME="$(basename "$0")"
PROJECT_ROOT="$(cd "${SCRIPT_PATH}"; pwd)"
PARA_NUM="$#"

mongo_bin="/opt/mongodb/bin/mongod"
config_file="${1}"

test "${PARA_NUM}" -ne 1 && echo "[ ERROR ] Please config file para!" && exit 2

test ! -f "${config_file}" && echo "[ ERROR ] The config file ${config_file} not exists, please check it and try again!" && exit 2

proc_ins_pids=$(ps -ef | grep "mongod" | grep "${config_file}" | grep -v ${SCRIPT_NAME} | grep -v grep | awk '{print $2}')
if [ -z "${proc_ins_pids}" ];
then
    proc_num=0
else
    proc_num=$(echo ${proc_ins_pids} | wc -l)
fi
if [ "${proc_num}" -eq 0 ];
then
    ${mongo_bin} --config "${config_file}"
else
    echo "[ ERROR ] The mongod instance is running, please stop it and try again!"
    exit 2
fi

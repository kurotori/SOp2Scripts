#!/usr/bin/env bash

content=$(curl -L -s "https://api.generadordni.es/v2/text/words?words=1&language=es")
dato=$("${content//,// }")
echo "$dato"


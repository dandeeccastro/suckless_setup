#!/bin/bash

free -h | grep Mem | awk -F' ' '{ print $3"/"$2 }' | sed s/i//g

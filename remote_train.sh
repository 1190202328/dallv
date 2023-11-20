#!/bin/bash

bash /nfs/volume-902-16/tangwenbo/ofs-1.sh

cd /nfs/ofs-902-1/object-detection/jiangjing/experiments/dallv && HYDRA_FULL_ERROR=1 bash scripts/$1

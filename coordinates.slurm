#!/bin/bash
#
#SBATCH --job-name=COORDINATES_TENSORFLOW # Job name
#SBATCH --array=1
#SBATCH --time=02:00:00
#SBATCH --nodes=1
#SBATCH --ntasks=1 # Number of cores
#SBATCH --output=coordinates.out #File to which STDOUT will be written
#SBATCH --error=coordinates.err # File to which STDERR will be written
#SBATCH --mail-type=ALL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=erqueen@ucdavis.edu # Email to which notification will be sent 
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=50000

MASKRCNN_PYTHONPATH=/share/foxlab-backedup/monkeyface/anaconda3/bin/
export PATH=${MASKRCNN_PYTHONPATH}:$PATH

source activate tensorflow

protoc --proto_path=/share/foxlab-backedup/monkeyface/models/research --python_out=/share/foxlab-backedup/monkeyface/models/research/ /share/foxlab-backedup/monkeyface/models/research/object_detection/protos/*.proto
export PYTHONPATH=$PYTHONPATH:/share/foxlab-backedup/monkeyface/models/research:/share/foxlab-backedup/monkeyface/models/research/slim

pwd
which python
protoc --version

cd /share/foxlab-backedup/monkeyface/models/research/object_detection/coordinates_outputs/
pwd

printenv

python coordinates1.9.py 

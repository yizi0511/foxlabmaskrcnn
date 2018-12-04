#!/bin/bash
#
#SBATCH --job-name=MASK_TFGPU # Job name
#SBATCH --array=1
#SBATCH --nodes=1
#SBATCH --ntasks=1 # Number of cores
#SBATCH --output=mask_gpu_network.out #File to which STDOUT will be written
#SBATCH --error=mask_gpu_network.err # File to which STDERR will be written
#SBATCH --mail-type=ALL # Type of email notification- BEGIN,END,FAIL,ALL
#SBATCH --mail-user=yizzhang@ucdavis.edu
#SBATCH -p production
#SBATCH --time=2:00:00
#SBATCH --gres=gpu:1,cuda:7,gpu_mem:10000
#SBATCH --reservation=gpu_launch


hostname
nvidia-smi

MASKRCNN_PYTHONPATH=/share/foxlab-backedup/monkeyface/anaconda3/bin/
export PATH=${MASKRCNN_PYTHONPATH}:$PATH

source activate MaskRCNN
conda activate MaskRCNN

cd /share/foxlab-backedup/monkeyface/Mask/Mask_RCNN/samples/monkey/
pwd

echo "-------"

module load tensorflow-gpu

echo "-------"

which python
echo "-------" 
printenv

echo "-------" 

python3 monkey_gpu.py train --dataset=./dataset/ --weights=coco
#!/bin/bash
jobname=orthoprojections
dataset=Spheres1000
method=TopoRegEdgeSymmetric #TopoAEOrtho
output_path=exp_runs/hyperparameter_search/dimensionality_reduction/${dataset}/${method}
mkdir -p $output_path
output_log=${output_path}/ortho_run.log

config=projection_experiments/hyperparameter_search/dimensionality_reduction/${dataset}/${method}.json
sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 5G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv run python -m exp.hyperparameter_search -F ${output_path} with ${config}"


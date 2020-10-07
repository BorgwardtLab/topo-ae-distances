
jobname=TopoAE-ortho-projections
output_path=test_ortho
run=$1

mkdir -p $output_path

output_log={$output_path}/ortho_run_${run}.log

sbatch -J $jobname --cpus-per-task 2 --mem-per-cpu 5G -n 1 -p gpu -o $output_log -e $output_log --gres=gpu:1 --wrap "pipenv python -m exp.train_model -F {$output_path} with model.TopoAEOrthoSpheres dataset.Spheres"

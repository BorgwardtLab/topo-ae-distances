# Challenging Euclidean Topological Autoencoders

This is a follow-up project of the ICML 2020 paper "Topological Autoencoders" (reference below).
Here, we investigate whether domain-specific distance functions in the input space (here image datasets) are necessary for TopoAE, or whether a generic euclidean distance is sufficient. 
[This work](https://openreview.net/pdf?id=P3dZuOUnyEY) has been accepted for presentation at the Neurips 2020 TDA and Beyond workshop. 

## References

Please use the following BibTeX code to cite our original [paper](https://arxiv.org/abs/1906.00722),
which was presented at [ICML 2020](https://icml.cc/Conferences/2020):

```
@InProceedings{Moor19Topological,
  author        = {Moor, Michael and Horn, Max and Rieck, Bastian and Borgwardt, Karsten},
  title         = {Topological Autoencoders},
  year          = {2020},
  eprint        = {1906.00722},
  archiveprefix = {arXiv},
  primaryclass  = {cs.LG},
  booktitle     = {Proceedings of the 37th International Conference on Machine Learning~(ICML)},
  series        = {Proceedings of Machine Learning Research},
  publisher     = {PMLR},
  pubstate      = {forthcoming},
}
```  

## Setup
In order to reproduce the results indicated in the workshop paper simply setup an
environment using poetry: 
```bash
poetry install  
```

## Running the methods:
Make sure you have internet access once to be able to download the datasets, and also the vgg model (via the lpips package)

In case a slurm cluster is available, simply run:  
```bash  
source scripts/run_slurm.sh  
```  

Alternatively, all jobs can be sequentially/manually called using:  
```bash  
source scripts/run_manual.sh  
```  
 

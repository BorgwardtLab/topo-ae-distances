import torch
import torch.nn as nn
import lpips

class PerceptualLoss(nn.Module):
    """
    Perceptual Loss function module, which returns perceptual loss distance matrix for a given input batch
    """
    def __init__(self, device='cuda:0', net='alex', **kwargs):
        super(PerceptualLoss, self).__init__(**kwargs)
        self.loss_fn = lpips.LPIPS(net=net)
        self.device = device

    def forward(self, x):
        """
        Compute perceptual loss for each pair of samples of a batch to return a distance matrix
        """
        #get triangular indices for computing a distance matrix
        n = x.shape[0]
        inds = self._get_index_pairs(n)
        
        #broadcast data such that each pair of the batch is represented
        batch0 = x[inds[0]]  
        batch1 = x[inds[1]]

        #compute loss/distance pair-wise on the batch level
        loss = self.loss_fn(batch0, batch1) 
        loss = loss.view(loss.shape[0])

        #reshape output into a proper distance matrix
        D = self._batch_to_matrix(loss, inds, n)
        return D 

    def _get_index_pairs(self, n):
        """
        return all pairs of indices of two 1d index tensors
        """
        inds = torch.triu_indices(n, n)
        return inds
    
    def _batch_to_matrix(self, x, inds, n):
        """
        Reshape batched result to distance matrix
        """
        D = torch.zeros(n, n, dtype=torch.float32, device=self.device)
        D[inds[0], inds[1]] = x
        return self._triu_to_full(D)

    def _triu_to_full(self, D):
        """
        Convert triu (upper triangular) matrix to full, symmetric matrix.
        Assumes square input matrix D
        """
        diagonal = torch.eye(D.shape[0], dtype=torch.float32, 
                device=self.device) * torch.diag(D) #eye matrix with diagonal entries of D 
        D = D + D.T - diagonal # add transpose minus diagonal values 
        # to move from upper triangular to full matrix 
        return D

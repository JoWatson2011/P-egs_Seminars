

def do_pca(X_df, n_components=20, centered=True):

    import numpy as np
    import pandas as pd
    from sklearn.decomposition import PCA
    
    '''
        Return:
            W: PCA loadings for each feature (how much each feature contributes to each PC)
            Xproj: projected data in PCA space (component scores, reduced dimension representation of data)
            fracs: Fraction of data explained by each principal component in a vector
    '''
    n_features = X_df.shape[1] # Original data dimension (no of features)
    if n_components > n_features:
        n_components = n_features
    if isinstance(X_df, pd.DataFrame):
        X = X_df.values # Get the data matrix from the X_df dataframe
    if centered:            
        X = X.astype('float')  # Since X is object
        X = X - X.mean(0)
        X = X/X.std(0)
    pca = PCA(n_components=n_components) # run the PCA algorithm from sklearn on data X
    pca.fit(X)
    fracs = pca.explained_variance_ratio_  # vector with explained variance for each principal component (PC)
    Xproj = pca.fit_transform(X)   # Low-dim projection (aka Scores) - n_sample, n_redim
    W = pca.components_            # PC Loadings - n_redim, n_feature
    # construct two DataFrames for later use
    # Loadings in a dataframe
    W_df = pd.DataFrame(W, index=['PC' + str(i) for i in np.arange(1, W.shape[0]+1)], columns=X_df.columns.values)
    # Low-dimensional projection of data in a dataframe
    Xproj_df = pd.DataFrame(Xproj, index=X_df.index, columns=['PC'+str(i) for i in np.arange(1, Xproj.shape[1]+1)])
    return W_df, Xproj_df, fracs



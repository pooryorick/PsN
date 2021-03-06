model=pheno_with_cov.mod
linearize=1
search_direction=backward
p_forward=0.05
p_backward=0
retries=3

continuous_covariates=WGT,APGR,CV1,CV2,CV3
categorical_covariates=CVD1,CVD2,CVD3

[test_relations]
;ETA1
CL=WGT,CVD1
;ETA2
V=WGT,CVD1

[valid_states]
continuous = 1,2,4
categorical = 1,2

[included_relations]
CL=WGT-2
V=WGT-2
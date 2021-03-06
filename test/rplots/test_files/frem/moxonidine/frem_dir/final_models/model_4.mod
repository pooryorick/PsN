$PROBLEM    MOXONIDINE PK,FINAL ESTIMATES,SIMULATED DATA
;;

;; run 1, FOCEI, Lag model, all data

;;
$INPUT      ID VISI DROP DGRP DOSE DROP DROP DROP DROP NEUY SCR AGE
            SEX NYH WT DROP ACE DIG DIU DROP TAD TIME DROP CRCL AMT SS
            II DROP DROP DROP DV DROP DROP MDV FREMTYPE
$DATA      ../frem_dataset.dta IGNORE=@
$SUBROUTINE ADVAN2 TRANS1
$PK   

;---------- PK model ------------------

   TVCL  = THETA(1)
   TVV   = THETA(2)

   CL    = TVCL*EXP(ETA(1))
   V     = TVV*EXP(ETA(2))
   KA    = THETA(3)*EXP(ETA(3))
   ALAG1 = THETA(4)
   K     = CL/V
   S2    = V

$ERROR   

     IPRED = LOG(.025)
     WA     = THETA(5)
     W      = WA
     IF(F.GT.0) IPRED = LOG(F)
     IRES  = IPRED-DV
     IWRES = IRES/W
     Y     = IPRED+ERR(1)*W

;;;FREM CODE BEGIN COMPACT
;;;DO NOT MODIFY
     IF (FREMTYPE.EQ.100) THEN
;       AGE  7.82226906804
        Y = THETA(6) + ETA(4)*7.82226906804 + EPS(2)
        IPRED = THETA(6) + ETA(4)*7.82226906804
     END IF
     IF (FREMTYPE.EQ.200) THEN
;       NEUY  1854.50594596
        Y = THETA(7) + ETA(5)*1854.50594596 + EPS(2)
        IPRED = THETA(7) + ETA(5)*1854.50594596
     END IF
     IF (FREMTYPE.EQ.300) THEN
;       CRCL  21.8088189384
        Y = THETA(8) + ETA(6)*21.8088189384 + EPS(2)
        IPRED = THETA(8) + ETA(6)*21.8088189384
     END IF
     IF (FREMTYPE.EQ.400) THEN
;       SEX  0.404756978659
        Y = THETA(9) + ETA(7)*0.404756978659 + EPS(2)
        IPRED = THETA(9) + ETA(7)*0.404756978659
     END IF
;;;FREM CODE END COMPACT
$THETA  (0,32.8662) ; TVCL
$THETA  (0,21.0303) ; TVV
$THETA  (0,0.291996) ; TVKA
$THETA  (0,0.0991633) ; LAG
$THETA  (0,0.33452) ; RES ERR
$THETA  65.1756756757 FIX ; TV_AGE
 2698.56756757 FIX ; TV_NEUY
 67.7297297297 FIX ; TV_CRCL
 1.2027027027 FIX ; TV_SEX
$OMEGA  BLOCK(7)
 0.408722  ;     IIV CL
 0.00671112 1.10195  ;      IIV V
 0.00291392 0.0047846 0.207744  ;     IIV KA
 -0.0799948 -0.211593 0.0256951 0.986456  ;    BSV_AGE
 -0.0455003 -0.100835 -0.0722142 0.214764 0.986516  ;   BSV_NEUY
 0.00639171 -0.0385912 0.0503848 -0.463915 -0.158876 0.986506  ;   BSV_CRCL
 0.0883424 0.21761 0.04196 -0.11369 -0.312661 -0.224976 0.986635  ;    BSV_SEX
$SIGMA  1  FIX
$SIGMA  1e-07  FIX  ;     EPSCOV
$ESTIMATION METHOD=1 MAXEVALS=9999 NONINFETA=1
$COVARIANCE PRINT=E


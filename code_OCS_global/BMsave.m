% BM save
cw(:,:,tstep)=cwnew;
PPtot(:,:,tstep)=PP;
DPtot(:,:,tstep)=DP;
HYtot(:,:,tstep)=HY;
EXtot(:,:,tstep)=EX;

if tstep==len
  cwocs(:,:,month)=nanmean(cw,3);
  cwday(:,:,:,month)=cw(:,:,156:167);
  exday(:,:,:,month)=EXtot(:,:,156:167);
  dpday(:,:,:,month)=DPtot(:,:,156:167);
  hyday(:,:,:,month)=HYtot(:,:,156:167);
  ppday(:,:,:,month)=PPtot(:,:,156:167);
  PPtotmonth(:,:,month)=nanmean(PPtot,3);
  DPtotmonth(:,:,month)=nanmean(DPtot, 3);
  HYtotmonth(:,:,month)=nanmean(HYtot, 3);
  EXtotmonth(:,:,month)=nanmean(EXtot,3);
end

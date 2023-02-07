function  [MtA,MtB]=rest_state(winPt,t1,t0,n,dt)
p9=imread('9.JPG');
p9=Screen('MakeTexture',winPt,p9);
Screen('DrawTextures',winPt,p9,[],[]);
Screen('Flip',winPt);
pause(t0);
KbWait
p1=imread('1.JPG');
p1=Screen('MakeTexture',winPt,p1);
if n==1
    MtA=fNIRT(10,3,dt.ID(1));
elseif n==2
    MtA=fNIRT(20,3,dt.ID(1));
elseif n==3
    MtA=fNIRT(30,3,dt.ID(1));
end
Screen('DrawTextures',winPt,p1,[],[]);
Screen('Flip',winPt);
pause(t1);
if n==1
    MtB=fNIRT(11,3,dt.ID(1));
elseif n==2
    MtB=fNIRT(21,3,dt.ID(1));
elseif n==3
    MtB=fNIRT(31,3,dt.ID(1));
end
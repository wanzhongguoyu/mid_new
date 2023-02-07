        
clear
AssertOpenGL;
Screen('Preference','SkipSyncTests',1);
Screen('Preference','VisualDebugLevel',3);
Screen('Preference','SuppressAllWarnings',1);

KbName('UnifyKeyNames');
spaceKey = KbName('Space');
qKey = KbName('Q');
    

ID = inputdlg({'ID'},'ID',1);
Gender= inputdlg({'Gender'},'Gender',1);

tr=10;
trr=40; 

k=1;
t0=5;t1=0.300*k;t2=3*k;t3=1*k;t4=1*k;t5=1*k;t6=rand+1;t7=0.28;%(反应时)
t8=4;t9=2*k;t10=7*k;t11=10*k;

ID = transpose(str2double(cell2mat(ID)))*ones((tr+4*trr),1);
Gender= transpose(str2double(cell2mat(Gender)))*ones((tr+4*trr),1);
Date = repmat(datestr(now,30),(tr+4*trr),1);
Mark=ones((tr+4*trr),1);
time=zeros((tr+4*trr),1);
te=zeros((tr+4*trr),1);
acc=zeros((tr+4*trr),1);
ptc=zeros((tr+4*trr),1);
rule=zeros((tr+4*trr),1);
money=zeros((tr+4*trr),1);
dt= table(ID,Gender,Date,rule,time,acc,money,ptc,te);

z1=ones(tr/2,1)+10;z2=zeros(tr/2,1)+10;c=randperm(tr)';z=[z1;z2];z=[z c];z=sortrows(z,2);z=z(:,1);
a1=ones(trr,1)+100;a2=zeros(trr,1)+100;
b1=ones(trr,1)+200;b2=zeros(trr,1)+200;
a=[a1;a2];b=[b1;b2];
c=randperm(trr*2)';a=[a c];a=sortrows(a,2);a=a(:,1);
c=randperm(trr*2)';b=[b c];b=sortrows(b,2);b=b(:,1);
if rem(ID(1),2)~=0
    dt.rule=[z;a;b];
else
    dt.rule=[z;b;a];
end




[winPt,winRect]= Screen('OpenWindow',1,[125,125,125]);
SC =[winRect(3),winRect(4)];
Xmax=SC(1);
Ymax=SC(2);
l1=[0 0 Xmax Ymax];
l2=[0.3*Xmax,0.35*Ymax 0.7*Xmax,0.65*Ymax];
l3=[0.45*Xmax,0.45*Ymax];
l4=[0.47*Xmax,0.45*Ymax];
l5=[0.48*Xmax,0.45*Ymax];
l6=[0.385*Xmax,0.7*Ymax];
l7=[0.565*Xmax,0.7*Ymax];
l8=[0.3*Xmax,0.28*Ymax,0.7*Xmax,0.72*Ymax];
% HideCursor;

dis_picture = dir([cd,'\*.JPG']);
for i = 1:length(dis_picture)
    Path_picture{i}=[cd,'\',int2str(i ),'.JPG'];
    im{i}=imread(Path_picture{1,i});
    maketesture{i}= Screen('MakeTexture',winPt,im{1,i});
end
maketesture=cell2mat(maketesture);
mt=[];
%[MtA,MtB]=rest_state(winPt,t1,t0,1,dt);
% mt=[mt;MtA;MtB];
%% exercise
money1=1000;money2=0;pay=-2;totalmoney=double('总钱数=');
text1= double(num2str( money1));
text2=double(num2str( money2));
text3=double(num2str( pay));
text4=totalmoney;
Screen('TextSize',winPt, 70);
Screen('TextColor',winPt,[225 225 225]);

h=0;
for f=1:20
    if h==0
        Screen('DrawTextures',winPt,maketesture(1,2),[],l1);
        Screen('Flip',winPt);
        pause(t2)
        KbWait
        
        if rem(dt.rule(i),2)~=0
            Screen('DrawText',winPt,text1,l3(1),l3(2));
            dt.money(1)=money1;
        else
            Screen('DrawText',winPt,text2,l4(1),l4(2));
            dt.money(1)=money2;
        end
        Screen('Flip',winPt);
        pause(t3)
        for i=1:tr
            Screen('DrawText',winPt,text3,l5(1),l5(2));
            if i~=1
                dt.money(i)=dt.money(i-1)+pay;
            else
                dt.money(i)=dt.money(i)+pay;
            end
            Screen('Flip',winPt);
            pause(t4)
            
            if rem(dt.rule(i),2)~=0
                Screen('DrawTextures',winPt,maketesture(1,3),[],l8);
            else
                Screen('DrawTextures',winPt,maketesture(1,4),[],l8);
            end
            Screen('Flip',winPt);
            pause(t5)
            
            Screen('DrawTextures',winPt,maketesture(1,1),[],l1);
            Screen('Flip',winPt);
            t6=rand+1;
            pause(t6*k)
            
            Screen('DrawTextures',winPt,maketesture(1,5),[],l1);
            [~,SOT]=Screen('Flip',winPt);
            
            while true
                [KeyisDown, secs,keyCode]= KbCheck;
                dt.time(i)= secs-SOT;
                if dt.time(i)>t7
                    KeyisDown = 0;
                    break;
                elseif keyCode(spaceKey)== 1
                    KeyisDown = 1;
                    a=1;
                    break;
                end
            end
            
            if KeyisDown==1
                if dt.time(i)<t7
                    if keyCode(spaceKey)== 1
                        dt.acc(i)=1;
                    end
                end
            end
            if dt.acc(i)==1&&rem(dt.rule(i),2)~=0
                dt.money(i)=dt.money(i)+10;
                text6=double('+10');
            else
                text6=double('+0');
            end
            
            
            Screen('DrawTextures',winPt,maketesture(1,1),[],l1);
            Screen('Flip',winPt);
            t8=4-secs+SOT-t6;
            pause(t8*k)
            
            Screen('DrawText',winPt,text4,l6(1),l6(2));
            text5=double(num2str(dt.money(i)));
            Screen('DrawText',winPt,text5,l7(1),l7(2));
            Screen('DrawText',winPt,text6,l5(1),l5(2));
            Screen('Flip',winPt);
            pause(t9)
            
            
            if i~=tr
                Screen('DrawTextures',winPt,maketesture(1,6),[],l1);
                Screen('Flip',winPt);
                pause(t10)
            else
                Screen('DrawTextures',winPt,maketesture(1,10),[],l1);
                Screen('Flip',winPt);
                pause(t11)
                KbWait
                [KeyisDown,secs,keyCode]= KbCheck;
                if KeyisDown
                    if keyCode(qKey)== 1
                        h=1;
                        break
                    end
                end
            end
        end
    end
end






%[MtA,MtB]=rest_state(winPt,t1,t0,2,dt);
% mt=[mt;MtA;MtB];
Screen('DrawTextures',winPt,maketesture(1,2),[],l1);
Screen('Flip',winPt);
pause(t2)
KbWait

for i=tr+1:tr+4*trr
    if i==1+tr+2*trr||i==tr+1
        if dt.rule(tr+1)>199
            Screen('DrawTextures',winPt,maketesture(1,11),[],l1);
            dt.money(tr+1)=money1;
            dt.money(tr+1+2*trr)=money2;
        else
            Screen('DrawTextures',winPt,maketesture(1,12),[],l1);
            dt.money(tr+1)=money2;
            dt.money(tr+1+2*trr)=money1;    
        end  
        if i==1+tr+2*trr
            if dt.money(tr+1+2*trr)==money2
                 Mt0=fNIRT(1,3,dt.ID(1));
            elseif dt.money(tr+1+2*trr)==money1
                 Mt0=fNIRT(100,3,dt.ID(1));
            end
        end
        if i==1+tr
            if dt.money(tr+1)==money2
                 Mt0=fNIRT(1,3,dt.ID(1));
            elseif dt.money(tr+1)==money1
                 Mt0=fNIRT(100,3,dt.ID(1));
            end
        end
        
        
        Screen('Flip',winPt);
        pause(t2)
        KbWait
    end
    
    if i==1+tr+2*trr||i==tr+1
        if dt.rule(tr+1)>199
            Screen('DrawText',winPt,text1,l3(1),l3(2));
        else
            Screen('DrawText',winPt,text2,l4(1),l4(2));
        end
        Screen('Flip',winPt);
        mt=[mt;Mt0];
        pause(t3)
    end
    
    Screen('DrawText',winPt,text3,l5(1),l5(2));
    if i~=tr+1&&i~=1+tr+2*trr
        dt.money(i)=dt.money(i-1)+pay;
    else
        dt.money(i)=dt.money(i)+pay;
    end
    Screen('Flip',winPt);
    pause(t4)
    
    if rem(dt.rule(i),2)~=0
        Screen('DrawTextures',winPt,maketesture(1,3),[],l8);
        if dt.rule(i)==201
            Mt0=fNIRT(40,3,dt.ID(1));
        elseif dt.rule(i)==200
            Mt0=fNIRT(50,3,dt.ID(1));
        elseif dt.rule(i)==101
            Mt0=fNIRT(60,3,dt.ID(1));
        elseif dt.rule(i)==100
            Mt0=fNIRT(70,3,dt.ID(1));
        end
        
    else
        Screen('DrawTextures',winPt,maketesture(1,4),[],l8);
        if dt.rule(i)==201
            Mt0=fNIRT(41,3,dt.ID(1));
        elseif dt.rule(i)==200
            Mt0=fNIRT(51,3,dt.ID(1));
        elseif dt.rule(i)==101
            Mt0=fNIRT(61,3,dt.ID(1));
        elseif dt.rule(i)==100
            Mt0=fNIRT(71,3,dt.ID(1));
        end
    end
    
    
    Screen('Flip',winPt);
    pause(t5)
    
    Screen('DrawTextures',winPt,maketesture(1,1),[],l1);
    if dt.rule(i)==201
        Mt1=fNIRT(42,3,dt.ID(1));
    elseif dt.rule(i)==200
        Mt1=fNIRT(52,3,dt.ID(1));
    elseif dt.rule(i)==101
        Mt1=fNIRT(62,3,dt.ID(1));
    elseif dt.rule(i)==100
        Mt1=fNIRT(72,3,dt.ID(1));
    end
    Screen('Flip',winPt);
    t6=rand+1;
    pause(t6*k)
    
    Screen('DrawTextures',winPt,maketesture(1,5),[],l1);
    [~,SOT]=Screen('Flip',winPt);
    
    if i==tr+2*trr+1
        t7=0.28;
    end
    
    while true
        [KeyisDown, secs,keyCode]= KbCheck;
        dt.time(i)= secs-SOT;
        if dt.time(i)>t7
            KeyisDown = 0;
            break;
        elseif keyCode(spaceKey)== 1
            KeyisDown = 1;
            break;
        end
    end
    
    if KeyisDown==1
        if dt.time(i)<t7
            if keyCode(spaceKey)== 1
                dt.acc(i)=1;
                if dt.rule(i)==201
                    Mt2=fNIRT(43,3,dt.ID(1));
                elseif dt.rule(i)==200
                    Mt2=fNIRT(53,3,dt.ID(1));
                elseif dt.rule(i)==101
                    Mt2=fNIRT(63,3,dt.ID(1));
                elseif dt.rule(i)==100
                    Mt2=fNIRT(73,3,dt.ID(1));
                end
            else
                if dt.rule(i)==201
                    Mt2=fNIRT(44,3,dt.ID(1));
                elseif dt.rule(i)==200
                    Mt2=fNIRT(54,3,dt.ID(1));
                elseif dt.rule(i)==101
                    Mt2=fNIRT(64,3,dt.ID(1));
                elseif dt.rule(i)==100
                    Mt2=fNIRT(74,3,dt.ID(1));
                end
            end
        end
    else
        if dt.rule(i)==201
            Mt2=fNIRT(44,3,dt.ID(1));
        elseif dt.rule(i)==200
            Mt2=fNIRT(54,3,dt.ID(1));
        elseif dt.rule(i)==101
            Mt2=fNIRT(64,3,dt.ID(1));
        elseif dt.rule(i)==100
            Mt2=fNIRT(74,3,dt.ID(1));
        end
    end
    if i<tr+1+2*trr
        if dt.acc(i)== 1
            aacc =(sum(dt.acc(tr+1:tr+4*trr)))/(i-tr);
            if aacc> 0.66
                if t7>=0.08
                    t7 = 0.9*t7;
                end
            end
        else
            aacc =(sum(dt.acc(tr+1:tr+4*trr)))/(i-tr);
            if aacc < 0.66
                if t7<=0.32
                    t7 = 1.1*t7;
                end
            end
        end
    end
    
    if i>tr+2*trr
        if dt.acc(i)== 1
            aacc =(sum(dt.acc(1+tr+2*trr:tr+4*trr)))/(i-tr-2*trr);
            if aacc> 0.66
                if t7>=0.08
                    t7 = 0.9*t7;
                end
            end
        else
            aacc =(sum(dt.acc(1+tr+2*trr:tr+4*trr)))/(i-tr-2*trr);
            if aacc < 0.66
                if t7<=0.32
                    t7 = 1.1*t7;
                end
            end
        end
    end
    
    dt.ptc(i)=aacc;
    dt.te(i)=t7;
    if dt.acc(i)==1&&rem(dt.rule(i),2)~=0
        dt.money(i)=dt.money(i)+10;
        text6=double('+10');
    else
        text6=double('+0');
    end
    Screen('DrawTextures',winPt,maketesture(1,1),[],l1);
    Screen('Flip',winPt);
    
    t8=4-secs+SOT-t6;
    pause(t8*k)
    if dt.rule(i)==201
        Mt4=fNIRT(45,3,dt.ID(1));
    elseif dt.rule(i)==200
        Mt4=fNIRT(55,3,dt.ID(1));
    elseif dt.rule(i)==101
        Mt4=fNIRT(65,3,dt.ID(1));
    elseif dt.rule(i)==100
        Mt4=fNIRT(75,3,dt.ID(1));
    end
    
    
    
    mt=[mt;Mt0;Mt1;Mt2;Mt4];
    Screen('DrawText',winPt,text4,l6(1),l6(2));
    text5=double(num2str(dt.money(i)));
    Screen('DrawText',winPt,text5,l7(1),l7(2));
    Screen('DrawText',winPt,text6,l5(1),l5(2));
    Screen('Flip',winPt);
    pause(t9)
    
    if i~=tr+2*trr
        Screen('DrawTextures',winPt,maketesture(1,6),[],l1);
        Screen('Flip',winPt);
        pause(t10)
    elseif i==tr+4*trr
        Screen('DrawTextures',winPt,maketesture(1,8),[],l1);
        Screen('Flip',winPt);
    elseif i==tr+2*trr
        Screen('DrawTextures',winPt,maketesture(1,7),[],l1);
        Screen('Flip',winPt);
        pause(t11)
        KbWait
    end
end
%[MtA,MtB]=rest_state(winPt,t1,t0,3,dt);
% mt=[mt;MtA;MtB];
Screen('CloseAll');
Path =[cd,'\'];
mkdir([Path,'D',num2str(dt.ID(1))]);
writetable(dt,[Path,'D',num2str(dt.ID(1)),'\',num2str(dt.ID(1)),'Dt.xlsx']);
writetable(mt,[Path,'D',num2str(dt.ID(1)),'\',num2str(dt.ID(1)),'Mt.xlsx']);
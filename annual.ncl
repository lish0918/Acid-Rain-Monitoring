begin
NS=(/"58448","58450","58452","58453","58457","58477","58549",\
    "58557","58633","58646","58659","58665","58742"/)   ;站点
;year=toint(systemfunc("date +%Y"))
;month=toint(systemfunc("date +%m"))
;time=systemfunc("date +%Y%m")
time="202006"
year=2020
month=6

sfre=0.   ;总降水次数
samp=0.0   ;有测ph值的总降水量
sam=0.0    ;总降水量
shar=0.   ;强酸雨次数
sar=0.    ;酸雨次数
srum=0    ;有测ph值的降水次数
ssh=0.
sk=0.0
do i=0,12,1
    fre=0.   ;总降水次数
    amp=0.0   ;有测ph值的总降水量
    am=0.0    ;总降水量
    har=0.   ;强酸雨次数
    ar=0.    ;酸雨次数
    rum=0    ;有测ph值的降水次数
    sh=0.
    k=0.0
    do ii=0,11,1
        if (ii.eq.month) then
            break
        end if
        file_path="../DATA/acid-rain/S"+NS(i)+"-"+tostring(year)+sprinti("%0.2i",ii+1)+".TXT"
        f=asciiread(file_path,-1,"string")
        data=f(2)
        count=toint(data(0))     ;降水次数
        str=f(4:count+3)   ;取得需要处理的数据

        ph= str_get_field(str, 9, " ")     ;ph值
        jiangshui=str_get_field(str, 4, " ")
        diandao=str_get_field(str, 13, " ")
        do m=0,count-1,1
            if (ph(m).ne."////") then
                PH=tofloat(ph(m))*0.01
                if (PH.gt.3.50) then
                    if (PH.lt.4.50) then
                        har=har+1
                        shar=shar+1
                    end if
                    if (PH.lt.5.65.and.PH.ge.4.50) then
                        ar=ar+1
                        sar=sar+1
                    end if
                    rum=rum+1   ;有检测ph值、k值的降水数
                    srum=srum+1
                    k=k+tofloat(diandao(m))*0.1
                    sk=sk+tofloat(diandao(m))*0.1
                    fre=fre+1
                    sfre=sfre+1
                    amp=amp+tofloat(jiangshui(m))*0.1
                    samp=samp+tofloat(jiangshui(m))*0.1
                    am=am+tofloat(jiangshui(m))*0.1
                    sam=sam+tofloat(jiangshui(m))*0.1

                    sh=sh+10^(-1*PH)*tofloat(jiangshui(m))*0.1
                    ssh=ssh+10^(-1*PH)*tofloat(jiangshui(m))*0.1
                end if
            end if 
            if (ph(m).eq."////") then
                fre=fre+1
                sfre=sfre+1
                am=am+tofloat(jiangshui(m))*0.1
                sam=sam+tofloat(jiangshui(m))*0.1
            end if
        end do
        delete(data)
        delete(f)
        delete(str)
        delete(ph)
        delete(jiangshui)
        delete(diandao)
    end do
    ;输出月降水量，降水次数，ph值，电导率，酸雨频率，强酸雨频率
    OutFileName="ANNUAL.txt"
    s=[/NS(i),time,am/ii,fre/ii,-log10(sh/amp),k/rum,ar/rum,har/rum/]
    write_table(OutFileName, "a", s, "%s%7s%7.1f%10.0f%10.2f%10.1f%10.3f%10.3f")
end do
l=[/"TOTAL",time,sam/(ii*13),sfre/(ii*13),-log10(ssh/samp),sk/srum,sar/srum,shar/srum/]
write_table(OutFileName, "a", l, "%s%7s%7.1f%10.0f%10.2f%10.1f%10.3f%10.3f")
write_table(OutFileName, "a", [/""/], "%s")
end
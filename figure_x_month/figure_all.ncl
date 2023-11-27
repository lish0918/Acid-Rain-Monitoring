f=asciiread("../MONTH.txt", -1, "string")
NS=(/"58448","58450","58452","58453","58457","58477","58549",\
    "58557","58633","58646","58659","58665","58742"/)

f_2=asciiread("figure_input.txt", -1, "string")
str_2=f_2(1:)
startt=str_get_field(str_2, 2, " ")
endt=str_get_field(str_2, 3, " ")
start_year=toint(str_get_field(startt, 1, "/"))
start_month=toint(str_get_field(startt, 2, "/"))
end_year=toint(str_get_field(endt, 1, "/"))
end_month=toint(str_get_field(endt, 2, "/"))

do i=0,12
    station=NS(i)
    str=f(1:)
    nrow=numAsciiRow("../MONTH.txt")-2

    c=0
    count=(end_year-start_year)*12+(end_month-start_month)+1
    data=new(count, string)
    do j=i,nrow,15
        time=str_get_field(str(j), 2, " ")
        year=toint(time)/100
        month=toint(time)%100
        if ((year.eq.start_year.and.month.eq.start_month).or.c.ne.0) then
            if (c.eq.count) then
                break
            end if
            data(c)=str(j)
            c=c+1
        end if
    end do
    ;print(data)

    x=ispan(1, count, 1)
    xlb=new(count+2, string)
    xlb(1:count)=str_get_field(data, 2, " ")
    xlb(0)=""
    xlb(count+1)=""
    y1=tofloat(str_get_field(data, 3, " "))
    y2=toint(str_get_field(data, 4, " "))
    y3=tofloat(str_get_field(data, 5, " "))
    y4=tofloat(str_get_field(data, 6, " "))

    wks=gsn_open_wks("png", station)

    res=True
    res@gsnDraw=False
    res@gsnFrame=False
    res@tmXTOn       = False
    res@tmYROn       = False

    res@tmXBMode="Explicit"
    res@tmXBValues=ispan(0, count+1, 1)  
    res@tmXBLabels=xlb
    res@trXMinF=0
    res@trXMaxF=count+1
    res@tmXBLabelAngleF=70
    res@tmXBMinorOn=False

    res1=res
    res1@tiMainString = "amount of precipitation"
    res1@tmYLMode="Manual"
    res1@tmYLTickStartF=toint(min(y1))-20
    res1@tmYLTickEndF=max(y1)+30
    res1@tmYLTickSpacingF=50
    res1@trYMinF=toint(min(y1))-20
    res1@trYMaxF=max(y1)+30

    res1@gsnXYBarChart=True
    res1@gsnXYBarChartColors="gray"          ;填充颜色
    res1@gsnXYBarChartBarWidth=0.5
    res1@tmYMajorGrid=True    ;y轴的主格网
    res1@tmYMajorGridLineColor="grey" 



    res2=res
    res2@tiMainString = "number of precipitation"
    res2@tmYLMode="Manual"
    res2@tmYLTickStartF=min(y2)-5
    res2@tmYLTickEndF=max(y2)+5
    res2@tmYLTickSpacingF=5
    res2@trYMinF=min(y2)-5
    res2@trYMaxF=max(y2)+5

    res2@gsnXYBarChart=True
    res2@gsnXYBarChartColors="blue"          ;填充颜色
    res2@gsnXYBarChartBarWidth=0.5
    res2@tmYMajorGrid=True    ;y轴的主格网
    res2@tmYMajorGridLineColor="grey" 



    res3=res
    res3@tiMainString = "pH"
    res3@tmYLMode="Manual"
    res3@tmYLTickStartF=3.5
    res3@tmYLTickEndF=max(y3)+0.5
    res3@tmYLTickSpacingF=0.5
    res3@trYMaxF=max(y3)+0.5   ;tofloat(sprintf("%3.1f",max(y3)))+0.3
    res3@trYMinF=3.5

    res3@gsnXYBarChart=True
    res3@gsnXYBarChartColors="orange"          ;填充颜色
    res3@gsnXYBarChartBarWidth=0.5
    res3@tmYMajorGrid=True    ;y轴的主格网
    res3@tmYMajorGridLineColor="grey" 



    res4=res
    res4@tiMainString = "K"
    res4@tmYLMode="Manual"
    res4@tmYLTickStartF=toint(min(y4))-5
    res4@tmYLTickEndF=max(y4)+5
    res4@tmYLTickSpacingF=10
    res4@trYMinF=toint(min(y4))-5
    res4@trYMaxF=max(y4)+5

    res4@gsnXYBarChart=True
    res4@gsnXYBarChartColors="pink"          ;填充颜色
    res4@gsnXYBarChartBarWidth=0.5
    res4@tmYMajorGrid=True    ;y轴的主格网
    res4@tmYMajorGridLineColor="grey"



    plots = new(4,graphic)
    plots(0)         = gsn_csm_xy(wks, x, y1, res1)
    plots(1)         = gsn_csm_xy(wks, x, y2, res2)
    plots(2)         = gsn_csm_xy(wks, x, y3, res3)
    plots(3)         = gsn_csm_xy(wks, x, y4, res4)

    txres=True
    txres@gsFontColor   = "black"
    txres@txFontHeightF = 0.015
    text1=gsn_add_text(wks, plots(0), sprintf("%.1f",y1), x, y1+8, txres)
    text2=gsn_add_text(wks, plots(1), sprinti("%i",y2), x, y2+0.5, txres)
    text3=gsn_add_text(wks, plots(2), sprintf("%.2f",y3), x, y3+0.08, txres)
    text4=gsn_add_text(wks, plots(3), sprintf("%.1f",y4), x, y4+0.9, txres)

    pres=True
    pres@gsnMaximize=True
    pres@txString="S"+station

    gsn_panel(wks, plots, (/2,2/), pres)
    frame(wks)

end do
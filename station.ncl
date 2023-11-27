station=(/(/30+13./60,119+42./60/),(/30+52./60,120+03./60/),(/30+44./60,120+46./60/),(/30+04./60,120+30./60/),\
         (/30+14./60,120+10./60/),(/30+02./60,122+06./60/),(/29+07./60,119+39./60/),(/29+20./60,120+05./60/),\
         (/29,118+54./60/),(/28+28./60,119+56./60/),(/28+02./60,120+39./60/),(/28+37./60,121+25./60/),\
         (/28+06./60,119+34./60/)/)

wks=gsn_open_wks("png", "station")

res2               = True
res2@gsnMaximize   = True
res2@gsnDraw       = False
res2@gsnFrame      = False

res2@mpOutlineOn   = False
res2@mpFillOn      = False
res2@mpDataBaseVersion = "HighRes"
res2@mpDataSetName="Earth..4"
res2@mpOutlineSpecifiers=(/"China","Zhejiang"/)  ;NCL自带的地图轮廓，比较粗糙，边界划分失误严重
res2@mpProvincialLineColor="blue" 
res2@mpProvincialLineThicknessF =8 

res2@mpLimitMode           = "LatLon"
res2@mpMinLatF             = 27
res2@mpMaxLatF             = 32
res2@mpMinLonF             = 118
res2@mpMaxLonF             = 123
res2@tiMainString          = "STATION"
res2@tiMainFontHeightF=0.014
  
res2@tmXTOn=False  ;关闭刻度线
res2@tmYROn=False
res2@tmXBMinorOn=False  ;关闭小刻度线
res2@tmYLMinorOn=False
res2@tmXBMode        = "Explicit" 
res2@tmXBValues      = (/118,119,120,121,122,123/)
res2@tmXBLabels   = (/"118~S~o~N~E","119~S~o~N~E","120~S~o~N~E","121~S~o~N~E",\
  "122~S~o~N~E","123~S~o~N~E"/) 

res2@tmYLMode        = "Explicit" 
res2@tmYLValues      = (/27,28,29,30,31,32/)
res2@tmYLLabels   = (/"27~S~o~N~N","28~S~o~N~N","29~S~o~N~N","30~S~o~N~N",\
  "31~S~o~N~N","32~S~o~N~N"/) 

map = gsn_csm_map(wks,res2)


shpfn2="zj_shp/zj_city_poly_region.shp"
inres=True
inres@mpMinLatF             = 27
inres@mpMaxLatF             = 32
inres@mpMinLonF             = 118
inres@mpMaxLonF             = 123
inres@gsEdgesOn=True
inres@gsEdgeColor="black"
shp_plot=gsn_add_shapefile_polygons(wks, map, shpfn2, inres)

   
res=True
res@gsMarkerIndex = 16                        ; polymarker style
res@gsMarkerSizeF = 15.                      ; polymarker size
res@gsMarkerColor = "orange"                  ; polymarker color
res@tfPolyDrawOrder = "PostDraw"
res@cnFillDrawOrder      = "PostDraw"  ; draw polygon first

plots=gsn_add_polymarker(wks,map,station(:,1),station(:,0),res)

draw(map)
frame(wks)
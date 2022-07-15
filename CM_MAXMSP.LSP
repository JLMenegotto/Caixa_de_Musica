(defun max:ambienteX ()                                                                          
                              (cond                                                                   
			            (*rtm_aobj*  (princ "\nAmbiente ActiveX ativo.\n"))                   
		                    (t                                                                   
				                 (vl-load-com)                                           
                                                 (setq *rtm_aobj*  (vlax-get-acad-object)             
                                                       *rtm_adoc*  (vla-get-activedocument *rtm_aobj*)
				   	               *rtm_pref*  (vla-get-Preferences    *rtm_aobj*)
                                                       *rtm_spac*  (vla-get-modelspace     *rtm_adoc*)
                                                       *rtm_pape*  (vla-get-paperspace     *rtm_adoc*)
				                       *rtm_lays*  (vla-get-Layers         *rtm_adoc*)
				                       *rtm_tlin*  (vla-get-Linetypes      *rtm_adoc*)
				                       *rtm_grps*  (vla-get-Groups         *rtm_adoc*)
				                       *rtm_util*  (vla-get-utility        *rtm_adoc*)
				                       *rtm_dims*  (vla-get-DimStyles      *rtm_adoc*)
                                                       *rtm_blks*  (vla-get-Blocks         *rtm_adoc*)
                                                 )                                                     
		                    )                                                                    
                               )                                                                       
)

(defun c:madmax ()
                          (max:ambienteX)
  
                          (setq rtm_maxmsp  (vlax-get-or-create-object  "MAX"))
                          (vla-put-visible rtm_maxmsp  :vlax-true)

                          (vlax-import-type-library                                               
                                          :tlb-filename      "C:/Arquivos de programas/Cycling '74/MaxMSP 4.6/max.exe"
                                          :methods-prefix    "max-m-"                          
                                          :properties-prefix "max-p-"                          
                                          :constants-prefix  "max-c-"                          
   	                  )
  
;;;                       (setq maxmsp (vlax-get-or-create-object "MAX.Application"))          
;;;                       (vlax-invoke-method "wmp-m1-play" "c:/e28-10.midi")                     
)
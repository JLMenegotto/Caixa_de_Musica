;;                                                                                                                              
;; Separa as entidades formando grupos de vozes em lista com a seguinte estrutura                                               
;;                                                                                                                              
;;                                                                                                                              

(defun Cx:Analiza_as_vozes ()
                		(foreach it *rtm_O_vozes*			  
				            (cond
					          ((Cx:grava_voz? it)  
						                      (Cx:escala_U (eval (read (strcat "*rtm_escala_" (car it) "_txt*"))))
						                      (Cx:Registravozes   it)
					                              (Cx:escanea_pontos  it)
					          )
				            )
		                )
)

(defun Cx:grava_voz? (#v)       (= "1" (nth 2 #v)))                                                                                 

(defun Cx:escanea_pontos (#it / g_con  g_voz  g_lay  g_gra  g_ssg  g_alt)
                                                                                
                                (Cx:error  "geom_01")
  
                                (setq
 				      g_con               0
 				      g_voz               (nth  0  #it) 
 			 	      g_lay               (nth  1  #it)
     				      g_ssg               (Cx:filtra_layer   g_lay)
                                      g_alt               (cadr    (assoc  g_voz  *rtm_A_programa*))
				      *Pl_dina*           (caddr   (assoc  g_voz  *rtm_A_programa*))
				      *rtm_stav*          (cadddr  (assoc  g_voz  *rtm_A_programa*))
				      *rtm_voz*           g_voz
				      *rtm_pulo*          (atoi (Cx:eval_pul_Voz  g_voz))
				      *rtm_igor*          (* *rtm_pulo* (atoi (Cx:eval_per_Voz  g_voz)))
				      *rtm_rito*          (* *rtm_pulo* (atoi (Cx:eval_rit_Voz  g_voz)))
				      *rtm_dife*          (- *rtm_igor*  *rtm_rito*)
                                      *rtm_fesc*          (Cx:eval_fes_Voz  g_voz)  
				      *rtm_ritmo*         0
                                      *rtm_ritro*         (if (= *rtm_rotari* "1") (atoi *rtm_voz*) 0)
				      *rtm_inter*         0
				      *rtm_veloc*         1.0				      
				      *L_puntos*          '()				       
				      *rtm_L_tocadas*     '()
				      *rtm_L_tocadas-N*   '()
				      *rtm_padraoM*       '()				      
				      *rtm_fdina*          1.0  ;; Fator de dinâmica                
			              *rtm_dinanda*        1.0  ;; Fator de dinâmica por andamento  
   			        )
  
                                (Cx:Inicie_paso)
                                (Cx:set_oitavas      g_alt)
                                (Cx:Grad_tempo       0  1)
                                (Cx:Grad_unidade     *rtm_unidai*  *rtm_fesc*)
                                (Cx:padrao_inicial   *rtm_M_Frase*)
      
                                (setq
				      *rtm_metodo*        (Cx:eval_met_Voz  g_voz)
				      *rtm_veloci_voz* (* (Cx:eval_vel_Voz  g_voz) *rtm_unidad*)
				)
                                                              
                                (cond (g_ssg		       
 				              (while (> (sslength  g_ssg)  g_con)
					             
                                                     (setq g_ent (ssname   g_ssg         g_con)
 					                   g_nom (Cx:dxf   -1            g_ent)
 					                   g_tip (Cx:acdb  100           g_ent)
 						           g_obj (vlax-ename->vla-object g_ent)
							   g_col (vla-get-color          g_obj)    
					             )
					             (cond
  	                                                   ((= g_tip "AcDb3dPolyline") (Cx:vrts_3Dpoly  g_obj  g_ent))
 					                   ((= g_tip "AcDbFace")       (Cx:vrts_3Dface  g_obj))
							   ((= g_tip "AcDbPoint")      (Cx:vrts_Point   g_obj))
 					                   ((= g_tip "AcDbCircle")     (Cx:vrts_circle  g_obj))
					                   ((= g_tip "AcDbLine")       (Cx:vrts_line    g_obj))
					             )
						     (cond
						           ((< gcon *rtm_igor*) (setq                                 g_con (+ g_con *rtm_pulo*)))
							   (t                   (setq *rtm_igor* (+ *rtm_dife* g_con) g_con (- g_con *rtm_rito*)))
						     )
							   
				              )

				              (Cx:processa_voz   g_voz   1  *rtm_stav*)
				              (Cx:MarcaNotas  *rtm_marcar*  *rtm_L_tocadas-N*   "Pts_normal"   g_voz)
 				      )
				      (t      (princ (strcat "Não há entidades no layer " g_lay ".")))
 				)
                                (princ (strcat "\nVoz " g_voz " .OK"))
                      (princ)
)

(defun Cx:processa_voz (#v #g #stave)
			              (Cx:Traduz_pontos  *L_puntos*   #g)  
                                      (if  *rtm_L_tocadas*
	   			           (Cx:registra_voz  #v  #g  (reverse *rtm_L_tocadas*)  #stave)
                                      )
)

(defun Cx:filtra_layer (#layer)
                                       (gc)
                                       (ssget "X"  (list (cons 8  #layer)))
)

(defun Cx:vrts_3Dpoly (#ob #ent / pts)
                                       
                                       (setq
					     pts (Cx:var->pts  0   #ob   nil) 
                                             pts (Cx:tira_pt_rep   pts)
				       )

                                       (while (and (setq pt1 (nth 0 pts))        
					 	   (setq pt2 (nth 1 pts))        
				              )                                 
					      (Cx:Add_L_puntos (list g_col pt2 pt1))
					      (setq pts (cdr pts))            
				       )                                        
                                       (setq *L_puntos* (reverse *L_puntos*))
) 

(defun Cx:vrts_3Dface (#ob)            (Cx:Add_L_puntos    (append (list g_col) (Cx:var->pts 0  #ob  nil))))
(defun Cx:vrts_Point  (#ob)            (Cx:Add_L_puntos    (append (list g_col) (Cx:var->pts 0  #ob  nil))))


(defun Cx:vrts_circle (#ob)
  
                                       (setq cen   (Cx:var->pts  2  #ob  nil)
                                             rai   (vla-get-Radius  #ob)
					     ang   0.0
					     pc1   (polar cen (* pi 0.0) rai)
					     pc2   (polar cen (* pi 0.5) rai)
					     pc3   (polar cen (* pi 1.0) rai)
					     pc4   (polar cen (* pi 1.5) rai)         
				       )                                                                              
                                       (Cx:Add_L_puntos (list g_col cen pc1 pc2 pc3 pc4))
)

(defun Cx:divseg (a b n)
                                       (mapcar '* (mapcar '+ a b)
					          (mapcar 'float (list n n n))
			               )
)

(defun Cx:vrts_line (#ob / p1 p2 p3 p4 p5)
                                            (setq 
					          p1  (Cx:var->pts  4 #ob  nil)
					          p2  (Cx:var->pts  5 #ob  nil)
					          p3  (Cx:divseg  p1  p2  0.50)	
					          p4  (Cx:divseg  p1  p3  0.50)
					          p5  (Cx:divseg  p2  p3  0.50)
				            )
                                            (Cx:Add_L_puntos (list g_col p1 p3 p4 p5 p2))
)

;;;                                                                                                                        
;;; Adiciona lista de pontos na lista                                                                                      
;;; #l lista de pontos                                                                                                     
;;;                                                                                                                        

(defun Cx:Add_L_puntos (#l)            (setq *L_puntos*  (cons  #l  *L_puntos*)))

(defun Cx:conta_os_pontos ()
                                       (setq *total_faces* 0)  
                                       (mapcar '(lambda (i)
						             (if (listp  i)
				   		                 (setq *total_faces* (1+ *total_faces*))
						             )
				                )
				                *L_puntos*
			               )
                                       (setq *rtm_dina_faces*  (/ (Cx:real *rtm_periodo*)    *total_faces*))
                                       (setq *rtm_mod_tramo*   (fix (*  *total_faces* (/ 1.0  (Cx:real *rtm_periodo*)))))
)

(defun Cx:Traduz_pontos  (#l #g)
                                       (Cx:conta_os_pontos)
                                       (mapcar '(lambda (l)
						            (setq *color* (car l))
							    (Cx:tocar     (cdr l))
				                )
				                #l
				       )
)



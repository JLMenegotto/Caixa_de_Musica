
(defun C:fios ()
  
                                (setq
				      dt       0
				      g_con    0
 				      g_ssg    (ssget "X"  (list (cons 8  "egc-eixo")))
   			        )
                                (cond (g_ssg		       
 				              (while (> (sslength  g_ssg)  g_con)
					             
                                                     (setq g_ent (ssname   g_ssg         g_con)
 					                   g_nom (Cx:dxf   -1            g_ent)
 					                   g_tip (Cx:acdb  100           g_ent)
 						           g_obj (vlax-ename->vla-object g_ent)
					             )
					             (cond
  	                                                   ((= g_tip "AcDb3dPolyline") (Cx:fios_3Dpoly   g_obj  g_ent))
					             )
						     (setq g_con (1+  g_con))
				              )
 				      )
				      (t      (princ (strcat "Não há entidades no layer 0")))
 				)
)

(defun Cx:fios_3Dpoly (#ob #ent)
                                       (setq pts (Cx:var->ponts #ob))
                                       (cx:colgar pts)
) 

(defun cx:colgar (#l)
                                       (mapcar '(lambda (p)
						             (setq p1 p
								   p2 (list (car p) (cadr p) 2.1)
								   d  (distance p1 p2)
								   dt (+ d dt)
						             )
                                                             (Cx:linha  "fios"   p1  p2)
						             (Cx:ponto  "ponto"  p2)
;;;						             (Cx:esfera "esfe"   p1  0.0025)
;;;						             (Cx:texto  "text"   p2  0.001 (rtos d 2 3) 0)
						)
					        #l
				       )
)

(defun Cx:eco_off ()                     (setvar "cmdecho" 0))
(defun Cx:eco_on  ()                     (setvar "cmdecho" 1))
(defun Cx:esfera (#lay  #pto  #rad)
                                         (Cx:eco_off) 
                                         (command "._sphere"   #pto  #rad)
                                         (Cx:coloca_no_layer   #lay)
                                         (Cx:eco_on) 
)
(defun Cx:coloca_no_layer (#lay)
                                         (command "._chprop" (entlast) "" "_la"  #lay  "")
)


(defun Cx:linha (#lay #p1 #p2)
                                         (entmake                               
		                                 (list                             
            		    	                     (cons   0  "LINE")         
                                                     (cons 100  "AcDbEntity")   
                                                     (cons 100  "AcDbLine")
						     (cons   8  #lay)
                                                     (cons  10  #p1)            
            				             (cons  11  #p2)            
 		                                 )                                 
 		                         )                                                                             
)

(defun Cx:ponto (#lay #p1)
                                         (entmake                               
		                                 (list                             
            		    	                     (cons   0  "POINT")         
                                                     (cons 100  "AcDbEntity")   
                                                     (cons 100  "AcDbpoint")
						     (cons   8  #lay)
                                                     (cons  10  #p1)                       
 		                                )                                 
 		                         )                                                                             
)
;;; CODIGO 72                                                                              
;;;0 = Left                                                                                
;;;1 = Center                                                                              
;;;2 = Right                                                                               
;;;3 = Aligned                                                                             
;;;4 = Middle                                                                              
;;;5 = Fit                                                                                 
;;;Cria um texto                                                                           

(defun Cx:texto  (#lay #pto #alt #tex #jus)
                                         (entmake  
                     		              (list                               
                     		    	           (cons   0 "TEXT")             
                                                   (cons 100 "AcDbEntity")       
                                                   (cons 100 "AcDbText")         
                     				   (cons   8 #lay)              
                                                   (cons  10 #pto)              
                     				   (cons  11 #pto)              
                      			           (cons  40 #alt)                
                     				   (cons   1 #tex)               
                     				   (cons   7 (getvar "TEXTSTYLE"))
                      				   (cons  72 #jus)			   
                      		              )
 			                 )
)

;;transforma variant em lista de coordenadas                                                                             
;; #ob  um variant ou um objeto                                                                                          
;; #i   indice da coordenada a ser transformada                                                                          
(defun Cx:var->ponts (#ob)
                                       (setq lpt
                                                 (vlax-safearray->list
			                               (vlax-variant-value
					  	                          (vla-get-Coordinates #ob)  
					               )
			                         )
			               )
                                       (Cx:pts_3DP lpt)
)


;;  converte lista 3P variant em array de pontos                                                                         
;;  #v lista de vertices                                                                                                 
(defun Cx:pts_3DP (#v / l1 l2)
                                        (setq l1  #v)
                                        (repeat  (/ (length #v)  3)
                                                 (setq l2 (cons
							        (list
								      (nth 0 l1)
								      (nth 1 l1)
								      (nth 2 l1)
								)
								l2
						          )
            			                       l1 (cdddr l1)
						 )
            	                        )
                                        (reverse l2)
)

(defun Cx:acdb (#k #e)
                             (Cx:dxf  #k  (cdr (member (assoc #k (entget #e)) (entget #e))))
)

(defun Cx:dtr      (#a)      (* pi (/ #a    180.0))) 
(defun Cx:rtd      (#a)      (*  (/ #a  pi) 180.0))
(defun Cx:lis->Str (#l)      (apply 'strcat (mapcar 'itoa #l)))

;;                                                                                                   
(defun Cx:dxf      (#a #b)   (cdr (assoc #a
					     (if (listp  #b)
					                 #b
					         (entget #b)
					     )
			         )
		              )
)
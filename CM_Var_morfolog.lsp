
;; #l    Lista con as coordenadas a serem traduzidas                                       
;; #u1    Representa a posicion del punto tocado  (variável *rtm_paso1*)                   

(defun Cx:Distribuir_por_Morfologia (#l #u1 #f)                                                  

                                     (Cx:error  "Morfo_01")
				     (if (not *rtm_padraoM*)                                       
				  	 (Cx:Gera_Frase  #l #f)                                       
					 (cond			                                   
                                               ((Cx:es_mult? #u1 (Cx:4Qper)) (setq teste 0) (Cx:Gera_Frase #l #f))
					       ((Cx:es_mult? #u1 (Cx:3Qper)) (setq teste 1) (Cx:cddc_Frase))
                                               ((Cx:es_mult? #u1 (Cx:2Qper)) (setq teste 2) (Cx:Soma_Frase))               
					       ((Cx:es_mult? #u1 (Cx:1Qper)) (setq teste 3) (Cx:baab_Frase))
					       ((Cx:es_mult? #u1 (Cx:1Oper)) (setq teste 4) (Cx:cddc_Frase))
			           	 )                                                         
			             )                   
)

;; Verifica si a lista representa um ponto um segmento ou um plano                         
(defun Cx:ponto?   (#l) (= (length #l) 1))
(defun Cx:linha?   (#l) (= (length #l) 5))
(defun Cx:segme?   (#l) (= (length #l) 2))
(defun Cx:plano?   (#l) (= (length #l) 4))
(defun Cx:circulo? (#l) (= (length #l) 6))

;;Coloca palavra com 5 caracteres e corta de acordo com o parâmetro #n                     
(defun Cx:formacorrente_S (#p #n)
                                (Cx:error  "Morfo_02")
                                (substr
                                   (cond
				       ((>= (strlen #p) 5) (strcat (substr #p 1 1) (substr #p 2 1) (substr #p 3 1) (substr #p 2 1) (substr #p 1 1)))
				       ((=  (strlen #p) 4) (strcat (substr #p 1 1) (substr #p 2 1) (substr #p 3 1) (substr #p 2 1) (substr #p 1 1)))
                                       ((=  (strlen #p) 3) (strcat (substr #p 1 1) (substr #p 2 1) (substr #p 3 1) (substr #p 2 1) (substr #p 1 1)))
                                       ((=  (strlen #p) 2) (strcat (substr #p 1 1) (substr #p 2 1) (substr #p 1 1) (substr #p 2 1) (substr #p 1 1)))
                                       ((=  (strlen #p) 1) (strcat         #p              #p              #p              #p              #p     ))
				       (t                   "01210")
	 	                   )
			           1
			           #n
	                        )
)

(defun Cx:formacorrente_T (#p #n)
                                (Cx:error  "Morfo_03")
                                (substr (cond
				              ((>= (strlen #p) 5) (substr #p 1 5))
				              ((=  (strlen #p) 4) (strcat #p "1"))
                                              ((=  (strlen #p) 3) (strcat #p "12"))
                                              ((=  (strlen #p) 2) (strcat #p "123"))
                                              ((=  (strlen #p) 1) (strcat #p "1231"))
				              (t                             "12312")
	 	                        )
			                1
     				        #n
	                        )
)

(defun Cx:1+p (#p)          (itoa (Cx:ModV (1+ (atoi #p)) *rtm_M*)))

;;                                                                                                                                             
;; Gera uma frase a partir de uma lista de pontos                                                                                              
;; #l  Lista com os 4 vértice de uma 3dFace que definirá a palavra                                                                             
;;                                                                                                                                             

(defun Cx:Gera_Frase (#l #f / conta listaM  valM)

                             (Cx:error  "Morfo_04")
                             (setq *rtm_padraoM*  '()
				   *rtm_M*          9
				   conta            1
		             )
                             (cond (#l (setq  medida    (cond ((Cx:ponto?   #l) "1")
							      ((Cx:linha?   #l) (Cx:long  #l))
							      ((Cx:segme?   #l) (Cx:long  #l)) 
							      ((Cx:plano?   #l) (Cx:area  #l))
							      ((Cx:circulo? #l) (Cx:area2 #l))
				                              (t                (Cx:long  #l))
			                                )
					      parte_M   (if (= #f "S")
							    (Cx:formacorrente_S  medida  *rtm_M_Frase*)
							    (Cx:formacorrente_T  medida  *rtm_M_Frase*)
							)
					)
                                              (cond (parte_M  (repeat (strlen parte_M)
							              (setq valM    (atoi (substr  parte_M  conta  1))
									    listaM  (cons (Cx:ModV   valM  *rtm_M*) listaM)
			     		                                    conta   (1+ conta)
							              )
			                                 )
                                                         (setq *rtm_padraoM*  (reverse  listaM))
					     ))
				    )
				    (t       (setq *rtm_padraoM* (CM_index *rtm_M_Frase* 0 nil)))
		             )
		             (Cx:adi_Frase  "Frase Nova ")		     
)

(defun Cx:Muda_frase (#fun)
                             (setq *rtm_padraoM*  (mapcar '(lambda (n m) (Cx:ModV  (+ n  m)  *rtm_M*))
						           *rtm_padraoM*
						           (mapcar '(lambda (o) (+ o (car #fun))) *rtm_padraoM*)
					          )
			     )
                             (Cx:adi_Frase "Frase M ")
)

(defun Cx:baab_Frase (/ pal)
                             (setq *t*            1
                                   *rtm_padraoM*  (Cx:baab *rtm_padraoM*)
		             )
                             (Cx:adi_Frase "Frase Iab ")
)

(defun Cx:cddc_Frase (/ pal)
                             (setq *t*             2
                                   *rtm_padraoM*  (Cx:cddc *rtm_padraoM*)				   
		             )
                             (Cx:adi_Frase "Frase Icd ")
)

(defun Cx:Soma_Frase (/ pal)
                             (setq *rtm_padraoM*  (Cx:sube *rtm_padraoM*))
                             (Cx:adi_Frase "Frase S ")
)

(defun Cx:Prod_Frase (/ pal)
                             (setq *rtm_padraoM*  (Cx:nx2 *rtm_padraoM*))
                             (Cx:adi_Frase "Frase X ")
)

(defun Cx:Dife_Frase (/ pal)
                             (setq *rtm_padraoM*  (Cx:dife *rtm_padraoM*))
                             (Cx:adi_Frase "Frase D ")
)


(defun Cx:adi_Frase  (#m)
                             (setq *lst_frases*  (cons   (list *rtm_padraoM*)  *lst_frases*))
                             (Cx:Mnsg_transform   #m   *rtm_padraoM*)
                             (list *rtm_padraoM*)
)

(defun Cx:Inve_Frase ()      (cond
			           ((= *t* 1)  (Cx:cddc_frase))
				   ((= *t* 2)  (Cx:baab_frase))
				   (t          (Cx:cddc_frase))
			     ))

;;;                                                                                                                                        
;;;                                                                                                                                        
;;;                                                                                                                                        

(defun Cx:dife (#p)          (mapcar '(lambda (n)
                                                   (-  *rtm_M*  n)
				      )
				      #p
		             ))

(defun Cx:sube (#p)          (mapcar '(lambda (n m) (Cx:ModV   (abs (+ n  m))  *rtm_M*))
				      #p
				      (mapcar '(lambda (p)
                                                           (if (not (zerop p))
						                1
							       (+ 1 p)
							   )
					       )
					       #p
			              )
		             ))

(defun Cx:sobe (#p)          (mapcar '(lambda (n)   (Cx:ModV  (abs (+ n (if (not (zerop n))
						                          1
							                 (1+ n)
							             )
								)
						           )    *rtm_M*)
				      )
				      #p
		             ))

(defun Cx:nx2  (#p)          (mapcar '(lambda (n)
                                                    (Cx:ModV   (abs (* n  2))  *rtm_M*)
				      )
				      #p
		             ))

(defun Cx:baab (#p)          (cond
			           ((= (length #p) 5) (append    (Cx:ba #p) (list (nth  2  #p)) (reverse   (Cx:ba #p))))
                                   ((= (length #p) 4) (append    (Cx:ba #p)                     (reverse   (Cx:ba #p))))
                                   ((= (length #p) 3) (append    (Cx:ba #p)                     (list (car (Cx:ba #p)))))
                                   ((= (length #p) 2)            (Cx:ba #p)) 
                                   ((= (length #p) 1) (list (car (Cx:ba #p))))
		             ))

(defun Cx:cddc (#p)          (cond
			           ((= (length #p) 5) (append    (Cx:cd #p) (list (nth  2  #p)) (reverse   (Cx:cd #p))))
                                   ((= (length #p) 4) (append    (Cx:cd #p)                     (reverse   (Cx:cd #p))))
                                   ((= (length #p) 3) (append    (Cx:cd #p)                     (list (car (Cx:cd #p)))))
                                   ((= (length #p) 2)            (Cx:cd #p)) 
                                   ((= (length #p) 1) (list (car (Cx:cd #p))))
		             ))

(defun Cx:ba   (#p)          (if  (>= (length #p) 2)
                                  (list (nth  1  #p)  (nth  0  #p))
                                  (list (nth  0  #p))
			     ))

(defun Cx:cd   (#p)          (if (>= (length #p) 2)
			         (list (nth  (- (length #p) 2)  #p)  (nth  (- (length #p) 1)  #p))
                                 (list (nth  (- (length #p) 1)  #p))
			     ))
                                                                                                                              
;;;                                                                                                                                   
;;; Calcula área de uma face segundo a fórmula de Herón de Alexandria (~126 a.C)                                                      
;;; Pode ser aplicada para triángulos inclinados com respeito ao plano o que a                                                        
;;; torna útil para topografia.                                                                                                       
;;; Transforma o valor em corrente de caracteres                                                                                      
;;; #l Lista com os 4 vértice de uma 3dFace                                                                                           
;;;                                                                                                                                   

(defun Cx:area (#l / l1 l2 l3 l4 l5 med-peri1 area-fac1 med-peri2 area-fac2)
  
                            (setq l1          (distance (nth 0 #l) (nth 1 #l))
                                  l2          (distance (nth 1 #l) (nth 2 #l))
                                  l3          (distance (nth 2 #l) (nth 0 #l))
				  l4          (distance (nth 2 #l) (nth 3 #l))
                                  l5          (distance (nth 3 #l) (nth 0 #l))
                                  			  
			          peri_media1 (/  (+ l1 l2 l3) 2.0)
			          peri_media2 (/  (+ l4 l5 l3) 2.0)
				  
                                  area-fac1   (* 2 (sqrt (* peri_media1 (- peri_media1  l1)
				 	                                (- peri_media1  l2)
					                                (- peri_media1  l3)
					                 )
			                          ))
                                  area-fac2   (* 2 (sqrt (* peri_media2 (- peri_media2  l4)
				 	                                (- peri_media2  l5)
					                                (- peri_media2  l3)
					                 )
			                          ))
				  
 		            )
                            (setq area (+ area-fac1 area-fac2))
                            (cond
			          ((> 10   area    )  (itoa (fix (* 10000 area))))
			          ((> 100  area  10)  (itoa (fix (*  1000 area))))
			          ((> 1000 area 100)  (itoa (fix (*   100 area))))
				  (t                  (itoa (fix         area)))
                            )
  
)
;;;                                                                                                                                   
;;; Calcula longitude de um segmento ou linha                                                                                         
;;; Transforma o valor em corrente de caracteres                                                                                      
;;; #l Lista com 2 vértices                                                                                                           
;;;                                                                                                                                   
(defun Cx:long (#l)         (itoa (fix (* 100 (distance (car #l) (last #l))))))

;;;                                                                                                                                   
;;; Calcula are de quadrado inscrito em círculo                                                                                       
;;; #l Lista com 6 pontos                                                                                                             
;;;                                                                                                                                   
(defun Cx:area2 (#l / l1 l2 area)
                                 (setq l1   (distance (nth 1 #l) (nth 2 #l))
                                       l2   (distance (nth 2 #l) (nth 3 #l))
                                       area (* l1 l2)				  
 		                 )
                                 (itoa (fix (* 100 area)))
)

;;;                                                                                                                                  
;;; Calcula a freqüência com a média das coordenadas XYZ                                                                             

(defun Cx:Coordenada->frequencia (#l / coorde)
                                  (setq *rtm_padraoM* (CM_index 1 0 nil))
)
;;                                                                                                        
;; Funões utilitaras de uso geral                                                                         
;;                                                                                                        
(defun Cx:ambienteX ()                                                                          
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

;; Identifica codigo de error                                                                         
(defun Cx:error  (#e)        (setq *rtm_error* #e))

;;Verifica se #n é um simbolo (rever)                                                                 
(defun Cx:atomo? (#n)
			      (= (type #n)  nil)
) 

;;Verifica se #n é string                                                                             
(defun Cx:string? (#n)
			      (= (type #n) 'STR)
) 

;;Verifica se #n é inteiro                                                                            
(defun Cx:entero? (#n)
			      (= (type #n) 'INT)
)

;;Verifica se #n é Real                                                                               
(defun Cx:real?   (#n)
			      (= (type #n) 'REAL)
)

;;Verifica se #n é número par                                                                         
(defun Cx:espar?   (#n)      (=  0 (rem (Cx:real #n) 2.0)))

;;Verifica se #n é número impar                                                                       
(defun Cx:impar?   (#n)      (/= 0 (rem (Cx:real #n) 2.0)))

;;Verifica o número de voz #v                                                                         
(defun Cx:voz? (#v)
                              (= (atoi geo_voz) #v)
)


(defun Cx:entero (#v)
			      (cond
				    ((Cx:string?  #v)   (atoi  #v)) 
                                    ((Cx:real?    #v)   (fix   #v))
				    (t                         #v)
			      )
)

;; converte Inteiro, Real ou String em Real                                                           
(defun Cx:real   (#v)
			      (cond				
				    ((Cx:string?  #v)   (atof  #v)) 
                                    ((Cx:entero?  #v)   (float #v))
				    (t                         #v)				    
			      )
)

;; converte Inteiro, Real ou String em string                                                         
(defun Cx:string (#v)
			     (cond
				    ((Cx:string?  #v)          #v) 
                                    ((Cx:entero?  #v)   (itoa  #v))
				    ((Cx:real?    #v)   (rtos  #v 2 4))
			     )
)

(defun Cx:central (#l)                                                                   
	                           (mapcar '(lambda (n)                                       
				                       (/ (apply '+                          
						             (mapcar '(lambda (x)           
								        (cond ((nth n x))
                                                                              (t       0)
									)                
							           )                     
						                   #l                    
					                     )                              
				                          )                                   
					                  (length #l)                         
				                       )                                      
			              )                                                  
		                     '(0 1 2)                                            
	  	              )                                                          
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
;; confere se o númeto #p é múltiplo de #n                                                                               
(defun Cx:multiplo? (#p #n)   (zerop (rem #p #n)))                                                                                                                   

;;transforma variant em lista de coordenadas                                                                             
;; #ob  um variant ou um objeto                                                                                          
;; #i   indice da coordenada a ser transformada                                                                          
(defun Cx:var->pts (#m #ob #i / lpt)
                                       (setq lpt
                                             (vlax-safearray->list
			                           (vlax-variant-value
					  	                (cond
							              ((= #m 0) (vla-get-Coordinates #ob   )) ;; Poligonal
								      ((= #m 1) (vla-get-Coordinates #ob   )) ;; Faces    
							              ((= #m 2) (vla-get-center      #ob   )) ;; Circulo  
								      ((= #m 3) (vla-get-Coordinate  #ob #i)) ;; Malhas   
							              ((= #m 4) (vla-get-Startpoint  #ob   )) ;; P1 Linha 
							              ((= #m 5) (vla-get-Endpoint    #ob   )) ;; P2 Linha 
						   	        )  
					           )
			                     )
			               )
                                       (cond
					     ((zerop #m)   (Cx:pts_3DP lpt))
					     ((= 1   #m)   (Cx:pts_3DP lpt))
					     (t    	               lpt)
				       )
)

;; Tira pontos repetidos de uma lista de pontos                                                                          
(defun Cx:tira_pt_rep (#l / novalista)
  
                           (mapcar
			           '(lambda (it)
                                            (if (not (member it novalista))
				                (setq novalista (cons it novalista))
					    )
 		                    )
				    #l
 	  	           )
                           (reverse novalista)
)

;;  Calcula area de uma 3d FACE                                                                                          

(defun Cx:areatri (#v1 #v2 #v3 #v4 / a b c d e s1 s2)
                          (setq
			        a  (distance  #v1  #v2) 
                                b  (distance  #v2  #v3)
                                c  (distance  #v3  #v1)
                                d  (distance  #v3  #v4)
                                e  (distance  #v4  #v1)
				
				s1 (/ (+ a b c) 2.0)
				s2 (/ (+ c d e) 2.0)
	                  )
                          (+
			     (sqrt (* s1 (- s1 a) (- s1 b) (- s1 c)))
			     (sqrt (* s2 (- s2 d) (- s2 e) (- s2 c)))
			  )
)

;; Função lista interseção                                                                                              
;; (c:l-int lista1 lista2)                                                                                              
;; lista1 primeira lista                                                                                                
;; lista2 segunda lista                                                                                                 

(defun Cx:l-int (a b / d)
                        (mapcar '(lambda (i)
                                            (cond
                                                  ((and
						        (not (member i d))
						   	     (member i a)
                                                             (member i b)
						   )
                                                                             (setq d (cons i d)))
                                            )
                               )
                               (append a b)
                       )
                       (reverse d)
)

;;                                                                                                                      
;; Função que analisa se um onto se encontra dentro de um paralelepípedo definido.                                      
;;                                                                                                                      

(defun Cx:ponto_in (#pt #lim1 #lim2)
                                     (cond
			                  ((and
					        (<= (car   #lim1) (car   #pt) (car   #lim2))
				                (<= (cadr  #lim1) (cadr  #pt) (cadr  #lim2))
				                (<= (caddr #lim1) (caddr #pt) (caddr #lim2))
                                           )                                              t)
			                  (t                                            nil)
		                     )
)
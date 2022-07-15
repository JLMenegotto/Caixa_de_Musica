;; Cria um sset de 3dfaces e os organiza em una lista pelo nome                            
(defun CM_lst_faces (#ss #lpd / i)
                                       (setq
					     lst_faces '()
					     i           0
				       )
                                       (while (< i  (sslength #ss))                           
					      (setq lst_faces (cons (ssname #ss i) lst_faces)
						    i         (1+ i)                         
					      )                                              
				       )                                                     
                                       (CM_faces  lst_faces   #lpd)
)

;; #l   Lista com as faces a serem processadas.                                            
;; #lpd Par ordenado com o periodo e o deslocamento  (m n)                                 
;; m    Quantidade de faces a processar antes da repetição                                 
;; n    Deslocamento  para frente si m=n -> não ha repetição de faces tocadas              
;; Retorna a lista l-toc com os nomes das entidades organizados de acordo aos intervalo    
;; definido em '(m n)                                                                      
(defun CM_faces (#l #lpd / l-fac l-toc perio deslo )
                                       (setq
					     l-toc  '()
					     l-fac   #l
                                             perio  (CM_index (car  #lpd) 0)
					     deslo            (cadr #lpd)
                                       )
                                       (while l-fac
					           (setq
						        l-toc (CM_eleme l-fac perio)
					                l-fac (CM_deslo l-fac deslo)
					           )
				       )
                                       (reverse l-toc) 
)

;; Retorna uma lista com índices até um determinado numero                                 
;; (CM_index  4 0  nil) retorna (0 1 2 3)                                                  
;; (CM_index  4 0  t)   retorna (3 2 1 0)                                                  

(defun CM_index (#p #d #i / n ln)
                                       (setq n   (1- (abs #p)) ln '())
                                       (while (>= n 0)
		                                      (setq ln (cons n ln))
					              (setq n  (1- n)) 
	                               )
                                       (setq ln (append (member   #d           ln)
					                (reverse (member (1- #d) (reverse ln)))
				                )
				       )

                                       (if #i
					   (reverse ln)
					   ln
				       )
)


;; Retorna uma lista contando los números entre #a e #b                                    
;; (Cx:contar  -5 5) retorna (-5 -4 -3 -2 -1 0 1 2 3 4 5)                                  

(defun Cx:contar (#a #b / n ln)
                                       (setq n #a)
                                       (while (<= #a n #b)
		                              (setq ln (cons n ln)
					            n  (1+ n)
				              ) 
	                               )
                                       (reverse ln)				       
)

(defun CM_deslo (#l #d)
                                       (if (/= 0  #d)
                                           (CM_deslo  (cdr #l)  (1- #d))
					   #l
				       )
)

;; Retorna a lista com os n elementos de uma lista                                      
(defun CM_eleme (#l #p)
                                       (cons       
                                            (mapcar
                                                   '(lambda (i)
                                                            (nth i  #l)
                                                    )
                                                    #p
                                            )      
				            l-toc  
				       )           
)


;;                                                                                     
;; Retorna o mínimo comum múltiplo de uma lista de números                             
;;                                                                                     
(defun CM_McM (#l / fl li lm a b m)
                                       (setq fl  t
					     li  #l
					     lm  '()
				       )
                                       (while fl
 	 	                                  (setq a  (car      li)
					                b  (cadr     li)
						        m  (/ (* a b) (gcd a b))
                                                        lm (cons  m  lm)
						        li (cdr      li)
                                                  )
					          (cond
						         ((>= (length li) 2) (princ))
						         ((>= (length lm) 2) (setq li   lm  lm '()))
							 (t                  (setq fl   nil))
						  )
				       )
                                       (car lm)
)

;; Retorna a lista de fatores de um número #n                                          
(defun CM_fatores (#n / lf)
                                       (mapcar '(lambda (f)
			                               (if (zerop (mod #n f))
				                           (setq lf (cons (/ #n  f) lf))
				                       )
		 	                        )
		                                (cdr (CM_index #n))
	                               )
                                       (reverse (cons  1  lf))
)

;; Calcula os fatores de un número                                                    
(defun CM_fat (#n)
                            (setq n   #n
 				  lf  '()
		            )
                            (while (/= n 1)
				            (setq fat (if (CM_f2? n) 2
						       (if (CM_f3? n) 3
						        (if (CM_f4? n) 4
						         (if (CM_f5? n) 5
						          (if (CM_f6? n) 6
						           (if (CM_f7? n) 7
						            (if (CM_f8? n) 8
						             (if (CM_f9? n) 9 n))))))))
					         lf   (cons  fat  lf)
				                 n    (/  n  fat)
				            )
			    )
                            (reverse lf)
)
 
(defun CM_f2? (#n) (zerop (mod #n 2)))
(defun CM_f3? (#n) (zerop (mod #n 3)))
(defun CM_f4? (#n) (zerop (mod #n 4)))
(defun CM_f5? (#n) (zerop (mod #n 5)))
(defun CM_f6? (#n) (zerop (mod #n 6)))
(defun CM_f7? (#n) (zerop (mod #n 7)))
(defun CM_f8? (#n) (zerop (mod #n 8)))
(defun CM_f9? (#n) (zerop (mod #n 9)))

(defun mod (#n #m)                     (abs (- #n (* #m (rem (/ #n #m))))))

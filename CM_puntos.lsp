
(defun Cx:Punto (#l #i)
                                 (eval (list (read (strcat "Cx:pt" (Cx:string (abs #i)))) '#l))
)

;; Vértices das entidades                                                                                           
(defun Cx:pt1 (#l)               (nth  (Cx:nth 0 #l)  #l))
(defun Cx:pt2 (#l)               (nth  (Cx:nth 1 #l)  #l))
(defun Cx:pt3 (#l)               (nth  (Cx:nth 2 #l)  #l))
(defun Cx:pt4 (#l)               (nth  (Cx:nth 3 #l)  #l))

;; Pontos médios das arestas                                                                                        
(defun Cx:pt5 (#l)               (Cx:central (list (nth (Cx:nth 0 #l) #l) (nth (Cx:nth 1 #l) #l))))
(defun Cx:pt6 (#l)               (Cx:central (list (nth (Cx:nth 1 #l) #l) (nth (Cx:nth 2 #l) #l))))
(defun Cx:pt7 (#l)               (Cx:central (list (nth (Cx:nth 2 #l) #l) (nth (Cx:nth 3 #l) #l))))
(defun Cx:pt8 (#l)               (Cx:central (list (nth (Cx:nth 3 #l) #l) (nth (Cx:nth 0 #l) #l))))
(defun Cx:pt9 (#l)               (Cx:central  #l))

;; Ponto do baricentro                                                                                              
(defun Cx:pt0 (#l)               (Cx:central  #l))

(defun Cx:nth   (#i #v / compri)
                                       (setq compri (length #v))
                                       (cond
			                     ((> compri    #i)           (- compri  (- compri #i)))
			                     ((> compri (- #i compri))   (-     #i     compri))    
				             (t                          0)                        
 	 		               )
)                                                                                                                     

(defun Cx:Polar (#fun #l #n)
                                       (Cx:error  "seri_09")
                                       (setq
			  	              p1  (Cx:Punto  #l  (car   #fun))
				   	      p2  (Cx:Punto  #l  (cadr  #fun))
			               )
                                       (Cx:error  "seri_10")
                                       (Cx:Vetor_U   p1  p2  (*  *rtm_unidad*  #n  1.73205))
)

(defun Cx:Vetor_U (#p1 #p2 #d / dim dis)
                                       (setq dis  (distance #p1 #p2)
			                     dim  (if (zerop dis)
					               dis
					              (*  #d (/  1.0  (distance #p1 #p2)))
					          )
		                       )
                                       (Cx:error  "seri_11")
                                       (mapcar '+ #p1 (mapcar '* (mapcar '- #p2  #p1)
				 	                         (list dim  dim  dim)
				                      )
		                       )
)

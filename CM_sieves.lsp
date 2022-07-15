(defun Cx:sieve (#lst_svs #op1 #op2 / s)
                                         (setq s '())
                                         (mapcar
				                '(lambda (n)
				                            (if (apply  #op1  (Cx:filtrar  #lst_svs  n   #op2))
					  	                (setq s (cons  n  s))
						            )
			                         )
				                 (Cx:fatores)
		   	                 )
                                         (reverse s)
)

(defun Cx:filtrar (#lst_svs #n #op)
                                         (mapcar
				                '(lambda (ii)
					                    (Cx:Mod?  #op  #n  (car ii)  (cadr ii))
			                         )
			                         #lst_svs
			                 )
)

;;Verifica o módulo correspondente ao deslocamento #s                                                           

(defun Cx:Mod? (#op #n #m #s)
                                         (apply  #op  (list (Cx:ModV #n  #m)  #s))
)

(defun Cx:sieve+T (#l) (Cx:sieve  #l 'or   '= ))
(defun Cx:sieve+I (#l) (Cx:sieve  #l 'or   '/=))
(defun Cx:sieve-T (#l) (Cx:sieve  #l 'and  '= ))
(defun Cx:sieve-I (#l) (Cx:sieve  #l 'and  '/=))

(defun Cx:cromatica () '(":c"  ":cs"  ":d"  ":ds"  ":e"  ":f"  ":fs"  ":g"  ":gs"  ":a" ":as"  ":b"))
(defun Cx:fatores   () '(2 3 4 5 6 7 8 9))
(defun Cx:semitonos () '(0 1 2 3 4 5 6 7 8 9 10 11))

(defun Cx:escalaSieve ()
                        (mapcar '(lambda (n)
                                             (nth n (Cx:cromatica))
			         )
                                 (Cx:sieve+T  (list  '(4  0)))
                        )
)


(defun lista_de_faces (#ss / i face)
                                       (setq i 0)
                                       (while (setq face (ssname #ss  i))
					 
					      (setq lista_faces (cons face lista_faces)
						    i           (1+ i)
					      )
				       )
)

  
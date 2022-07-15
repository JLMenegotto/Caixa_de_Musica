
;;                                                                                          
;;#u  Representa a variável  *rtm_paso1*                                                     
;;                                                                                          
(defun Cx:Distribuir_por_normais (#u1)
                                        (Cx:Control_andamento2 #u1) 
                                        (cond					  
                                             ((Cx:es_mult? #u1  4) (setq *rtm_padraoM* (CM_index *rtm_M_Frase* 0 nil)))
                                             ((Cx:es_mult? #u1  3) (setq *rtm_padraoM* (CM_index *rtm_M_Frase* 1 nil)))
                                             ((Cx:es_mult? #u1  2) (setq *rtm_padraoM* (CM_index *rtm_M_Frase* 2 nil)))
			                     ((Cx:es_mult? #u1  1) (setq *rtm_padraoM* (CM_index *rtm_M_Frase* 3 nil)))
			                )
                                        (Cx:adi_Frase  "Normais ")
)

;;Ainda para fazer
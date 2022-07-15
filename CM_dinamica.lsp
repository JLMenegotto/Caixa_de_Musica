;;                                                                                         
;;  Inicia os par�metros de Din�mica                                                       
;;                                                                                         
;;                                                                                         

(defun Cx:ini_dinamica ()
      (Cx:error "dina_01")
      (setq
            *rtm_fdina*      1.0 ;; Fator de din�mica                
            *Pl_dina*        1.0 ;; Plano de din�mica                
            *rtm_dinanda*    1.0 ;; Fator de din�mica por andamento  
            *rtm_L_dinamica* (Cx:contar 0 30)
            *rtm_M_dinamica* (length *rtm_L_dinamica*)
      )
)
;; Modifica o fator de din�mica                                                            
;; #f fator de corre��o + aumenta - diminue                                                
(defun Cx:dina (#f)
      (setq *rtm_fdina* (if #f
                              (+ #f *rtm_fdina*)
                              1.00
                        )
      )
)


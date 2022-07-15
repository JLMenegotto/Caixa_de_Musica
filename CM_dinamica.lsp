;;                                                                                         
;;  Inicia os parâmetros de Dinâmica                                                       
;;                                                                                         
;;                                                                                         

(defun Cx:ini_dinamica ()
      (Cx:error "dina_01")
      (setq
            *rtm_fdina*      1.0 ;; Fator de dinâmica                
            *Pl_dina*        1.0 ;; Plano de dinâmica                
            *rtm_dinanda*    1.0 ;; Fator de dinâmica por andamento  
            *rtm_L_dinamica* (Cx:contar 0 30)
            *rtm_M_dinamica* (length *rtm_L_dinamica*)
      )
)
;; Modifica o fator de dinâmica                                                            
;; #f fator de correção + aumenta - diminue                                                
(defun Cx:dina (#f)
      (setq *rtm_fdina* (if #f
                              (+ #f *rtm_fdina*)
                              1.00
                        )
      )
)


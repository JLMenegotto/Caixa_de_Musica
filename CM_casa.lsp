;; Transforma a coordenada Real em casa modular Inteira                                    
(defun Cx:casa (#p)
      (mapcar 'fix (mapcar '/ #p (list *rtm_unidad*  *rtm_unidad*  *rtm_unidad*)))
)
;; Verifica se #p é uma cooerdenada X Y Z                                                  
(defun Cx:coordenada? (#p)
      (and #p
           (listp #p)
           (= (length #p) 3)
           (equal '(T T T) (mapcar 'numberp #p))
      )
) 
;; Converte a coordenada em casa modular                                                   
;; #coor Ponto a traduzir ou mensagem de texto                                             

(defun Cx:XYZ->CMO (#coor)
      (Cx:error "casa_02")
      (cond ((Cx:coordenada? #coor)
             (setq *rtm_L_tocadas-N* (cons #coor *rtm_L_tocadas-N*))
             (Cx:MOD->STO #coor)
            )
            (t (Cx:MOD->STO #coor))
      )
)

;;                                                                                         
;; Define o som tônico para a coordenada capturada                                         
;; #coor é a coordenada em número real ou uma mensagem de texto                            
;;                                                                                         
(defun Cx:MOD->STO (#coor / x1 x2 x3 y1 y2 y3 z1 z2 z3)

      (Cx:error "casa_03")
      (cond
            ((Cx:string? #coor) (list #coor))
            (t
             (setq
                   CM         (Cx:casa #coor) 
                   x1              (Cx:ModV (nth 0 CM) *rtm_M_tempos*)
                   y1              (Cx:ModV (nth 1 CM) *rtm_M_escala*)
                   z1              (Cx:ModV (nth 2 CM) *rtm_M_oitava*)
                   x3         (nth (Cx:ModV (nth 0 CM) *rtm_M_dinamica*) *rtm_L_dinamica*)
                   y3         (nth (Cx:ModV (nth 1 CM) *rtm_M_dinamica*) *rtm_L_dinamica*)
                   z3         (nth (Cx:ModV (nth 2 CM) *rtm_M_dinamica*) *rtm_L_dinamica*)
                   dina       (/ (+ (* *rtm_dinamicaX* x3)
                                    (* *rtm_dinamicaY* y3)
                                    (* *rtm_dinamicaZ* z3)
                                 )
                                 3.0
                              )
                   *rtm_dura* (nth x1 *rtm_L_tempos*)
                   *rtm_ClAl* (nth y1 *rtm_L_escala*)
                   *rtm_8vas* (nth z1 *rtm_L_oitava*)
                   *rtm_freq* (Cx:frequencia *rtm_ClAl* *rtm_8vas*)
                   *rtm_difr* (Cx:dista->freq  #coor)
             )
             
             (Cx:def_nota)
             (Cx:def_dura)
             (Cx:def_dina dina)
             (list *rtm_nota* *rtm_dura* *rtm_dina*)
            )
      )
)

;; Define a nota                                                                            
(defun Cx:def_nota ()
      (setq *rtm_nota*
                 (cond
                       ((= *rtm_metodo* "14")                              *rtm_difr*)
                       ((and (Cx:usaMAX?) (Cx:usaFRQ?))                    *rtm_freq*)
                       ((and (Cx:usaMAX?) (Cx:no_usaFRQ?)) (strcat         *rtm_ClAl* (Cx:string *rtm_8vas*) " "))
                       (                  (Cx:usaFRQ?)     (strcat ":hei " *rtm_freq*))
                       (t                                  (strcat ":hei " *rtm_ClAl* (Cx:string *rtm_8vas*) " "))
                 )
      )
      (Cx:Ciclos_12) ;;Verifica ciclos dodecafónicos
)
;; Define a duração                                                                        
(defun Cx:def_dura ()
      (setq *rtm_dura*
                 (cond
                       ((Cx:usaMAX?)                       (strcat " " (rtos (* 1000 (atof *rtm_dura*)) 2 4) " "))
                       (t                                  (strcat " :dur " *rtm_dura* " "))
                 )
      )
)
;; Define a dinámica                                                                       
(defun Cx:def_dina (#d)
      (setq *rtm_dina*
                 (cond
                       ((Cx:usaMAX?)                       (strcat " "      (Cx:dinamica_total #d)))
                       (t                                  (strcat " :dyn " (Cx:dinamica_total #d)))
                 )
      )
)
;; Calcula a freqüência de uma nota da escala cromática                                    
;; Freqüência do C0 = "A0" * 1.1892 = 27.5Hz * 1.1892 = 32.703                             
(defun Cx:frequencia (#n #h)
       (rtos (* (cadr  (assoc #n *rtm_CA_frequencias*))
                (* 100 (atoi (Cx:String #h)))
             ) 2 2
       )
)
;; Calcula a distância como freqüência                                                     
(defun Cx:dista->freq (#l) (rtos (* 10 (distance (list 0 0 0) #l)) 2 0))

(defun Cx:dinamica_total (#d)
               (rtos (* *Pl_dina* *rtm_dinanda* (+ *rtm_fdina* #d)) 2 2)
)
;;                                                                                                                               
;; Abre o arquivo LSP para escrever o cabeçalho                                                                                  
;;                                                                                                                               

(defun Cx:Abrir_arquivo (#a / arqLSP arqINt)

                                 (Cx:error  "arqu_01")

                                 (setq 
				        arqLSP       (strcat *rtm_drive*  #a  ".lsp")  
                                        modogravar   (if (findfile arqLSP)
				 		          "a"
						          "w"
						     )
                                        *rtm_arqINt* (open arqLSP  modogravar)
				 )
                                 (Cx:error  "arqu_02")
                                 (if (Cx:no_usaMAX?)
                                     (write-line
				              (strcat  
					 	       "\n;; "                                (Cx:tablin)
						       "\n;; Início do arquivo " *rtm_dibujo* (Cx:tablin)
						       "\n;; "                                (Cx:tablin)
						       ";; "                                  (Cx:tablin)
					               "\n\t(setf *minimum-stack-overflow-size* (* 60 1048576))\n"
						       "\n"
                                                       "\n(defun " *rtm_NomeOpus* " () \n"   
					      )
				               *rtm_arqINt*
				     )
                                  )                                 
                                  (Cx:error "arqu_02a")
)

;;                                                                                                                               
;; Escreve as definições de instruentos e vozes no arquivo LSP                                                                   
;;                                                                                                                               
(defun Cx:Escrever_MIDI ()
                               (Cx:error  "arqu_03")
                               (if (Cx:no_usaMAX?)
				   (progn
                                       (write-line
                                           (Cx:unir_str
                                                 (mapcar
					               '(lambda (i)
                                                                (strcat "\n\t(program-change " i " " (cadr (assoc i  *rtm_L_programa*)) ")")
					                )
					                (reverse *rtm_L_Vozes*)
					         )
				           )
      				           *rtm_arqINt*
				      )
                                      (Cx:error  "arqu_04")
                                      (Cx:saida_MIDI)
				  )
		               )
)

(defun Cx:saida_MIDI ()
                                    (write-line
                                               (strcat
	                                              "\n\t(realize "
				                      "\n\t\t(midi :sync "  
					              "\n\t\t\t:midi-file "  "\"" *rtm_drive*  *rtm_NomeOpus*  ".mid"  "\""
					              "\n\t\t\t:tempo "  *rtm_pulsos*
					              "\n\t\t\t"						      
					                                          (apply 'strcat (reverse *rtm_L_Voz*))
			                              "\n\t\t)"                                                                 
			                              "\n\t)"                                                                   
          				              "\n)"
						      (Cx:informaciones)
			                       )
				                *rtm_arqINt*
				    )
)

(defun Cx:informaciones ()
                                     (strcat
					              "\n;; Dados do arquivo      "                            (Cx:tablin)
					              "\n;;                       "                            (Cx:tablin)
					              "\n;; Pasta do arquivo      "  *rtm_pastas*              (Cx:tablin)
						      "\n;; Desenho gerador       "  *rtm_dibujo*              (Cx:tablin)
					              "\n;; Pulsos/minuto         "  *rtm_pulsos*              (Cx:tablin)
				                      "\n;; Tamanho módulo inicial"  (Cx:string *rtm_unidai*)  (Cx:tablin)
						      "\n;; Tamanho módulo final  "  (Cx:string *rtm_unidad*)  (Cx:tablin)
						      "\n;; Período musical       "  (Cx:string *rtm_periodo*) (Cx:tablin)
				                      "\n;; Entidades traduzidas  "  (Cx:string *total_faces*) (Cx:tablin)
						      "\n;; Tamanho frase         "  (Cx:string *rtm_M_Frase*) (Cx:tablin)
					              "\n;;                       "                            (Cx:tablin)
                                                      "\n;; Desloca  Vozes        "  *rtm_desloca*             (Cx:tablin)
				                      "\n;; Modular               "  *rtm_modular*             (Cx:tablin)
				                      "\n;; Muda intervalos       "  *rtm_interva*             (Cx:tablin)
				                      "\n;; Rota ritmos           "  *rtm_rotari*              (Cx:tablin)
                                                      "\n;; Usa frequência        "  *rtm_usafreq*             (Cx:tablin)
				                      "\n;;                       "                            (Cx:tablin)
					              "\n;; Organização das vozes "  (Cx:Vozes)                (Cx:tablin)
					              "\n;; Padrão estrutural     "  ctrl_vario                (Cx:tablin)
				     )
)

(defun Cx:Tablin  ()                "\t\t\t\t\t\t\t\t\t\t\t\t\t\t\t")
(defun Cx:Vozes   ()                (Cx:unir_str  *rtm_cab_vozes*))
(defun Cx:Alturas ()                (Cx:unir_str  (mapcar 'cx:string    *rtm_L_oitava*)))
(defun Cx:tempos ()                 (Cx:unir_str  *rtm_T_tempos_i*))

(defun Cx:gravar_linha (#lin)
                                    (Cx:error "arqu_05") 
                                    (if *rtm_arqINt*  (write-line   #lin   *rtm_arqINt*))	   
)

(defun Cx:Fechar_arquivo ()
                                    (Cx:Escrever_MIDI)
       	 			    (close  *rtm_arqINt*)
)

(defun Cx:registra_voz (#v #g #lnotas #stave)
                                    (Cx:error "arqu_06")
                                    (Cx:gravar_linha
				                      (Cx:notas_da_voz  #v #g  #lnotas #stave)  
 				    )
                                    (if #lnotas
                                                 (Cx:funcao_da_voz  #v   #g)
			  	    )
  				    (Cx:error "arqu_09") 
)

(defun Cx:notas_da_voz (#v  #g  #lnotas  #stave)

                                    (if (Cx:usaMAX?)
				        (Cx:registro_nota   #lnotas)
                                        (strcat
				          "\n\t(setf Voz_" #v  (itoa #g) 
                                          "\n\t\t(note :pos " (Cx:deslocou?  #v)     
				          "\n\t\t\t(:voice-class " #v 
                                                                   (Cx:registro_nota   #lnotas) 
                                          "\n\t\t\t)))"
				        )
				    )
)

(defun Cx:funcao_da_voz (#n #g)
                                    (setq *rtm_L_Voz*   (cons (strcat "\n\t\t\t(Voz_"  #n  (itoa #g) ")") *rtm_L_Voz*))
				    (setq *rtm_L_Vozes* (cons  #n  *rtm_L_Vozes*))
)

;; Verifica se foi selecionado o modo Deslocar das vozes                                                            
(defun Cx:deslocou? (#n / posi-o posi-d)
                                    
                                    (setq
				          *rtm_F_desloca*  *rtm_M_Frase*
				          posi-o  "0"
					  posi-n  (eval (read (strcat "*rtm_pos" #n "*")))
				          posi-d  (itoa (* *rtm_F_desloca*  (atoi posi-n)))
			            )
                                    (if (= *rtm_desloca* "1")
                                        (cond
					      ((= posi-n  "0")  posi-o)
				              (t                posi-d)
 			                )
				        posi-o
				    )
)

(defun Cx:registro_nota (#lnotas)
                                    (apply 'strcat
                                            (mapcar '(lambda (no) 
                                                     (apply 'strcat
			                                     (mapcar
			                                           '(lambda (n)
			                                                        (Cx:unir_nota  n)
			                                            )
			                                            no
			                                     )
					             )
					    )
					    #lnotas
		                          )
			            )
)

(defun Cx:unir_nota  (#l)

                                   (if (Cx:no_usaMAX?)
                                       (if (listp #l)
				           (strcat "\n\t\t\t\t\t\t(" (Cx:unir_str  #l) ")")
				           (Cx:unir_str  #l)  
				       )
				       (if (listp #l)
				           (strcat "\n"              (Cx:unir_str  #l))
				           (Cx:unir_str  #l)  
				       )
				   )
)


;;;(setq escalausada   (if (Cx:dodecafonica?)
;;;                                                        "S12"
;;;                                                        (eval (read (strcat "*rtm_escala_" (nth 0 #l) "_txt*")))
;;;                                                     )

(defun Cx:Registravozes (#l)
  				   (Cx:error "arqu_11") (setq vooo #l)
                                   (setq *rtm_cab_vozes*
					 (strcat *rtm_cab_vozes* "\n;;VOZ: "  (nth 0  #l)
						                 " LAYER: "   (nth 1  #l)
 						                              (Cx:Str_tempos      (nth 0  #l))
                                          			 " MÉTODO: "  (Cx:registra_metodo (nth 0  #l))
						                 " ESCALA: "  "escalausada"
                                                                 " ATONAL : " *rtm_atonal*
                                                                 " POSIÇÃO: " (eval (read (strcat "*rtm_pos"     (nth 0  #l) "*"))) 
                                                                 " PULO: "    (eval (read (strcat "*rtm_pul"     (nth 0  #l) "*")))
                                                                 " PERIODO: " (eval (read (strcat "*rtm_per"     (nth 0  #l) "*"))) 
                                                                 " RETORNO: " (eval (read (strcat "*rtm_rit"     (nth 0  #l) "*")))
                                                                     
				         )
			           )
)	    

(defun Cx:registra_metodo (#m)
                                   (cond
				         ((=   "0" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Morfologia_S")
				         ((=   "1" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Morfologia_T")
				         ((=   "2" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Trama_I")
				         ((=   "3" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Trama_M")
				         ((=   "4" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Trama_Q")
				         ((=   "5" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Trama_P")
				         ((=   "6" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_21")
				         ((=   "7" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_321")
				         ((=   "8" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_4321")
				         ((=   "9" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_54321")
				         ((=  "10" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_1054321")
				         ((=  "11" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_faces")
				         ((=  "12" (eval (read (strcat "*metodo_Voz_0" #m "*")))) "Série_01")					 
				         (t                                                       "Morfologia_S")
				   )
)

(defun Cx:Str_Escala (#voz)        (Cx:unir_str (eval (read (strcat "*rtm_escala_"  #voz "*")))))

(defun Cx:Str_tempos (#voz)
                                   (strcat 
                                          " TEMPO: " (Cx:unir_str (nth  (eval (read (strcat "*tempo_Voz_0" #voz "*"))) *rtm_tempos*))  
                                          " VELOC: "              (rtos (eval (read (strcat "*veloc_Voz_0" #voz "*"))) 2 1) 
                                          " RETRO: "              (itoa (eval (read (strcat "*retro_Voz_0" #voz "*"))))
			           )
)

;;Concatena em uma corrente de caracteres da  lista  #l                                                                              
(defun Cx:unir_str (#l)
                                   (apply 'strcat
                     			          (if (listp #l)
                     		 	               #l
                     			              (list #l)
                     			          )
                     		   )
)

(defun Cx:Mnsg_transform (#msg #pad / msg)
      (Cx:error "arqu_12")
      (cond ((Cx:no_usaMAX?)
               (setq msg (strcat (if #msg (strcat "\n\t\t;; " #msg) " ")
                                 (if #pad (strcat "\n\t\t;; " (Cx:lis->Str *rtm_padraoM*)) " ")
                         ) 
                     *rtm_L_tocadas* (cons (Cx:XYZ->CMO msg) *rtm_L_tocadas*)
               ))
      )
)


(defun C:CX ()
                             (Cx:error  "Sist_001")
                             (Cx:Carga_Sistema) 
                             (Cx:Inicia_variaveis)
                                                   (Cx:error  "Sist_20")
                             (Cx:Listar_os_layers)
                                                   (Cx:error  "Sist_21") 
                             (Cx:Activa_dialogo)
                                                   (Cx:error  "Sist_22")
                             (cond
			           ((= *rtm_accion* 1) 
 				                       (Cx:executa_caixa)
				   )
				   (t                  (prompt "\nFunção cancelada agora"))
		             )
				  
		             (setvar "osmode" *rtm_oldosm*)
                             (princ)
)

(defun Cx:executa_caixa ()
  
                              (setq p1 (getpoint "\nMarque um ponto"))
                              (Cx:Abrir_arquivo  *rtm_NomeOpus*) (Cx:error  "sist_05")

                              (Cx:Analiza_as_vozes)              (Cx:error  "sist_04")
  
                              (Cx:Fechar_arquivo)                (Cx:error  "sist_06")
)

(defun Cx:Carga_Sistema ()
                             (mapcar 'load '(
					     "CM_Instrumentos.lsp"
                                             "CM_dodecafonica.lsp"
					     "CM_Escalas.lsp"
					     "CM_Tempo.lsp"
					     "CM_Dinamica.lsp"
					     "CM_Unidades.lsp"
					     "CM_arqu.lsp"
					     "CM_casa.lsp"
					     "CM_dial.lsp"
					     "CM_enti.lsp"
					     "CM_geom.lsp"
					     "CM_util.lsp"
					     "CM_puntos.lsp"
					     "CM_tocar.lsp"					     
					     "CM_Var_morfolog.lsp"
					     "CM_Var_multiplos.lsp"
					     "CM_Var_normais.lsp"
 					     "CM_Var_andamento.lsp"
					    )
		             )
                             (Cx:AmbienteX)                         
)

(defun Cx:inicia_variaveis ()

                             (setvar "DIMZIN" 4)
  
                             (Cx:addlayer '("Pts_Normal"  "10"))
                             (Cx:addlayer '("Pts_Invert"  "20"))
                             (Cx:addlayer '("Pts_Silenc"  "30"))
  
                             (setq
			           *rtm_oldosm*             (getvar "osmode")
                                   *rtm_pastas*             (getvar "dwgprefix")
			           *rtm_dibujo*             (getvar "dwgname")
			           *rtm_ar_DCL*             "CM_dial.dcl"
				   *rtm_di_DCL*             "Caixa_Musical"
				   
				   *rtm_Caixa*              "CaixaM"
				   *rtm_drive*              "c:\\"
				   *rtm_cab_series*         "-"
				   *rtm_cab_vozes*          "-"
				   *rtm_NomeOpus*           (substr (getvar "dwgname") 1 (- (strlen (getvar "dwgname")) 4))

				   *rtm_vozes*             '("0" "1" "2" "3" "4" "5" "6" "7" "8" "9")
				   *rtm_croma*             '(":c" ":cs" ":d" ":ds" ":e" ":f" ":fs" ":g" ":gs" ":a" ":as" ":b")

                                   *rtm_CA_frequencias*     (list
								 '(":c"   0.69314)
		                                            	 '(":cs"  1.09861)
		  		                            	 '(":d"   1.38629)
				                            	 '(":ds"  1.60944)
				                            	 '(":e"   1.79176)
				                            	 '(":f"   1.94591)
		       	   	                            	 '(":fs"  2.07944)
		       	   	                            	 '(":g"   2.19722)
		       	   	                            	 '(":gs"  2.30259)
		       	   	                            	 '(":a"   2.39790)
		       	   	                            	 '(":as"  2.48491)
						            	 '(":bf"  2.56495)
		       	   	                            	 '(":b"   2.63906)
				                            )

                                   *rtm_atonal*            "0"
                                   *rtm_randomico*         (getvar "DATE")                                  
				   *rtm_ritmo*              0
				   *rtm_periodo*            32
                                   *rtm_M*                  9 ;;Módulo de pontos
				   *rtm_M_Frase*            5
				   *rtm_F_desloca*          1
				   *rtm_metodo*             "0"
				   *rtm_dinanda*            1.0 
				   *rtm_fdina*              1.0
				   *rtm_unidad*             1.0
				   *rtm_mod_geometria*      3.0
                                   *rtm_ciclo12*            1
                                   *rtm_O_vozes*           '()
				   *rtm_O_layers*          '()
				   *rtm_L_Voz*             '()
				   *rtm_L_Vozes*           '()
				   *rtm_L_tocadas-N*       '()
				   *lst_frases*            '()
		             )
  
                             (setvar "osmode" 0)
                             (Cx:ini_Instrumentos)             (Cx:error "sist_07")
                             (Cx:ini_tempo)                    (Cx:error "sist_08")
                             (Cx:ini_escalas)                  (Cx:error "sist_09")
                             (Cx:ini_dinamica)                 (Cx:error "sist_10")
                             (Cx:Grad_unidade  *rtm_unidad* 1) (Cx:error "sist_11")
                             (Cx:Inicie_paso)                  (Cx:error "sist_12")
                             (Cx:SubModulos)
                             

                             (Cx:Modulo_da_voz  0  "0")         
                             (Cx:Modulo_da_voz  1  "0")         
                             (Cx:Modulo_da_voz  2  "0")         
                             (Cx:Modulo_da_voz  3  "0")         
                             (Cx:Modulo_da_voz  4  "0")         
                             (Cx:Modulo_da_voz  5  "0")          
                             (Cx:Modulo_da_voz  6  "0")         
                             (Cx:Modulo_da_voz  7  "0")
                             (Cx:Modulo_da_voz  8  "0")
                             (Cx:Modulo_da_voz  9  "0")
                                                               (Cx:error  "sist_13")
)

;;                                                                                                                                             
;;                                                                                                                                             
;; Inicia os instrumentos                                                                                                                      
;;                                                                                                                                          
;;                                                                                                                                          

(defun Cx:ini_Instrumentos ()
                        (Cx:error  "Instrumentos_01")                               	                                               
                        (setq  *rtm_L_instru*  (list
						 '("+ Piano_S      " ":acoustic-grand-piano" (                5   6  7   )  1.00 ":soprano")       ;;ok
						 '("+ Piano_T      " ":acoustic-grand-piano" (        3   4   5          )  1.00 ":treble")        ;;ok
                                                 '("+ Piano_B      " ":acoustic-grand-piano" (1   2   3                  )  1.00 ":bass")          ;;ok
						 '("+ Vibra S      " ":vibraphone"           (                5   6      )  0.75 ":soprano")       ;;ok
						 '("+ Vibra MS     " ":vibraphone"           (            4   5          )  0.75 ":mezzo-soprano") ;;ok
  					         '("+ Vibra T      " ":vibraphone"           (        3   4              )  0.75 ":treble")        ;;ok
                                                 '("- Vibra S      " ":vibraphone"           (                    6  7   ) -0.75 ":soprano")       ;;ok
						 '("- Vibra MS     " ":vibraphone"           (                5   6      ) -0.75 ":mezzo-soprano") ;;ok
  					         '("- Vibra T      " ":vibraphone"           (        3   4   5          ) -0.75 ":treble")        ;;ok
                                                 '("+ Cravo        " ":harpsichord"          (        3   4   5   6      )  0.50 ":treble")        ;;ok
                                                 '("+ Cristal T    " ":crystal"              (        3   4              )  0.10 ":treble")        ;;ok
                                                 '("+ Cristal MS   " ":crystal"              (            5   6          )  0.10 ":mezzo-soprano") ;;ok
                                                 '("+ Sinos   MS   " ":tubular-bells"        (            5   6          )  1.00 ":mezzo-soprano") ;;ok
                                                 '("+ Sinos   B    " ":tubular-bells"        (    2   3                  )  1.00 ":bass")          ;;ok
						 '("- Sinos   B    " ":tubular-bells"        (    2   3                  ) -1.00 ":bass")          ;;ok
						 '("+ Flauta       " ":flute"                (        3   4              )  0.05 ":treble")        ;;ok
                                                 '("+ Oboé         " ":oboe"                 (        3   4              )  0.10 ":treble")        ;;ok
                                                 '("+ Violino_A    " ":violin"               (        3   4   5          )  0.20 ":treble")        ;;ok
						 '("+ Cello        " ":cello"                (1   2                      )  0.20 ":bass")          ;;ok
						 '("- Cordas A     " ":string-ensemble-2"    (        3   4   5          ) -0.20 ":treble")        ;;ok
                                                 '("- Cordas B     " ":string-ensemble-1"    (1   2   3                  ) -0.10 ":bass")          ;;ok
                                                 '("--Cordas B     " ":string-ensemble-2"    (1   2   3                  ) -0.50 ":bass")          ;;ok
                                                 '("+ Goblins      " ":goblins"              (1   2   3   4   5  6  7    )  0.10 ":soprano")       ;;ok
						 '("+ Goblins S    " ":goblins"              (                5  6       )  0.10 ":soprano")       ;;ok
						 '("+ Goblins T    " ":goblins"              (        3   4              )  0.15 ":treble")        ;;ok
						 '("+ Goblins B    " ":goblins"              (    2   3                  )  0.25 ":bass")          ;;ok
						 '("- Goblins T    " ":goblins"              (        3   4              ) -0.50 ":bass")          ;;ok
                                                 '("- Goblins B    " ":goblins"              (    2   3                  ) -0.50 ":bass")          ;;ok
						 '("--Sci-fi  BT   " ":sci-fi"               ( 1  2   3   4              ) -1.00 ":bass")          ;;ok
						 '("- Atmósfera BT " ":atmosphere"           ( 1  2   3   4              ) -0.50 ":bass")          ;;ok
						 '("--Atmósfera B  " ":atmosphere"           ( 1  2   3                  ) -1.00 ":bass")          ;;ok
						 '("+ Baixo acust. " ":acoustic-bass"        (    2   3                  )  0.60 ":bass")          ;;ok
                                                 '("+ Baixo eletr. " ":pick-electric-bass"   (    2   3                  )  0.60 ":bass")          ;;ok
                                                 '("+ AAhs T       " ":choir-aahs"           (        3   4              )  1.00 ":treble")        ;;ok
						 '("+ OOhs T       " ":voice-oohs"           (        3   4              )  1.00 ":treble")        ;;ok
						 '("+ Melodic tom T" ":melodic-tom"          (        3   4              )  0.50 ":treble")        ;;ok
						 '("+ Toc toc T    " ":woodblock"            (        3   4   5          )  1.00 ":treble")        ;;ok
						 '("+ Timbales B   " ":timpani"              (    2   3   4              )  0.20 ":bass")          ;;ok
					      )
			)
  
;; Lista dos instrumentos para Display no quadro de diálogo - Estrutura da lista = (("0" ":acoustic-grand-piano" 1.0)  ("1" ....)  ("2" ...))        
                        
                        (setq *rtm_L_programa*  (mapcar '(lambda (voz) (Cx:lista_orquest voz))
                                                         *rtm_vozes*
					        )
			      
;; Altura dos timbres - Estrutura da lista = (("0" (1 2 3 4) 1.0 ":bass") ("1"...) ("2...))                                                          

			      *rtm_A_programa* (mapcar '(lambda (voz) (Cx:lista_timbres voz))
                                                         *rtm_vozes*
		                               )
			      
			)
)

(defun Cx:lista_timbres (#voz)
                              (list #voz
                                    (nth 2 (car *rtm_L_instru*))
			            (nth 3 (car *rtm_L_instru*))
			            (nth 4 (car *rtm_L_instru*))
			      )
)

(defun Cx:lista_orquest (#voz)
                             (list #voz
                                    (nth 1 (car *rtm_L_instru*))
			            (nth 3 (car *rtm_L_instru*))
			            (nth 4 (car *rtm_L_instru*))
			     )
)
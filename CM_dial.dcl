Caixa_Musical :dialog { label = "A Caixa de Música";

                 
                      :boxed_column {label = "Configurar Instrumentos e vozes";
                                              Orquestra;
                                    }                                     
                       spacer_1;
                     :row {
                                     :boxed_column {
                                                     width = 10;
                                                     fixed_width = true;
                                                     :row {:text {label = "Peça";}    Musica;}
                                                     :row {:text {label = "Período";} Periodo;}
                                                     :row {:text {label = "Frase";}   Frase;}
                                                     :row {:text {label = "Unidade";} Unidade;}                                                    
                                                     :row {:text {label = "Pulsos";}  Pulsos;}
                                                   }
                                     :boxed_column {label = "Regras";
                                                    width = 10;
                                                    fixed_width = true;
                                                    :row {
                                                           :column { Regla_01;
                                                                     Regla_02;
                                                                     Regla_03;
                                                                   }        
                                                           :column { Regla_08;
                                                                     Regla_06;
                                                                     Regla_09;                                                                
                                                                   }
                                                           :column { Regla_05;
                                                                     Regla_07;
                                                                     Regla_04;                                                                
                                                                   }
                                                          }
                                                    }
                                     :boxed_column  {label = "Dinâmica";
                                                     width = 10;
                                                     fixed_width = true;
                                                     :column {
                                                              :row {:text {label = "Desloca";   } Desloca;}
                                                              :row {:text {label = "Dinâmica X";} DinamicaX;}
                                                              :row {:text {label = "Dinâmica Y";} DinamicaY;}
                                                              :row {:text {label = "Dinâmica Z";} DinamicaZ;}
                                                             }
                                                    }
                            }

                                  spacer_1;              
                  ok_cancel;        
}

                         
Desloca           :Slider_15     {big_increment   = 1;
                                  small_increment = 1;
                                  key             = "Desloca";
                                 }                              
DinamicaX         :Slider_15     {big_increment   = 1;   
                                  small_increment = 0.1;
                                  key             = "DinamicaX";
                                 }
DinamicaY         :Slider_15     {big_increment   = 1;   
                                  small_increment = 0.1;
                                  key             = "DinamicaY";
                                 }
DinamicaZ         :Slider_15     {big_increment   = 1;   
                                  small_increment = 0.1;
                                  key             = "DinamicaZ";
                                 }                                
                                
Slider_15        :slider        {                      
                                 width           = 15;  
                                 height          = 1;   
                                 fixed_width     = true;
                                 fixed_height    = true;
                                 big_increment   = 1;   
                                 small_increment = 0.1; 
                                 max_value       = 10;  
                                 min_value       = 0;   
                                 alignment       = left;
                                } 
                                                                                 
Musica            :E_box_5 {key = "OPUS";}
Periodo           :E_box_5 {key = "PERIODO";}
Frase             :E_box_5 {key = "FRASE";}
Unidade           :E_box_5 {key = "UNIDADE";}

Pulsos            :row {:Slider_tem       {key = "PULSOS";}
                        :text {width = 2;  key = "TXTPULSOS"; value = "60";}
                       }

Slider_tem        :slider {
                            width           = 10;
                            height          = 1;                                 
                            fixed_width     = true;
                            fixed_height    = true;
                            big_increment   = 1;
                            small_increment = 1;
                            max_value       = 180;
                            min_value       = 10;
                            alignment       = left;
                          }
                       
Regla_01          :toggle       {label = "Desloca Vozes";    key = "Regla_01";}
Regla_02          :toggle       {label = "Modular";          key = "Regla_02";}
Regla_03          :toggle       {label = "Alt. Intervalos";  key = "Regla_03";}
Regla_04          :toggle       {label = "Usa frequência";   key = "Regla_04";}
Regla_05          :toggle       {label = "Marcar pontos";    key = "Regla_05";}
Regla_06          :toggle       {label = "Rotar tempos";     key = "Regla_06";}
Regla_07          :toggle       {label = "Formato MAX";      key = "Regla_07";}
Regla_08          :toggle       {label = "Atonal";           key = "Regla_08";}
Regla_09          :toggle       {label = "Tempo progressão"; key = "Regla_09";}

Voz_00            :toggle       {label = "0";  key = "Voz_00";}
Voz_01            :toggle       {label = "1";  key = "Voz_01";}
Voz_02            :toggle       {label = "2";  key = "Voz_02";}
Voz_03            :toggle       {label = "3";  key = "Voz_03";}
Voz_04            :toggle       {label = "4";  key = "Voz_04";}
Voz_05            :toggle       {label = "5";  key = "Voz_05";}
Voz_06            :toggle       {label = "6";  key = "Voz_06";}
Voz_07            :toggle       {label = "7";  key = "Voz_07";}
Voz_08            :toggle       {label = "8";  key = "Voz_08";}
Voz_09            :toggle       {label = "9";  key = "Voz_09";}

Laye_Voz_00       :Pop_Laye     {key = "Laye_Voz_00";}
Laye_Voz_01       :Pop_Laye     {key = "Laye_Voz_01";}
Laye_Voz_02       :Pop_Laye     {key = "Laye_Voz_02";}
Laye_Voz_03       :Pop_Laye     {key = "Laye_Voz_03";}
Laye_Voz_04       :Pop_Laye     {key = "Laye_Voz_04";}
Laye_Voz_05       :Pop_Laye     {key = "Laye_Voz_05";}
Laye_Voz_06       :Pop_Laye     {key = "Laye_Voz_06";}
Laye_Voz_07       :Pop_Laye     {key = "Laye_Voz_07";}
Laye_Voz_08       :Pop_Laye     {key = "Laye_Voz_08";}
Laye_Voz_09       :Pop_Laye     {key = "Laye_Voz_09";}

Inst_Voz_00       :Pop_Inst     {key = "Inst_Voz_00";}
Inst_Voz_01       :Pop_Inst     {key = "Inst_Voz_01";}
Inst_Voz_02       :Pop_Inst     {key = "Inst_Voz_02";}
Inst_Voz_03       :Pop_Inst     {key = "Inst_Voz_03";}
Inst_Voz_04       :Pop_Inst     {key = "Inst_Voz_04";}
Inst_Voz_05       :Pop_Inst     {key = "Inst_Voz_05";}
Inst_Voz_06       :Pop_Inst     {key = "Inst_Voz_06";}
Inst_Voz_07       :Pop_Inst     {key = "Inst_Voz_07";}
Inst_Voz_08       :Pop_Inst     {key = "Inst_Voz_08";}
Inst_Voz_09       :Pop_Inst     {key = "Inst_Voz_09";}

Temp_Voz_00       :Pop_Temp     {key = "Temp_Voz_00";}
Temp_Voz_01       :Pop_Temp     {key = "Temp_Voz_01";}
Temp_Voz_02       :Pop_Temp     {key = "Temp_Voz_02";}
Temp_Voz_03       :Pop_Temp     {key = "Temp_Voz_03";}
Temp_Voz_04       :Pop_Temp     {key = "Temp_Voz_04";}
Temp_Voz_05       :Pop_Temp     {key = "Temp_Voz_05";}
Temp_Voz_06       :Pop_Temp     {key = "Temp_Voz_06";}
Temp_Voz_07       :Pop_Temp     {key = "Temp_Voz_07";}
Temp_Voz_08       :Pop_Temp     {key = "Temp_Voz_08";}
Temp_Voz_09       :Pop_Temp     {key = "Temp_Voz_09";}

Modo_Voz_00       :Pop_Esca     {key = "Modo_Voz_00";}
Modo_Voz_01       :Pop_Esca     {key = "Modo_Voz_01";}
Modo_Voz_02       :Pop_Esca     {key = "Modo_Voz_02";}
Modo_Voz_03       :Pop_Esca     {key = "Modo_Voz_03";}
Modo_Voz_04       :Pop_Esca     {key = "Modo_Voz_04";}
Modo_Voz_05       :Pop_Esca     {key = "Modo_Voz_05";}
Modo_Voz_06       :Pop_Esca     {key = "Modo_Voz_06";}
Modo_Voz_07       :Pop_Esca     {key = "Modo_Voz_07";}
Modo_Voz_08       :Pop_Esca     {key = "Modo_Voz_08";}
Modo_Voz_09       :Pop_Esca     {key = "Modo_Voz_09";}

Meto_Voz_00       :Pop_Meto     {key = "Meto_Voz_00";}
Meto_Voz_01       :Pop_Meto     {key = "Meto_Voz_01";}
Meto_Voz_02       :Pop_Meto     {key = "Meto_Voz_02";}
Meto_Voz_03       :Pop_Meto     {key = "Meto_Voz_03";}
Meto_Voz_04       :Pop_Meto     {key = "Meto_Voz_04";}
Meto_Voz_05       :Pop_Meto     {key = "Meto_Voz_05";}
Meto_Voz_06       :Pop_Meto     {key = "Meto_Voz_06";}
Meto_Voz_07       :Pop_Meto     {key = "Meto_Voz_07";}
Meto_Voz_08       :Pop_Meto     {key = "Meto_Voz_08";}
Meto_Voz_09       :Pop_Meto     {key = "Meto_Voz_09";}

Pos_00            :E_box_2      {key = "Pos_00";}
Pos_01            :E_box_2      {key = "Pos_01";}
Pos_02            :E_box_2      {key = "Pos_02";}
Pos_03            :E_box_2      {key = "Pos_03";}
Pos_04            :E_box_2      {key = "Pos_04";}
Pos_05            :E_box_2      {key = "Pos_05";}
Pos_06            :E_box_2      {key = "Pos_06";}
Pos_07            :E_box_2      {key = "Pos_07";}
Pos_08            :E_box_2      {key = "Pos_08";}
Pos_09            :E_box_2      {key = "Pos_09";}

Pul_00            :E_box_2      {key = "Pul_00";}
Pul_01            :E_box_2      {key = "Pul_01";}
Pul_02            :E_box_2      {key = "Pul_02";}
Pul_03            :E_box_2      {key = "Pul_03";}
Pul_04            :E_box_2      {key = "Pul_04";}
Pul_05            :E_box_2      {key = "Pul_05";}
Pul_06            :E_box_2      {key = "Pul_06";}
Pul_07            :E_box_2      {key = "Pul_07";}
Pul_08            :E_box_2      {key = "Pul_08";}
Pul_09            :E_box_2      {key = "Pul_09";}

Per_00            :E_box_2      {key = "Per_00";}
Per_01            :E_box_2      {key = "Per_01";}
Per_02            :E_box_2      {key = "Per_02";}
Per_03            :E_box_2      {key = "Per_03";}
Per_04            :E_box_2      {key = "Per_04";}
Per_05            :E_box_2      {key = "Per_05";}
Per_06            :E_box_2      {key = "Per_06";}
Per_07            :E_box_2      {key = "Per_07";}
Per_08            :E_box_2      {key = "Per_08";}
Per_09            :E_box_2      {key = "Per_09";}

Rit_00            :E_box_2      {key = "Rit_00";}
Rit_01            :E_box_2      {key = "Rit_01";}
Rit_02            :E_box_2      {key = "Rit_02";}
Rit_03            :E_box_2      {key = "Rit_03";}
Rit_04            :E_box_2      {key = "Rit_04";}
Rit_05            :E_box_2      {key = "Rit_05";}
Rit_06            :E_box_2      {key = "Rit_06";}
Rit_07            :E_box_2      {key = "Rit_07";}
Rit_08            :E_box_2      {key = "Rit_08";}
Rit_09            :E_box_2      {key = "Rit_09";}

Fes_00            :E_box_2      {key = "Fes_00";}
Fes_01            :E_box_2      {key = "Fes_01";}
Fes_02            :E_box_2      {key = "Fes_02";}
Fes_03            :E_box_2      {key = "Fes_03";}
Fes_04            :E_box_2      {key = "Fes_04";}
Fes_05            :E_box_2      {key = "Fes_05";}
Fes_06            :E_box_2      {key = "Fes_06";}
Fes_07            :E_box_2      {key = "Fes_07";}
Fes_08            :E_box_2      {key = "Fes_08";}
Fes_09            :E_box_2      {key = "Fes_09";}

Pop_Laye          :Pop_List20   {label = " ";}
Pop_Inst          :Pop_List20   {label = " ";}
Pop_Esca          :Pop_List5    {label = " ";}
Pop_Temp          :Pop_List15   {label = " ";}
Pop_Meto          :Pop_List25   {label = " ";}

Tog_Nor           :toggle       {label = "N";}

Texto_Tit1         :text        {width =  5;  fixed_width = true; alignment = left;}
Texto_Tit2         :text        {width = 25;  fixed_width = true; alignment = left;}
Texto_Tit3         :text        {width = 20;  fixed_width = true; alignment = left;}
Texto_Tit4         :text        {width = 15;  fixed_width = true; alignment = left;}
Texto_Tit5         :text        {width = 15;  fixed_width = true; alignment = left;}
Texto_Tit6         :text        {width = 25;  fixed_width = true; alignment = left;}
Texto_Tit7         :text        {width = 10;  fixed_width = true; alignment = left;}
Texto_Tit8         :text        {width = 10;  fixed_width = true; alignment = left;}
Texto_Tit9         :text        {width = 10;  fixed_width = true; alignment = left;}
Texto_Tit10        :text        {width = 10;  fixed_width = true; alignment = left;}

Texto_5           :text         {width = 3;   fixed_width = true; alignment = left;}

E_box_2           :edit_box     {width = 2;  fixed_width = true; alignment = left;}
E_box_5           :edit_box     {width = 5;  fixed_width = true; alignment = right;}

Pop_List25        :popup_list   {width = 25; fixed_width = true; alignment = left;}                               
Pop_List20        :popup_list   {width = 20; fixed_width = true; alignment = left;}
Pop_List15        :popup_list   {width = 15; fixed_width = true; alignment = left;}
Pop_List10        :popup_list   {width = 10; fixed_width = true; alignment = left;}                       
Pop_List5         :popup_list   {width =  5; fixed_width = true; alignment = left;}                               

Tit_voz           :Texto_Tit1   {value = "Voz";}
Tit_lay           :Texto_Tit2   {value = "Layer";}
Tit_ins           :Texto_Tit3   {value = "Instrumento";}
Tit_esc           :Texto_Tit4   {value = "Escala";}
Tit_tem           :Texto_Tit5   {value = "Tempo";}
Tit_met           :Texto_Tit6   {value = "Método";}
Tit_ent           :Texto_Tit7   {value = "Entrada";}
Tit_pul           :Texto_Tit8   {value = "Pulo";}
Tit_per           :Texto_Tit9   {value = "Periodo";}
Tit_rit           :Texto_Tit10  {value = "Retorno";}
Tit_fes           :Texto_Tit10  {value = "Fator Escala";}

Titulos           :row {Tit_voz; Tit_lay;     Tit_ins;     Tit_esc;     Tit_tem;     Tit_met;     Tit_ent; Tit_pul; Tit_per; Tit_rit; Tit_fes;}

Orquestra_00      :row {Voz_00;  Laye_Voz_00; Inst_Voz_00; Modo_Voz_00; Temp_Voz_00; Meto_Voz_00; Pos_00;  Pul_00;  Per_00;  Rit_00; Fes_00;}
Orquestra_01      :row {Voz_01;  Laye_Voz_01; Inst_Voz_01; Modo_Voz_01; Temp_Voz_01; Meto_Voz_01; Pos_01;  Pul_01;  Per_01;  Rit_01; Fes_01;}
Orquestra_02      :row {Voz_02;  Laye_Voz_02; Inst_Voz_02; Modo_Voz_02; Temp_Voz_02; Meto_Voz_02; Pos_02;  Pul_02;  Per_02;  Rit_02; Fes_02;}
Orquestra_03      :row {Voz_03;  Laye_Voz_03; Inst_Voz_03; Modo_Voz_03; Temp_Voz_03; Meto_Voz_03; Pos_03;  Pul_03;  Per_03;  Rit_03; Fes_03;}
Orquestra_04      :row {Voz_04;  Laye_Voz_04; Inst_Voz_04; Modo_Voz_04; Temp_Voz_04; Meto_Voz_04; Pos_04;  Pul_04;  Per_04;  Rit_04; Fes_04;}
Orquestra_05      :row {Voz_05;  Laye_Voz_05; Inst_Voz_05; Modo_Voz_05; Temp_Voz_05; Meto_Voz_05; Pos_05;  Pul_05;  Per_05;  Rit_05; Fes_05;}
Orquestra_06      :row {Voz_06;  Laye_Voz_06; Inst_Voz_06; Modo_Voz_06; Temp_Voz_06; Meto_Voz_06; Pos_06;  Pul_06;  Per_06;  Rit_06; Fes_06;}
Orquestra_07      :row {Voz_07;  Laye_Voz_07; Inst_Voz_07; Modo_Voz_07; Temp_Voz_07; Meto_Voz_07; Pos_07;  Pul_07;  Per_07;  Rit_07; Fes_07;}
Orquestra_08      :row {Voz_08;  Laye_Voz_08; Inst_Voz_08; Modo_Voz_08; Temp_Voz_08; Meto_Voz_08; Pos_08;  Pul_08;  Per_08;  Rit_08; Fes_08;}
Orquestra_09      :row {Voz_09;  Laye_Voz_09; Inst_Voz_09; Modo_Voz_09; Temp_Voz_09; Meto_Voz_09; Pos_09;  Pul_09;  Per_09;  Rit_09; Fes_09;}

Orquestra         :column { Titulos;
                            Orquestra_00;
                            Orquestra_01;
                            Orquestra_02;
                            Orquestra_03;
                            Orquestra_04;
                            Orquestra_05;
                            Orquestra_06;
                            Orquestra_07;
                            Orquestra_08;
                            Orquestra_09;
                         }
                                                        
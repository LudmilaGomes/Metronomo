O funcionamento esperado do módulo 'metronomo' seria o output, que armazena dois bits,
ter esses valores variando em 0 e 1, 1 e 0, ou seja, os bits alternando em high e low, e
quando um bit está em high, o outro está em low. E é isso que testamos no testbench.

Então instanciamos o módulo 'metronomo' e a ideia é comparar a saída do metronomo
com a variável 'exp-out' do teste. Essa variável funciona da mesma forma que a saída 
adequada do metronomo, ou seja, dois bits que alternam em high e low, que ora são 
0 e 1, ora 1 e 0, e variam dessa forma com o tempo. Usamos a 'exp-out' no teste
pra comparar com o valor da saída, como já foi dito. 

Testamos em dois momentos: 
Testamos pra quando o reset é ativado e vemos se o valor inicial de 'leds_out'
é igual a 'exp_out'. No caso, o valor inicial pra quando o reset é ativado tem
de ser [0, 1]. Então, se 'leds_out' é igual a 'exp_out', o 'metronomo' está correto
e funcionando da forma esperada. Caso contrário, indicamos que é um erro no teste.

Também testamos no momento de funcionamento normal do circuito e vemos se, com a
variação do tempo, os valores de 'leds_out' se alternam corretamente entre [0, 1] e [1, 0].
Da mesma forma, comparamos 'leds_out' com 'exp_out' e, se forem diferentes, o teste
acusa que está errado.

Indicamos [ERRO] quando o código não funciona da forma esperada e [INFO] quando funciona
da forma correta. Mostramos o momento do tempo e o valor de 'leds_out' no teste.

O teste simula os leds que alternam dessa forma no metrônomo, no código para a FPGA.

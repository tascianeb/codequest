# FAQ (Frequently Asked Questions) - CodeQuest: A Jornada do Desenvolvedor

## SEÇÃO 1: DÚVIDAS DO USUÁRIO (ALUNO / JOGADOR)

<details>
<summary><b>1. Como faço para criar uma conta e começar a usar o CodeQuest?</b></summary>
<br>
É muito simples! Basta abrir o aplicativo e realizar o seu cadastro informando seu nome, um e-mail válido e uma senha. O sistema validará se o e-mail é único e você poderá começar sua jornada em menos de 3 minutos, sem precisar de suporte externo.
</details>

<details>
<summary><b>2. Esqueci minha senha. Como posso recuperá-la?</b></summary>
<br>
Na tela de login, clique na opção de recuperação de senha. Um link seguro será enviado diretamente para o seu e-mail cadastrado para que você possa redefinir sua credencial.
</details>

<details>
<summary><b>3. Posso personalizar o meu perfil dentro do aplicativo?</b></summary>
<br>
Sim! Você pode acessar a área de perfil para editar seu nome, foto e biografia. Além disso, ao conquistar os três primeiros lugares de cada liga no Ranking, você ganhará avatares exclusivos como recompensa.
</details>


### Trilhas e Progressão

<details>
<summary><b>4. Como funcionam as Trilhas de Aprendizado?</b></summary>
<br>
O aprendizado no CodeQuest é estruturado como um mapa visual em formato vertical (ou zig-zag), onde cada nó (node) representa um nível de atividade focado em temas específicos como lógica, variáveis e loops.
</details>

<details>
<summary><b>5. Posso pular níveis ou estudar mais de uma trilha ao mesmo tempo?</b></summary>
<br>
Não. A progressão do aplicativo é estritamente linear para garantir o aprendizado progressivo. Você deve concluir o nível atual com desempenho mínimo para desbloquear o próximo nível. Além disso, o sistema não permite cursar múltiplas trilhas simultaneamente.
</details>

<details>
<summary><b>6. Se eu ficar um tempo sem jogar, posso perder o progresso das lições já feitas?</b></summary>
<br>
Não se preocupe. O sistema não possui regressão de progresso. Unidades concluídas permanecem salvas para sempre e nunca serão reiniciadas por inatividade.
</details>


### Atividades e Exercícios

<details>
<summary><b>7. Que tipos de exercícios encontrarei nas lições?</b></summary>
<br>
O CodeQuest possui formatos variados para testar suas habilidades: explicações teóricas rápidas, questões no estilo Quiz (múltipla escolha), preenchimento de lacunas de código, ordenação de linhas de código embaralhadas e o sistema de arrastar blocos (<i>drag-and-drop</i>).
</details>

<details>
<summary><b>8. O que acontece se eu errar muitas questões?</b></summary>
<br>
O aplicativo utiliza um sistema de vidas que são deduzidas a cada erro. Porém, o sistema rastreia automaticamente seus erros recorrentes para gerar sessões de revisão personalizadas e oferece dicas curtas para te ajudar a superar os desafios.
</details>


### Ranking e Competição

<details>
<summary><b>9. Como ganho pontos e subo no Ranking?</b></summary>
<br>
Você acumula Pontos de Experiência (XP) realizando as tarefas, concluindo níveis e mantendo uma sequência de dias consecutivos de uso (<i>streak</i>). O ranking é updated instantaneamente assim que você termina uma partida.
</details>

<details>
<summary><b>10. O que são as Ligas e como faço para subir de nível nelas?</b></summary>
<br>
Os usuários são divididos em quatro ligas competitivas: Bronze, Prata, Ouro e Diamante. Para ser promovido para a liga superior, você precisa terminar o ciclo competitivo (que é semanal) no Top 15 da sua liga atual.
</details>


## SEÇÃO 2: MAPEAMENTO TÉCNICO E DE ESCOPO (DEV & NEGÓCIO)


<details>
<summary><b>11. O usuário poderá programar livremente (ambiente Sandbox) ou criar suas próprias trilhas?</b></summary>
<br>
<b>Não.</b> O aplicativo não oferece ambiente Sandbox para código livre. Todas as atividades são fechadas para permitir validação automatizada e imediata. Além disso, ferramentas de criação de conteúdo e trilhas são exclusivas para administradores e professores; alunos não criam conteúdo.
</details>

<details>
<summary><b>12. Haverá suporte para chat entre os alunos ou mentoria humana?</b></summary>
<br>
<b>Não.</b> Está explicitamente fora do escopo a criação de fóruns, chats de comunicação direta entre usuários ou correção de respostas descritivas. Toda a correção e a entrega de dicas são 100% automatizadas pelo sistema para garantir escalabilidade.
</details>

<details>
<summary><b>13. O sistema emite certificados oficiais de conclusão?</b></summary>
<br>
<b>Não.</b> O aplicativo é voltado para o engajamento e a fixação de conhecimento técnico através da gamificação, não sendo responsável pela emissão de certificados ou diplomas acadêmicos oficiais.
</details>


### Regras de Negócio Importantes

<details>
<summary><b>14. Como deve se comportar o sistema caso o usuário jogue sem conexão com a internet (Offline)?</b></summary>
<br>
<b>Quando estiver offline, o sistema deve exibir apenas as informações do próprio usuário. A pontuação obtida na partida deve ser armazenada localmente no dispositivo e, assim que a conexão for restabelecida, o app deve enviar automaticamente os dados para o banco online (Firebase).
</details>

<details>
<summary><b>15. Qual é a regra para o reset do Ranking?</b></summary>
<br>
<b>O Ranking Geral não é estático. A pontuação dos usuários deve ser reiniciada de forma cíclica e programada (por padrão, uma rotina semanal) para manter a competitividade ativa entre as ligas.
</details>


### Requisitos Não Funcionais Críticos

<details>
<summary><b>16. Quais são os limites de tempo de resposta esperados para as interações na tela?</b></summary>
<br>
O time de desenvolvimento deve se atentar aos seguintes limites estipulados nos requisitos não funcionais:
<ul>
  <li>Carregamento de uma nova questão da lição: <b>Máximo 1 segundo</b></li>
  <li>Validação de respostas (<i>drag-and-drop</i>, múltipla escolha): <b>Máximo 1 segundo</b></li>
  <li>Renderização do mapa da trilha (conexão 4G): <b>Máximo 2 segundos</b></li>
  <li>Endpoint de autenticação/login: <b>Máximo 2 segundos</b></li>
</ul>
</details>

<details>
<summary><b>17. Como o sistema deve garantir a segurança dos dados e o cumprimento da LGPD?</b></summary>
<br>
<b>As senhas dos usuários jamais podem ser salvas em texto puro; devem obrigatoriamente utilizar criptografia hash com Salt através do algoritmo <b>bcrypt</b>. Todos os dados sensíveis devem ser protegidos em repouso com padrão <b>AES 256</b> e em trânsito via <b>TLS 1.2+</b>.
</details>

<details>
<summary><b>18. Qual é a tolerância a falhas para salvamento de progresso e indisponibilidade?</b></summary>
<br>
A taxa de falha permitida para o salvamento automático do progresso após interações relevantes deve ser <b>inferior a 0,1%</b>. O uptime (disponibilidade) mensal esperado para o módulo de usuários é de <b>99,5%</b> e para atividades é de <b>99,9%</b>.
</details>

<sub>FAQ gerado automaticamente para o projeto CodeQuest </sub>
 HEAD
# BarioniSociedade

Site da Willian Barioni Sociedade de Advocacia.

Esta é a base principal do projeto. O ano de fundação confirmado do escritório é **2024**.

## Abrir no VS Code

Abra **BarioniSociedade.code-workspace** para carregar o projeto com esse nome e ocultar arquivos temporários. O workspace usa caminhos relativos; se necessário, escolha um interpretador Python instalado com **Python: Select Interpreter**.

No menu **Terminal → Executar Tarefa**, estão os comandos para iniciar o site, verificar referências e gerar a publicação. **Ctrl+Shift+B** gera o pacote de publicação. Se o servidor já estiver rodando, acesse `http://localhost:8000`.

## Executar

Dê dois cliques em [scripts/development/INICIAR_SERVIDOR.bat](scripts/development/INICIAR_SERVIDOR.bat) e acesse **http://localhost:8000**. O iniciador usa `.venv` quando disponível e tenta o Python do sistema como alternativa. A página `index.html` abre o site em `lang/pt/index.html`.

Pelo PowerShell, na pasta do projeto:

```powershell
python scripts/development/start_server.py
```

Mantenha o servidor aberto durante o uso. Pressione **Ctrl+C** para encerrá-lo. Para usar outra porta sem abrir o navegador:

```powershell
python scripts/development/start_server.py --port 8001 --no-browser
```

O servidor atende apenas neste computador, desativa cache e bloqueia arquivos internos e listagens de diretórios.

## Recursos atuais

- Identidade em azul-marinho e dourado, com monograma WB e efeito ao passar o mouse.
- Menu serifado e layout adaptado para celular, tablet e computador.
- Equipe: Willian Barioni, Daniella Souza, Luiz Carlos Marconato Junior e Fernanda Camargo.
- Transições de saída (160 ms) e entrada (360 ms), respeitando a preferência por movimento reduzido.
- Formulário que prepara uma mensagem para o WhatsApp; o visitante confere e confirma o envio no aplicativo.
- Contato com painel institucional animado, prévia da mensagem durante o preenchimento, progresso e contador de caracteres.
- Links das áreas de atuação preenchem o assunto do contato; no celular, um botão fixo facilita o acesso ao WhatsApp.
- Retratos responsivos em WebP, imagem institucional de compartilhamento e perfis com endereços atualizados.
- Metadados e mapa do site preparados para **https://barionisociedade.com.br**.

## Estrutura

- `lang/pt/`: 11 páginas canônicas e três páginas de compatibilidade para endereços antigos.
- `assets/`: fotos originais, variantes WebP, imagem de compartilhamento, monograma e ícone.
- `css/style.css`: identidade visual e responsividade.
- `css/page-transitions.css`: animações entre páginas.
- `css/contact-experience.css`: painel de contato, animações e composição do formulário.
- `js/`: navegação, transições e formulário de contato.
- `config/dados.json`: dados do escritório, profissionais e serviços.
- `config/site-config.json`: configuração do domínio (`base_url` e `nome_dominio`).
- `scripts/build_site.py`: gera páginas com cabeçalho, rodapé e metadados compartilhados.
- `scripts/site_content.py`: valida e formata os dados compartilhados.
- `scripts/prepare_assets.py`: gera imagens; `scripts/assets-state.json` guarda o cache por hashes.
- `scripts/development/`: servidor local, iniciadores e verificador de referências.
- `scripts/verification/`: verificações de conteúdo, navegação, contato e segurança.
- `scripts/deployment/`: empacotamento e configuração Apache.
- `dist/`: saída gerada para publicação.
- `docs/`: documentação complementar e capturas de revisão.
- `scripts/site_policy.py`: lista dos arquivos públicos e proteções compartilhadas.
- `scripts/deployment/hosting_config.py`: configuração de segurança para Apache.

## Atualizar conteúdo

Edite `config/dados.json` para atualizar o escritório, os profissionais e os serviços. Use `config/site-config.json` somente para o domínio. A estrutura das páginas e os demais textos ficam em `scripts/build_site.py`.

| Dados | Onde editar em `config/dados.json` |
| --- | --- |
| Fundação e apresentação | `informacoes_escritorio.ano_fundacao`, `nome`, `nome_curto`, `subtitulo`, `descricao` |
| Localização | `endereco`, `bairro`, `cidade`, `estado`, `estado_nome`, `cep`, dentro de `informacoes_escritorio` |
| Atendimento | `telefone`, `whatsapp`, `email`, `redes_sociais` e `horario_funcionamento`, dentro de `informacoes_escritorio` |
| Perfil profissional | `nome`, `funcao`, `especialidade`, `biografia`, `temas`, `formacao`, `inscricao_oab` e `redes_sociais`, em cada item de `advogados` |
| Ordem, endereço e fotos do perfil | `ordem`, `pagina`, `foto` e `imagem_base`, em cada profissional |
| Áreas de atuação | `titulo`, `descricao`, `slug` e `detalhes`, em cada item de `servicos` |

Os horários usam `HH:MM - HH:MM` ou `Fechado`, nos grupos `segunda`, `terca_sexta`, `sabado` e `domingo`. O WhatsApp deve conter apenas dígitos, incluindo país e DDD.

Nos profissionais, cada campo de contato (`telefone`, `whatsapp` e `email`) com valor `null` herda o dado do escritório. Luiz conserva seus contatos específicos. Deixe `formacao` como `[]` e `inscricao_oab` como `null` enquanto não houver informações fornecidas pelo escritório; esses campos vazios não são exibidos.

`pagina` define o nome canônico do HTML; `foto` identifica o JPEG original em `assets/`; `imagem_base` define o prefixo das variantes WebP. Preserve os identificadores existentes, incluindo `id: 1` para o fundador. Novas páginas ou nomes de arquivos exigem atualização deliberada de `PUBLIC_FILES` em `scripts/site_policy.py`; para trocar uma URL existente, atualize também os redirecionamentos.

Para aplicar as alterações (Python 3.9 ou superior):

```powershell
python scripts/build_site.py
```

O gerador chama automaticamente `ensure_assets`, de `scripts/prepare_assets.py`. São produzidos WebP de 360 e 720 pixels de largura e `assets/social-card.png`, de 1200 × 630 pixels. Os JPEGs originais ficam disponíveis como alternativa.

O cache em `scripts/assets-state.json` evita regenerações desnecessárias. Alterações nas fotos ou nos dados visuais da imagem institucional, como ano e cidade, exigem **Playwright para Python e Microsoft Edge** no ambiente de desenvolvimento. Com imagens e cache atualizados, o build usa apenas a biblioteca padrão do Python.

Alterações diretas no HTML gerado são substituídas ao executar o gerador. Os links de CSS e JavaScript recebem uma versão baseada no conteúdo, para evitar cache desatualizado.

## Conferir a prévia

Abra [http://localhost:8000](http://localhost:8000) com o servidor rodando. O [relatório da revisão](docs/review/REVISAO.md) reúne as mudanças e as capturas de [celular](docs/review/previa-390.png), [computador](docs/review/previa-1440.png) e [contato](docs/review/previa-contato.png). Essas capturas são materiais locais: não são atualizadas pelo build, servidas pelo servidor ou incluídas no pacote público.

## Verificar

Execute as verificações na pasta do projeto:

```powershell
python scripts/development/check_html_refs.py
python scripts/verification/verify_site.py
python scripts/verification/verify_contact_context.py
python scripts/verification/verify_contact_experience.py
python scripts/verification/verify_security.py
python scripts/verification/verify_content.py
```

- `scripts/development/check_html_refs.py`: referências locais e âncoras.
- `scripts/verification/verify_site.py`: páginas em diferentes larguras, imagens responsivas, metadados, redirecionamentos, menu, teclado e formulário.
- `scripts/verification/verify_contact_context.py`: assunto selecionado pela área, mensagens de erro acessíveis e alternativa quando a janela do WhatsApp é bloqueada.
- `scripts/verification/verify_security.py`: cria seu próprio servidor temporário e verifica acessos, redirecionamentos, cabeçalhos e CSP.
- `scripts/verification/verify_content.py`: gera uma cópia temporária do site e altera dados de teste para conferir textos, metadados, contatos herdados, tratamento de caracteres HTML e atualização da imagem institucional. Não altera os dados do projeto.

Os testes `verify_site.py` e `verify_contact_context.py` usam o servidor em `localhost:8000`; `SITE_TEST_URL` permite escolher outra porta. Os testes de navegador e a regeneração de imagem no teste de conteúdo exigem Playwright e Edge. O WhatsApp é interceptado nos testes, sem envio de mensagens.

## Metadados técnicos

O JSON-LD reúne os dados em `@graph`: o escritório usa [LegalService](https://schema.org/LegalService), os perfis usam [ProfilePage](https://schema.org/ProfilePage) com uma pessoa como entidade principal, e os horários usam [openingHoursSpecification](https://schema.org/openingHoursSpecification). As páginas internas incluem a trilha de navegação. Esses dados acompanham `config/dados.json` e as URLs canônicas do domínio configurado.

## Publicar

```powershell
python scripts/deployment/package_site.py
```

O pacote contém somente os arquivos públicos autorizados e `.htaccess` com configuração para Apache 2.4. Siga [DEPLOY.md](DEPLOY.md) para publicação na KingHost e [docs/PUBLICACAO.md](docs/PUBLICACAO.md) para os detalhes técnicos da configuração.

Se mudar o domínio, atualize `config/site-config.json` e gere as páginas e o pacote novamente.

O site está disponível localmente. Domínio, DNS, HTTPS e hospedagem são configurados no provedor; gerar o pacote não envia o site à internet.
=======
# AdvBarioni
>>>>>>> 0107b5c565db66e290030a5378d989a8a3acdf5c

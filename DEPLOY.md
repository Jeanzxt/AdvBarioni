# Publicar na KingHost

## Requisitos

O site publicado é estático: HTML, CSS, JavaScript, SVG, WebP, JPEG e PNG. A hospedagem **não precisa de Node.js, PHP, banco de dados ou processo permanente**. O formulário prepara uma mensagem no navegador e abre o WhatsApp; o visitante ainda precisa revisar e confirmar o envio no aplicativo. Não há endpoint próprio para receber formulários.

O pacote inclui `.htaccess` para **Apache 2.4**. Antes de usá-lo, confirme no plano/servidor KingHost escolhido:

- Apache 2.4 com leitura de `.htaccess` e `AllowOverride` habilitado;
- módulos `mod_rewrite` e `mod_headers`;
- suporte à configuração de compressão incluída no arquivo;
- certificado HTTPS válido para o domínio principal e, se usado, `www`.

Os recursos e módulos disponíveis variam por plano. Se o servidor não for Apache compatível, não envie o `.htaccess` esperando que suas regras sejam aplicadas: peça à KingHost as regras equivalentes para redirects, HTTPS, cabeçalhos e compressão. Python 3.9+ é necessário somente no computador de desenvolvimento para gerar o pacote.

## 1. Conferir os dados e o domínio

1. Revise contatos, endereço, horários e profissionais em `config/dados.json`.
2. Confira `base_url` em `config/site-config.json`. O valor atual é `https://barionisociedade.com.br`; isso não confirma registro, titularidade nem configuração do domínio.
3. Não preencha formação, OAB ou outros dados que ainda não tenham sido confirmados pelo escritório.

## 2. Gerar o pacote de produção

Abra o PowerShell na pasta do projeto e execute:

```powershell
python scripts/deployment/package_site.py
```

O comando compila as páginas estáticas, verifica referências internas e cria:

```text
dist/barionisociedade-site.zip
```

O ZIP contém apenas os arquivos públicos autorizados e `.htaccess`; dados de configuração, documentação e ferramentas de desenvolvimento não são incluídos. Ele é validado quanto à lista de arquivos e integridade antes de substituir o pacote anterior.

O build comum usa Python 3 e a biblioteca padrão. Se uma imagem original ou a arte social estiver desatualizada, gerar esses arquivos requer Playwright para Python e Microsoft Edge instalados localmente. Isso não cria requisito de runtime na hospedagem.

## 3. Enviar os arquivos

1. Faça backup do conteúdo atual do document root.
2. Pelo Gerenciador de Arquivos da KingHost ou SFTP, localize o document root associado ao domínio (com frequência `public_html`; confirme o caminho no painel/plano).
3. Extraia `dist/barionisociedade-site.zip` no computador.
4. Envie **o conteúdo extraído** diretamente ao document root, preservando as pastas `assets/`, `css/`, `js/` e `lang/`. Não envie a pasta inteira do projeto, `config/`, `scripts/`, `docs/` ou a própria pasta `dist/`.
5. Garanta que o arquivo oculto `.htaccess` também foi enviado à raiz. Se o gerenciador não mostrar arquivos ocultos, habilite a exibição ou envie por SFTP.
6. Não substitua arquivos de e-mail, configurações da conta ou outros sites que compartilhem o mesmo espaço.

## 4. Domínio, DNS e HTTPS

Configure DNS e certificado manualmente no painel/provedor. Use os registros indicados pela KingHost e preserve os registros existentes de e-mail. Emita/ative o certificado antes de exigir HTTPS. O `.htaccess` redireciona `www` para o domínio sem `www` e HTTP para HTTPS; não o ative com certificado ausente nem atrás de proxy em modo TLS flexível.

O pacote não altera DNS, credenciais, certificado ou arquivos no servidor automaticamente.

## 5. Validar a publicação

Depois de o domínio apontar para a hospedagem e o certificado estar ativo, verifique:

- `https://barionisociedade.com.br/` e as páginas em `/lang/pt/`;
- HTTP redireciona uma única vez para HTTPS; `www` vai ao domínio canônico;
- os três endereços antigos de perfis redirecionam para os atuais;
- uma URL inexistente retorna HTTP 404;
- imagens, menu, links de contato e layout funcionam em celular e desktop;
- o navegador não registra erros de JavaScript nem violações de CSP;
- o formulário abre o link correto de WhatsApp, sem enviar a mensagem automaticamente;
- a resposta inclui os cabeçalhos de segurança esperados e aplica compressão;
- `/.git/`, `/config/`, `/scripts/` e `/dist/` não expõem arquivos.

Se `.htaccess` for ignorado ou causar erro 500, restaure o backup e peça à hospedagem as diretivas equivalentes antes de tentar novamente. `dist/cabecalhos-http.json` documenta os cabeçalhos esperados, mas não configura outros servidores automaticamente.

O GitHub Pages pode continuar servindo a cópia atual enquanto ela for necessária. Os arquivos públicos mantêm caminhos relativos para funcionar tanto sob o prefixo do repositório quanto no domínio raiz; os metadados canônicos permanecem definidos pelo domínio em `config/site-config.json`.

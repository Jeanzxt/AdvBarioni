# Revisão do projeto — 23 de novembro de 2026

## Alterações revisadas

- Setas textuais substituídas por SVGs inline acessíveis, incluindo links externos, retorno ao topo, âncora de seção e retorno da página de perfil.
- Dados privados de build em `config/`; scripts separados em `development/`, `verification/` e `deployment/`; documentação e capturas em `docs/`; pacote gerado em `dist/`.
- HTMLs públicos, recursos e rotas mantidos na raiz para preservar o GitHub Pages e o domínio próprio.
- Capturas móveis e desktop atualizadas após a troca dos ícones.

## Otimização e conteúdo

- Retratos WebP responsivos: quatro arquivos de 720 px totalizam 158.074 bytes; quatro de 360 px, 61.326 bytes. Os JPEGs originais permanecem.
- Metadados canônicos, Open Graph, Schema.org, sitemap e robots.txt usam o domínio configurado e os dados disponíveis em `config/dados.json`.
- Sem bibliotecas JavaScript de runtime, fontes externas, backend, banco de dados ou envio automático do formulário.

## Verificação

- Build: 11 páginas canônicas geradas; verificador conferiu 16 páginas/rotas HTML e referências, sem problemas.
- Navegador: 11 páginas em 10 larguras (320, 360, 375, 390, 414, 640, 768, 900, 1024 e 1440 px): **110 combinações**, sem overflow horizontal nem erros JavaScript.
- Setas SVG verificadas nas páginas; nenhum caractere de seta permanece no texto de interface.
- Três redirecionamentos de perfis, menu responsivo, teclado, FAQ, imagens, metadados, formulário e alternativa sem JavaScript testados.
- Segurança local: 40 arquivos públicos, três redirecionamentos e 27 caminhos privados/inexistentes testados; CSP e cabeçalhos verificados. Nenhuma mensagem foi enviada.
- Conteúdo: dois builds em cópia temporária validaram dados, metadados, contatos herdados e edição de texto sem modificar a fonte.
- Pacote da hospedagem: ZIP e lista de arquivos conferidos; inclui os recursos públicos e `.htaccess`.

## Capturas

- [Prévia mobile — 390 px](previa-390.png)
- [Prévia desktop — 1440 px](previa-1440.png)
- [Contato mobile — área selecionada](previa-contato.png)

## Pendências externas

O pacote ainda não foi enviado à KingHost. O plano precisa ser confirmado quanto a Apache 2.4, `.htaccess`, `mod_rewrite`, `mod_headers` e compressão. Domínio, DNS, certificado HTTPS e cabeçalhos efetivamente entregues só podem ser validados depois da configuração no provedor. Veja [DEPLOY.md](../../DEPLOY.md).

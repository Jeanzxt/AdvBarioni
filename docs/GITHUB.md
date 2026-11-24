# Publicação no GitHub Pages

Os arquivos públicos permanecem na raiz do projeto para que o GitHub Pages e a hospedagem em domínio próprio sirvam o mesmo HTML, CSS, JavaScript e imagens. O site não precisa de Node.js, PHP ou banco de dados em produção.

## Pastas

- `assets/`, `css/`, `js/` e `lang/pt/`: recursos públicos.
- `config/`: dados institucionais e domínio usados apenas pelo build.
- `scripts/`: build e ferramentas separadas em `development/`, `verification/` e `deployment/`.
- `docs/`: documentação e material de revisão.
- `dist/`: pacote gerado localmente; não deve ser publicado como pasta.

## Build e verificações

Na raiz do projeto, com Python 3:

```powershell
python scripts/build_site.py
python scripts/development/check_html_refs.py
python scripts/deployment/package_site.py
```

O build gera HTMLs na pasta pública `lang/pt/`. Para GitHub Pages, publique os arquivos da raiz pública do site, sem incluir `config/`, `scripts/` ou `dist/`. `index.html`, `robots.txt` e `sitemap.xml` permanecem na raiz para preservar URLs e a descoberta pelos buscadores.

O domínio canônico está definido em `config/site-config.json`. Antes de manter uma publicação temporária no endereço `*.github.io`, ajuste esse domínio no arquivo de configuração e gere novamente as páginas, o sitemap e o pacote. Não configure DNS ou certificado automaticamente.

O verificador do servidor local permite apenas os arquivos explicitamente listados em `scripts/site_policy.py`; os dados de configuração, documentação e ferramentas não são servidos.

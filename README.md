# agenticmem.co

Public site for **AgenticMem** (AlphaOne LLC).

Static HTML. Deployed to Cloudflare Pages (`agentic-mem`) on `www.agenticmem.co`.

## Local preview

```bash
python3 -m http.server 8080
# open http://localhost:8080
```

## Deploy

Requires `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` in `~/.env`.

```bash
set -a; source ~/.env; set +a
npx wrangler pages deploy . --project-name=agentic-mem --branch=main --commit-dirty=true
```

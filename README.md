# agenticmem.co

Public site for **AgenticMem** (AlphaOne LLC).

Static HTML. Deployed to Cloudflare Pages (`agentic-mem`) on `www.agenticmem.co`.

## Local preview

```bash
python3 -m http.server 8080
# open http://localhost:8080
```

## Deploy

Needs a Cloudflare API token with Pages edit permission for the `agentic-mem` project, and the
account ID, exported as `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID` from the operator's
secret store. Never commit either value, and never commit `.wrangler/` (it caches account data).

Deploy only the site files (not the README or git metadata):

```bash
mkdir -p ../agenticmem-deploy && cp index.html engineering-scheme.html favicon.svg _headers ../agenticmem-deploy/
cd ../agenticmem-deploy && npx wrangler pages deploy . --project-name=agentic-mem --branch=main --commit-dirty=true
```

# Security Standard

- Do not commit secrets.
- Prefer provider CLIs, OS credential stores, or short-lived session environment variables for local secrets.
- Do not store long-lived GitHub tokens in project `.env` files.
- Minimize data collection.
- Explain third-party data sharing.
- Check authentication, authorization, and permissions when relevant.
- Review deployment surfaces before shipping.
- Review browser/webview security surfaces when relevant, including CSP, link protocols, and local file access.
- Run a secret scan before publishing or pushing when credentials were used during the project.

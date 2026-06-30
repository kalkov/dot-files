# Machine Context

Owner: Vassil Kalkov (vassil.k@santiment.net)

Two work contexts on this machine:
- **Santiment DevOps** — infra/k8s at `~/work/santiment/devops`
- **Personal (terrarino)** — personal cluster and scrapers at `~/code/`

## Kubernetes Clusters

Shell helpers (from `~/.santiment`) switch context and optionally the AWS profile:

| Helper | kubectl context | AWS profile |
|--------|----------------|-------------|
| `san-ku-aws-prod` | aws-prod | santiment |
| `san-ku-aws-stage` | k8s-stage.internal.santiment.net | — |
| `san-ku-hetzner-prod` | hetzner-prod-v2 | — |
| `san-ku-hetzner-stage` | hetzner-stage-v2 | — |
| `san-ku-blockchain` | blockchain | — |
| `ku-terrarino` | terrarino | personal |

## Vault Access

```bash
vault-ctx <cluster> <vault args>
```

Clusters: `system`, `aws-prod`, `aws-stage`, `hetzner-stage`, `hetzner-prod`

- Credentials in `~/.config/vault/<cluster>.env` (never in any repo)
- `aws-prod`/`aws-stage` reachable via VPN at port 31080; hetzner clusters at port 32080; `system` via port-forward
- All clusters use `vassil.k` userpass with admin policy

## AWS

Profiles (region `eu-central-1`):
- `santiment` — Santiment AWS account
- `personal` — personal account (used for terrarino cluster)

Switch: `san-aws-prod` / `san-aws-personal`

## VPN

```bash
san-wg-prod-up / san-wg-prod-down    # Santiment prod
san-wg-stage-up / san-wg-stage-down  # Santiment stage
san-wg-down                          # bring both down
```

VPN must be active to reach cluster-internal Vault URLs and ingresses.

## Dotfiles

Managed at `~/dot-files` (github.com/kalkov/dot-files).
After any change: commit and push so other machines stay in sync.

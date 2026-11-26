# 5h3rr1ll/homebrew-tap

Homebrew formulae for [5h3rr1ll](https://github.com/5h3rr1ll)'s tools.

```bash
brew install 5h3rr1ll/tap/<formula>
```

| Formula | Description |
|---|---|
| [acab](https://github.com/5h3rr1ll/acab) | Switch between multiple AWS config files and profiles with fzf |

## Releasing a new version (acab)

```bash
TAG=v1.2.3
curl -sL https://github.com/5h3rr1ll/acab/archive/refs/tags/$TAG.tar.gz | shasum -a 256
# update url + sha256 in Formula/acab.rb, then:
brew audit --strict --online 5h3rr1ll/tap/acab && brew install --build-from-source 5h3rr1ll/tap/acab && brew test acab
```

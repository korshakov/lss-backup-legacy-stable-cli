# lss-backup

More information coming soon. This is an early-stage release candidate.

## Documentation
- User guide: `docs/user-guide.txt`
- Exit codes: `docs/exit-codes.txt`

## Install
Make sure you are downloading the latest release.
```
cd /etc
wget https://github.com/korshakov/lss-backup-legacy-stable-cli/archive/refs/tags/Legacy-1.0.zip
unzip Legacy-1.0.zip
mv lss-backup-legacy-stable-cli-Legacy-1.0 lss-backup
cd lss-backup
chmod +x *.sh
chmod +x functions/*.sh prep-dependencies/*.sh.prep
bash install-lss-backup.sh
```

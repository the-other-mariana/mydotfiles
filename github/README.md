# Github Useful Commands

## Create SSH keys

1. Create and enter `.ssh` folder:

```bash
mkdir -p ~/.ssh
cd .ssh
```

2. Create ssh key pairs:

```bash
ssh-keygen -o -t rsa -C "mariana.avalos.arce@gmail.com"
```
3. Display the contents of your public key (`.pub`) file:

```bash
cat id_rsa.pub
```
4. Copy them and go to https://github.com/settings/keys

5. Create a new SSH Key and paste the public key content.


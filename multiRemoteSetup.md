# Setting up to use different remotes for work/private repos

## For .ssh/config
```
Host work
	HostName ssh.dev.azure.com
	IdentityFile ~/.ssh/id_rsa

Host private
	HostName github.com
	IdentityFile ~/.ssh/private
```

## Remote on repository example

Use the name specified after "Host" in .ssh/config.

```
origin  git@private:lumikrynd/DiverseConfigs.git
```

# Configuring different name and email for private and work commits

## For global git config

```
[includeif "hasconfig:remote.*.url:git@work:*/**"]
	path = .config/git/workuser.gitconfig

[includeif "hasconfig:remote.*.url:git@private:*/**"]
	path = .config/git/privateuser.gitconfig
```

## Example .config/git/privateuser.gitconfig
```
[user]
	name = Lumikrynd
	email = WhatIsEmail?
```
